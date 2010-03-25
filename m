From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH] DSPBRIDGE: Cleanup unused custom error codes
Date: Fri, 26 Mar 2010 01:37:27 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB30@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab0CYUHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:33 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2PK7UCQ032336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 25 Mar 2010 15:07:32 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2PK7ToW027722
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 01:37:29 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From cd86b1a92364ab19d24463a3cce9d593afbb069c Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 14:03:48 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup unused custom error codes

This patch removes unused DSPBRIDGE error codes.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |  128 ------------------------
 1 files changed, 0 insertions(+), 128 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index a9ecb71..d60a179 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -66,19 +66,10 @@
 
 /* FAILURE Codes */
 
-/* The caller does not have access privileges to call this function */
-#define DSP_EACCESSDENIED           (DSP_EBASE + 0)
-
-/* The GPP must be detached from the DSP before this function is called */
-#define DSP_EATTACHED               (DSP_EBASE + 2)
-
 /* During enumeration a change in the number or properties of the objects
  * has occurred. */
 #define DSP_ECHANGEDURINGENUM       (DSP_EBASE + 3)
 
-/* A failure occurred during a delete operation */
-#define DSP_EDELETE                 (DSP_EBASE + 5)
-
 /* The specified direction is invalid */
 #define DSP_EDIRECTION              (DSP_EBASE + 6)
 
@@ -90,26 +81,15 @@
 /* A general failure occurred */
 #define DSP_EFAIL                   (DSP_EBASE + 8)
 
-/* No error text was found for the specified error code. */
-#define DSP_ENOERRTEXT              (DSP_EBASE + 0xe)
-
 /* No more connections can be made for this node. */
 #define DSP_ENOMORECONNECTIONS      (DSP_EBASE + 0xf)
 
 /* I/O is currently pending. */
 #define DSP_EPENDING                (DSP_EBASE + 0x11)
 
-/* A stream creation failure occurred on the DSP. */
-#define DSP_ESTREAM                 (DSP_EBASE + 0x15)
-
 /* A task creation failure occurred on the DSP. */
 #define DSP_ETASK                   (DSP_EBASE + 0x16)
 
-/* A data truncation occurred, e.g., when requesting a descriptive error
- * string, not enough space was allocated for the complete error message. */
-
-#define DSP_ETRUNCATED              (DSP_EBASE + 0x18)
-
 /* The state of the specified object is incorrect for the requested
  * operation. */
 #define DSP_EWRONGSTATE             (DSP_EBASE + 0x1b)
@@ -142,34 +122,13 @@
  * section. */
 #define DSP_EDCDNOAUTOREGISTER      (DSP_EBASE + 0x22)
 
-/* A requested resource is not available. */
-#define DSP_ERESOURCE               (DSP_EBASE + 0x28)
-
-/* A critical error has occurred, and the DSP is being re-started. */
-#define DSP_ERESTART                (DSP_EBASE + 0x29)
-
-/* A DSP memory free operation failed. */
-#define DSP_EFREE                   (DSP_EBASE + 0x2a)
-
-/* A DSP I/O free operation failed. */
-#define DSP_EIOFREE                 (DSP_EBASE + 0x2b)
-
-/* Multiple instances are not allowed. */
-#define DSP_EMULINST                (DSP_EBASE + 0x2c)
-
 /* A specified entity was not found. */
 #define DSP_ENOTFOUND               (DSP_EBASE + 0x2d)
 
-/* A DSP I/O resource is not available. */
-#define DSP_EOUTOFIO                (DSP_EBASE + 0x2e)
-
 /* A shared memory buffer contained in a message or stream could not be
  * mapped to the GPP client process's virtual space. */
 #define DSP_ETRANSLATE              (DSP_EBASE + 0x2f)
 
-/* File or section load write function failed to write to DSP */
-#define DSP_EFWRITE                 (DSP_EBASE + 0x31)
-
 /* Unable to find a named section in DSP executable */
 #define DSP_ENOSECT                 (DSP_EBASE + 0x32)
 
@@ -215,24 +174,6 @@
 #define DSP_EUSER15                 (DSP_EBASE + 0x4e)
 #define DSP_EUSER16                 (DSP_EBASE + 0x4f)
 
-/* FAILURE Codes : DEV */
-#define DEV_EBASE                   (DSP_COMP_EBASE + 0x000)
-
-/* The mini-driver expected a newer version of the class driver. */
-#define DEV_E_NEWWMD                (DEV_EBASE + 0x00)
-
-/* bridge_drv_entry function returned a NULL function interface table. */
-#define DEV_E_NULLWMDINTF           (DEV_EBASE + 0x01)
-
-/* FAILURE Codes : LDR */
-#define LDR_EBASE                   (DSP_COMP_EBASE + 0x100)
-
-/* Insufficient memory to export class driver services. */
-#define LDR_E_NOMEMORY              (LDR_EBASE + 0x00)
-
-/* Unable to find WMD file in system directory. */
-#define LDR_E_FILEUNABLETOOPEN      (LDR_EBASE + 0x01)
-
 /* FAILURE Codes : CFG */
 #define CFG_EBASE                   (DSP_COMP_EBASE + 0x200)
 
@@ -245,15 +186,6 @@
 /* Unable to retrieve resource information from the registry. */
 #define CFG_E_RESOURCENOTAVAIL      (CFG_EBASE + 0x02)
 
-/* Unable to find board name key in registry. */
-#define CFG_E_INVALIDBOARDNAME      (CFG_EBASE + 0x03)
-
-/* Unable to find a device node in registry with given unit number. */
-#define CFG_E_INVALIDUNITNUM        (CFG_EBASE + 0x04)
-
-/* Insufficient buffer size */
-#define CFG_E_INSUFFICIENTBUFSIZE   (CFG_EBASE + 0x05)
-
 /* FAILURE Codes : COD */
 #define COD_EBASE                   (DSP_COMP_EBASE + 0x400)
 
@@ -263,39 +195,24 @@
 /* Symbol not found in for this board. */
 #define COD_E_SYMBOLNOTFOUND        (COD_EBASE + 0x01)
 
-/* ZL DLL module is not exporting the correct function interface. */
-#define COD_E_NOZLFUNCTIONS         (COD_EBASE + 0x02)
-
 /* Unable to initialize the ZL COFF parsing module. */
 #define COD_E_ZLCREATEFAILED        (COD_EBASE + 0x03)
 
 /* Unable to open DSP executable COFF file. */
 #define COD_E_OPENFAILED            (COD_EBASE + 0x04)
 
-/* Unable to parse DSP executable COFF file. */
-#define COD_E_LOADFAILED            (COD_EBASE + 0x05)
-
-/* Unable to read DSP executable COFF file. */
-#define COD_E_READFAILED            (COD_EBASE + 0x06)
-
 /* FAILURE Codes : CHNL */
 #define CHNL_EBASE                  (DSP_COMP_EBASE + 0x500)
 
 /* Attempt to created channel manager with too many channels. */
 #define CHNL_E_MAXCHANNELS          (CHNL_EBASE + 0x00)
 
-/* No channel manager exists for this mini-driver. */
-#define CHNL_E_NOMGR                (CHNL_EBASE + 0x01)
-
 /* No free channels are available. */
 #define CHNL_E_OUTOFSTREAMS         (CHNL_EBASE + 0x02)
 
 /* Channel ID is out of range. */
 #define CHNL_E_BADCHANID            (CHNL_EBASE + 0x03)
 
-/* Invalid channel mode argument. */
-#define CHNL_E_BADMODE              (CHNL_EBASE + 0x05)
-
 /* dwTimeOut parameter was CHNL_IOCNOWAIT, yet no I/O completions were
  * queued. */
 #define CHNL_E_NOIOC                (CHNL_EBASE + 0x06)
@@ -303,15 +220,6 @@
 /* End of stream was already requested on this output channel. */
 #define CHNL_E_EOS                  (CHNL_EBASE + 0x09)
 
-/* Unable to create the channel event object. */
-#define CHNL_E_CREATEEVENT          (CHNL_EBASE + 0x0A)
-
-/* Board name and unit number do not identify a valid board name. */
-#define CHNL_E_BRDID                (CHNL_EBASE + 0x0B)
-
-/* Invalid IRQ configured for this WMD for this system. */
-#define CHNL_E_INVALIDIRQ           (CHNL_EBASE + 0x0C)
-
 /* DSP word size of zero configured for this device. */
 #define CHNL_E_INVALIDWORDSIZE      (CHNL_EBASE + 0x0D)
 
@@ -340,49 +248,13 @@
 /* Wait for flush operation on an output channel timed out. */
 #define CHNL_E_WAITTIMEOUT          (CHNL_EBASE + 0x15)
 
-/* User supplied event_obj must be specified with pstr_event_name attribute */
-#define CHNL_E_BADUSEREVENT         (CHNL_EBASE + 0x16)
-
-/* Illegal user event name specified */
-#define CHNL_E_USEREVENTNAME        (CHNL_EBASE + 0x17)
-
-/* Unable to prepare buffer specified */
-#define CHNL_E_PREPFAILED           (CHNL_EBASE + 0x18)
-
-/* Unable to Unprepare buffer specified */
-#define CHNL_E_UNPREPFAILED         (CHNL_EBASE + 0x19)
-
-/* FAILURE Codes : SYNC */
-#define SYNC_EBASE                  (DSP_COMP_EBASE + 0x600)
-
-/* Wait on a kernel event failed. */
-#define SYNC_E_FAIL                 (SYNC_EBASE + 0x00)
-
-/* Timeout expired while waiting for event to be signalled. */
-#define SYNC_E_TIMEOUT              (SYNC_EBASE + 0x01)
-
-/* FAILURE Codes : WMD */
-#define WMD_EBASE                   (DSP_COMP_EBASE + 0x700)
-
-/* A test of hardware assumptions or integrity failed. */
-#define WMD_E_HARDWARE              (WMD_EBASE + 0x00)
-
-/* One or more configuration parameters violated WMD hardware assumptions. */
-#define WMD_E_BADCONFIG             (WMD_EBASE + 0x01)
-
 /* FAILURE Codes : REG */
 #define REG_EBASE                   (DSP_COMP_EBASE + 0x800)
 
 /* Invalid subkey parameter. */
 #define REG_E_INVALIDSUBKEY         (REG_EBASE + 0x00)
 
-/* Invalid entry parameter. */
-#define REG_E_INVALIDENTRY          (REG_EBASE + 0x01)
-
 /* No more registry values. */
 #define REG_E_NOMOREITEMS           (REG_EBASE + 0x02)
 
-/* Insufficient space to hold data in registry value. */
-#define REG_E_MOREDATA              (REG_EBASE + 0x03)
-
 #endif /* ERRBASE_ */
-- 
1.6.0.4

