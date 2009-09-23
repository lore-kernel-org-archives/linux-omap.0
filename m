From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCHv2 4/5] DSPBRIDGE: OSAL: Implement registry as linked list
Date: Wed, 23 Sep 2009 19:03:22 +0300
Message-ID: <1253721804-22816-5-git-send-email-andy.shevchenko@gmail.com>
References: <1253721804-22816-1-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-2-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-3-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-4-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40730 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbZIWQDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 12:03:36 -0400
In-Reply-To: <1253721804-22816-4-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@Nokia.com, Andy Shevchenko <ext-andriy.shevchenko@Nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Change implementation of registry to a linked list.

In future this will became to some static structures and probably list for
DCD_REGKEY array.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/services/regsup.c |  216 +++++++++++-----------------------
 drivers/dsp/bridge/services/regsup.h |    3 -
 2 files changed, 70 insertions(+), 149 deletions(-)

diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index e40d989..71651a8 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -42,27 +42,21 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/mem.h>
+#include <dspbridge/list.h>
 
 /*  ----------------------------------- This */
 #include <regsup.h>
 
-struct RegValueStruct {
-	char name[BRIDGE_MAX_NAME_SIZE];   /*  Name of a given value entry  */
+struct RegValue {
+	struct list_head link;	/* Make it linked to a list */
+	char name[MAXREGPATHLENGTH];	/*  Name of a given value entry  */
 	u32 dataSize;		/*  Size of the data  */
 	void *pData;		/*  Pointer to the actual data  */
 	int counter; 		/* Number of register attempts for this key */
 };
 
-struct RegKeyStruct {
-	/*The current number of value entries this key has*/
-	u32 numValueEntries;
-	/* Array of value entries */
-	struct RegValueStruct values[BRIDGE_MAX_NUM_REG_ENTRIES];
-};
-
-
 /*  Pointer to the registry support key  */
-static struct RegKeyStruct *pRegKey;
+static struct LST_LIST regKey, *pRegKey = &regKey;
 
 #if GT_TRACE
 extern struct GT_Mask REG_debugMask;	/* GT trace var. */
@@ -95,14 +89,7 @@ static inline void printS(void *pBuf)
  */
 bool regsupInit(void)
 {
-	if (pRegKey != NULL)
-		return true;
-
-	/*  Need to allocate and setup our registry.  */
-	pRegKey = MEM_Calloc(sizeof(struct RegKeyStruct), MEM_NONPAGED);
-	if (pRegKey == NULL)
-		return false;
-
+	INIT_LIST_HEAD(&pRegKey->head);
 	return true;
 }
 
@@ -113,41 +100,12 @@ bool regsupInit(void)
  */
 void regsupExit(void)
 {
-	u32 i;
-
-	/*  Make sure data has actually been allocated.  */
-	if (pRegKey == NULL) {
-		/*  Nothing initialized.return!  */
-		return;
-	}
-
-	GT_1trace(REG_debugMask, GT_2CLASS, "pRegKey->numValueEntries %d\n",
-		  pRegKey->numValueEntries);
-
 	/*  Now go through each entry and free all resources.  */
-	for (i = 0; ((i < BRIDGE_MAX_NUM_REG_ENTRIES) &&
-	    (i < pRegKey->numValueEntries)); i++) {
-		if (pRegKey->values[i].name[0] != '\0') {
-			/*  We have a valid entry.free it up!  */
-			if (pRegKey->values[i].pData != NULL) {
-				GT_3trace(REG_debugMask, GT_2CLASS,
-					  "E %d\t %s DATA %x ", i,
-					  pRegKey->values[i].name,
-					  *(u32 *)pRegKey->values[i].pData);
-				printS((u8 *)(pRegKey->values[i].pData));
-				MEM_Free(pRegKey->values[i].pData);
-			}
-			pRegKey->values[i].pData = NULL;
-			pRegKey->values[i].dataSize = 0;
-			pRegKey->values[i].name[0] = '\0';
-		}
+	while (!LST_IsEmpty(pRegKey)) {
+		struct RegValue *rv = (struct RegValue *)LST_GetHead(pRegKey);
+		MEM_Free(rv->pData);
+		MEM_Free(rv);
 	}
-
-	/*  Now that all of the resources are freed up, free the main one!  */
-	MEM_Free(pRegKey);
-
-	/*  Don't forget to NULL out the global entry!  */
-	pRegKey = NULL;
 }
 
 /*
@@ -158,25 +116,25 @@ void regsupExit(void)
 DSP_STATUS regsupGetValue(char *valName, void *pBuf, u32 *dataSize)
 {
 	DSP_STATUS retVal = DSP_EFAIL;
-	u32 i;
+	struct RegValue *rv = (struct RegValue *)LST_First(pRegKey);
 
 	/*  Need to search through the entries looking for the right one.  */
-	for (i = 0; i < pRegKey->numValueEntries; i++) {
+	while (rv) {
 		/*  See if the name matches.  */
-               if (strncmp(pRegKey->values[i].name, valName,
-		    BRIDGE_MAX_NAME_SIZE) == 0) {
-
+		if (strncmp(rv->name, valName, MAXREGPATHLENGTH) == 0) {
 			/*  We have a match!  Copy out the data.  */
-			memcpy(pBuf, pRegKey->values[i].pData,
-			       pRegKey->values[i].dataSize);
+			memcpy(pBuf, rv->pData, rv->dataSize);
 
 			/*  Get the size for the caller.  */
-			*dataSize = pRegKey->values[i].dataSize;
+			*dataSize = rv->dataSize;
 
 			/*  Set our status to good and exit.  */
 			retVal = DSP_SOK;
 			break;
 		}
+
+		rv = (struct RegValue *)LST_Next(pRegKey,
+						 (struct list_head *)rv);
 	}
 
 	if (DSP_SUCCEEDED(retVal)) {
@@ -198,69 +156,57 @@ DSP_STATUS regsupGetValue(char *valName, void *pBuf, u32 *dataSize)
 DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
 {
 	DSP_STATUS retVal = DSP_EFAIL;
-	u32 i;
+	struct RegValue *rv = (struct RegValue *)LST_First(pRegKey);
 
 	GT_2trace(REG_debugMask, GT_2CLASS, "S %s DATA %x ", valName,
 		  *(u32 *)pBuf);
 	printS((u8 *)pBuf);
 
 	/*  Need to search through the entries looking for the right one.  */
-	for (i = 0; i < pRegKey->numValueEntries; i++) {
+	while (rv) {
 		/*  See if the name matches.  */
-               if (strncmp(pRegKey->values[i].name, valName,
-		    BRIDGE_MAX_NAME_SIZE) == 0) {
+		if (strncmp(rv->name, valName, MAXREGPATHLENGTH) == 0) {
 			/*  Make sure the new data size is the same.  */
-			if (dataSize != pRegKey->values[i].dataSize) {
+			if (dataSize != rv->dataSize) {
 				/*  The caller needs a different data size!  */
-				MEM_Free(pRegKey->values[i].pData);
-				pRegKey->values[i].pData = MEM_Alloc(dataSize,
-							   MEM_NONPAGED);
-				if (pRegKey->values[i].pData == NULL)
+				MEM_Free(rv->pData);
+				rv->pData = MEM_Alloc(dataSize, MEM_NONPAGED);
+				if (rv->pData == NULL)
 					break;
 
 			}
 
 			/*  We have a match!  Copy out the data.  */
-			memcpy(pRegKey->values[i].pData, pBuf, dataSize);
+			memcpy(rv->pData, pBuf, dataSize);
 
 			/* Reset datasize - overwrite if new or same */
-			pRegKey->values[i].dataSize = dataSize;
+			rv->dataSize = dataSize;
 
 			/*  Set our status to good and exit.  */
 			retVal = DSP_SOK;
 			break;
 		}
+
+		rv = (struct RegValue *)LST_Next(pRegKey,
+						 (struct list_head *)rv);
 	}
 
 	/*  See if we found a match or if this is a new entry  */
-	if (i == pRegKey->numValueEntries) {
+	if (rv) {
+		/* Increase the counter to track the registered entry */
+		rv->counter++;
+	} else {
 		/*  No match, need to make a new entry  */
-		/*  First check to see if we can make any more entries.  */
-		if (pRegKey->numValueEntries < BRIDGE_MAX_NUM_REG_ENTRIES) {
-			char *tmp_name =
-				pRegKey->values[pRegKey->numValueEntries].name;
-			strncpy(tmp_name, valName, BRIDGE_MAX_NAME_SIZE - 1);
-			tmp_name[BRIDGE_MAX_NAME_SIZE - 1] = '\0';
-			pRegKey->values[pRegKey->numValueEntries].pData =
-					MEM_Alloc(dataSize, MEM_NONPAGED);
-			if (pRegKey->values[pRegKey->numValueEntries].pData !=
-									NULL) {
-				memcpy(pRegKey->
-					values[pRegKey->numValueEntries].pData,
-					pBuf, dataSize);
-				pRegKey->
-				    values[pRegKey->numValueEntries].dataSize =
-				    dataSize;
-				pRegKey->numValueEntries++;
-				retVal = DSP_SOK;
-			}
-		} else {
-			GT_0trace(REG_debugMask, GT_7CLASS,
-				  "MAX NUM REG ENTRIES REACHED\n");
+		struct RegValue *new = MEM_Calloc(sizeof(struct RegValue),
+						  MEM_NONPAGED);
+		strncat(new->name, valName, MAXREGPATHLENGTH - 1);
+		new->pData = MEM_Alloc(dataSize, MEM_NONPAGED);
+		if (new->pData != NULL) {
+			memcpy(new->pData, pBuf, dataSize);
+			new->dataSize = dataSize;
+			LST_PutTail(pRegKey, (struct list_head *)new);
+			retVal = DSP_SOK;
 		}
-	} else {
-		/* Increase the counter to track the registered entry */
-		pRegKey->values[i].counter++;
 	}
 
 	return retVal;
@@ -276,7 +222,7 @@ DSP_STATUS regsupEnumValue(IN u32 dwIndex, IN CONST char *pstrKey,
 			   IN OUT char *pstrData, IN OUT u32 *pdwDataSize)
 {
 	DSP_STATUS retVal = REG_E_INVALIDSUBKEY;
-	u32 i;
+	struct RegValue *rv = (struct RegValue *)LST_First(pRegKey);
        u32 dwKeyLen;
 	u32 count = 0;
 
@@ -284,28 +230,30 @@ DSP_STATUS regsupEnumValue(IN u32 dwIndex, IN CONST char *pstrKey,
        dwKeyLen = strlen(pstrKey);
 
 	/*  Need to search through the entries looking for the right one.  */
-	for (i = 0; i < pRegKey->numValueEntries; i++) {
+	while (rv) {
 		/*  See if the name matches.  */
-               if ((strncmp(pRegKey->values[i].name, pstrKey,
-		    dwKeyLen) == 0) && count++ == dwIndex) {
+		if (strncmp(rv->name, pstrKey, dwKeyLen) == 0 &&
+		    count++ == dwIndex) {
 			/*  We have a match!  Copy out the data.  */
-			memcpy(pstrData, pRegKey->values[i].pData,
-				pRegKey->values[i].dataSize);
+			memcpy(pstrData, rv->pData, rv->dataSize);
+
 			/*  Get the size for the caller.  */
-			*pdwDataSize = pRegKey->values[i].dataSize;
-                       *pdwValueSize = strlen(&(pRegKey->
-						values[i].name[dwKeyLen]));
-                       strncpy(pstrValue,
-				    &(pRegKey->values[i].name[dwKeyLen]),
-				    *pdwValueSize + 1);
+			*pdwDataSize = rv->dataSize;
+			*pdwValueSize = strlen(&(rv->name[dwKeyLen]));
+			strncpy(pstrValue, &(rv->name[dwKeyLen]),
+				*pdwValueSize + 1);
 			GT_3trace(REG_debugMask, GT_2CLASS,
 				  "E Key %s, Value %s, Data %x ",
 				  pstrKey, pstrValue, *(u32 *)pstrData);
 			printS((u8 *)pstrData);
+
 			/*  Set our status to good and exit.  */
 			retVal = DSP_SOK;
 			break;
 		}
+
+		rv = (struct RegValue *)LST_Next(pRegKey,
+						 (struct list_head *)rv);
 	}
 
 	if (count && DSP_FAILED(retVal))
@@ -320,67 +268,43 @@ DSP_STATUS regsupEnumValue(IN u32 dwIndex, IN CONST char *pstrKey,
 DSP_STATUS regsupDeleteValue(IN CONST char *pstrValue)
 {
 	DSP_STATUS retVal = DSP_EFAIL;
-	u32 i;
+	struct RegValue *rv = (struct RegValue *)LST_First(pRegKey);
 
-	for (i = 0; ((i < BRIDGE_MAX_NUM_REG_ENTRIES) &&
-	    (i < pRegKey->numValueEntries)); i++) {
-		/*  See if the name matches...  */
-               if (strncmp(pRegKey->values[i].name, pstrValue,
-		    BRIDGE_MAX_NAME_SIZE) == 0) {
+	while (rv) {
+		/*  See if the name matches.  */
+		if (strncmp(rv->name, pstrValue, MAXREGPATHLENGTH) == 0) {
 			/*
 			 * Check if registration counter is > 0, otherwise
 			 * delete the key
 			 */
-			if (pRegKey->values[i].counter > 0) {
+			if (rv->counter > 0) {
 				/*
 				 * We do not un-register this entry as another
 				 * object needs it.  Key Registration counter
 				 * takes care of the delta
 				 */
-				pRegKey->values[i].counter--;
+				rv->counter--;
 				goto func_cont;
 			}
 
 			/*
 			 * We have a match!  Delete this key.  To delete a
 			 * key, we free all resources associated with this
-			 * key and, if we're not already the last entry in
-			 * the array, we copy that entry into this deleted
 			 * key.
 			 */
-			MEM_Free(pRegKey->values[i].pData);
-			if ((pRegKey->numValueEntries - 1) == i) {
-				/* we're deleting the last one */
-				pRegKey->values[i].name[0] = '\0';
-				pRegKey->values[i].dataSize = 0;
-				pRegKey->values[i].pData = NULL;
-			} else {
-				/* move the last one here */
-                               strncpy(pRegKey->values[i].name, pRegKey->
-				    values[pRegKey->numValueEntries - 1].name,
-				    BRIDGE_MAX_NAME_SIZE);
-				pRegKey->values[i].dataSize =
-				    pRegKey->
-				    values[pRegKey->numValueEntries-1].dataSize;
-				pRegKey->values[i].pData =
-				    pRegKey->
-				    values[pRegKey->numValueEntries-1].pData;
-				/* don't have to do this, but for
-				 * the paranoid... */
-				pRegKey->
-				    values[pRegKey->numValueEntries-1].name[0] =
-				    '\0';
-			}
-
-			/* another one bites the dust. */
-			pRegKey->numValueEntries--;
+			LST_RemoveElem(pRegKey, rv);
+			MEM_Free(rv->pData);
+			MEM_Free(rv);
 func_cont:
 			/*  Set our status to good and exit...  */
 			retVal = DSP_SOK;
 			break;
 		}
+
+		rv = (struct RegValue *)LST_Next(pRegKey,
+						 (struct list_head *)rv);
 	}
-	return retVal;
 
+	return retVal;
 }
 
diff --git a/drivers/dsp/bridge/services/regsup.h b/drivers/dsp/bridge/services/regsup.h
index c4d9c2d..8dc1d8f 100644
--- a/drivers/dsp/bridge/services/regsup.h
+++ b/drivers/dsp/bridge/services/regsup.h
@@ -25,9 +25,6 @@
 #ifndef _REGSUP_H_
 #define _REGSUP_H_
 
-#define BRIDGE_MAX_NAME_SIZE                     MAXREGPATHLENGTH
-#define BRIDGE_MAX_NUM_REG_ENTRIES               52
-
 /*  Init function. MUST be called BEFORE any calls are  */
 /*  made into this psuedo-registry!!!  Returns TRUE/FALSE for SUCCESS/ERROR  */
 extern bool regsupInit(void);
-- 
1.5.6.5

