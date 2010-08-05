From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 288/524] staging: tidspbridge: gen: simplify and clean up
Date: Thu,  5 Aug 2010 15:21:11 -0700
Message-ID: <1281047107-17649-288-git-send-email-gregkh@suse.de>
References: <20100805213308.GA13744@kroah.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:41373 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760809Ab0HEWcF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:32:05 -0400
In-Reply-To: <20100805213308.GA13744@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devel@linuxdriverproject.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

From: Andy Shevchenko <andy.shevchenko@gmail.com>

There is recently added hex_to_bin() kernel's method which we could use
instead of custom long function.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/tidspbridge/gen/uuidutil.c |  167 +++++-----------------------
 1 files changed, 28 insertions(+), 139 deletions(-)

diff --git a/drivers/staging/tidspbridge/gen/uuidutil.c b/drivers/staging/tidspbridge/gen/uuidutil.c
index ce9319d..eb09bc3 100644
--- a/drivers/staging/tidspbridge/gen/uuidutil.c
+++ b/drivers/staging/tidspbridge/gen/uuidutil.c
@@ -54,61 +54,19 @@ void uuid_uuid_to_string(IN struct dsp_uuid *uuid_obj, OUT char *pszUuid,
 	DBC_ENSURE(i != -1);
 }
 
-/*
- *  ======== htoi ========
- *  Purpose:
- *      Converts a hex value to a decimal integer.
- */
-
-static int htoi(char c)
+static s32 uuid_hex_to_bin(char *buf, s32 len)
 {
-	switch (c) {
-	case '0':
-		return 0;
-	case '1':
-		return 1;
-	case '2':
-		return 2;
-	case '3':
-		return 3;
-	case '4':
-		return 4;
-	case '5':
-		return 5;
-	case '6':
-		return 6;
-	case '7':
-		return 7;
-	case '8':
-		return 8;
-	case '9':
-		return 9;
-	case 'A':
-		return 10;
-	case 'B':
-		return 11;
-	case 'C':
-		return 12;
-	case 'D':
-		return 13;
-	case 'E':
-		return 14;
-	case 'F':
-		return 15;
-	case 'a':
-		return 10;
-	case 'b':
-		return 11;
-	case 'c':
-		return 12;
-	case 'd':
-		return 13;
-	case 'e':
-		return 14;
-	case 'f':
-		return 15;
+	s32 i;
+	s32 result = 0;
+
+	for (i = 0; i < len; i++) {
+		value = hex_to_bin(*buf++);
+		result *= 16;
+		if (value > 0)
+			result += value;
 	}
-	return 0;
+
+	return result;
 }
 
 /*
@@ -118,106 +76,37 @@ static int htoi(char c)
  */
 void uuid_uuid_from_string(IN char *pszUuid, OUT struct dsp_uuid *uuid_obj)
 {
-	char c;
-	s32 i, j;
-	s32 result;
-	char *temp = pszUuid;
+	s32 j;
 
-	result = 0;
-	for (i = 0; i < 8; i++) {
-		/* Get first character in string */
-		c = *temp;
-
-		/* Increase the results by new value */
-		result *= 16;
-		result += htoi(c);
-
-		/* Go to next character in string */
-		temp++;
-	}
-	uuid_obj->ul_data1 = result;
+	uuid_obj->ul_data1 = uuid_hex_to_bin(pszUuid, 8);
+	pszUuid += 8;
 
 	/* Step over underscore */
-	temp++;
+	pszUuid++;
 
-	result = 0;
-	for (i = 0; i < 4; i++) {
-		/* Get first character in string */
-		c = *temp;
-
-		/* Increase the results by new value */
-		result *= 16;
-		result += htoi(c);
-
-		/* Go to next character in string */
-		temp++;
-	}
-	uuid_obj->us_data2 = (u16) result;
+	uuid_obj->us_data2 = (u16) uuid_hex_to_bin(pszUuid, 4);
+	pszUuid += 4;
 
 	/* Step over underscore */
-	temp++;
-
-	result = 0;
-	for (i = 0; i < 4; i++) {
-		/* Get first character in string */
-		c = *temp;
+	pszUuid++;
 
-		/* Increase the results by new value */
-		result *= 16;
-		result += htoi(c);
-
-		/* Go to next character in string */
-		temp++;
-	}
-	uuid_obj->us_data3 = (u16) result;
+	uuid_obj->us_data3 = (u16) uuid_hex_to_bin(pszUuid, 4);
+	pszUuid += 4;
 
 	/* Step over underscore */
-	temp++;
-
-	result = 0;
-	for (i = 0; i < 2; i++) {
-		/* Get first character in string */
-		c = *temp;
+	pszUuid++;
 
-		/* Increase the results by new value */
-		result *= 16;
-		result += htoi(c);
+	uuid_obj->uc_data4 = (u8) uuid_hex_to_bin(pszUuid, 2);
+	pszUuid += 2;
 
-		/* Go to next character in string */
-		temp++;
-	}
-	uuid_obj->uc_data4 = (u8) result;
-
-	result = 0;
-	for (i = 0; i < 2; i++) {
-		/* Get first character in string */
-		c = *temp;
-
-		/* Increase the results by new value */
-		result *= 16;
-		result += htoi(c);
-
-		/* Go to next character in string */
-		temp++;
-	}
-	uuid_obj->uc_data5 = (u8) result;
+	uuid_obj->uc_data5 = (u8) uuid_hex_to_bin(pszUuid, 2);
+	pszUuid += 2;
 
 	/* Step over underscore */
-	temp++;
+	pszUuid++;
 
 	for (j = 0; j < 6; j++) {
-		result = 0;
-		for (i = 0; i < 2; i++) {
-			/* Get first character in string */
-			c = *temp;
-
-			/* Increase the results by new value */
-			result *= 16;
-			result += htoi(c);
-
-			/* Go to next character in string */
-			temp++;
-		}
-		uuid_obj->uc_data6[j] = (u8) result;
+		uuid_obj->uc_data6[j] = (u8) uuid_hex_to_bin(pszUuid, 2);
+		pszUuid += 2;
 	}
 }
-- 
1.7.1

