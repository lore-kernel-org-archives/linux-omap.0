From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH v2]DSPBRIDGE: Remove unused custom error codes
Date: Fri, 16 Apr 2010 02:48:33 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FE6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55950 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757254Ab0DOVSj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:18:39 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLIacw019459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:18:38 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLIaSD011201
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:48:36 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 199a4cc5ba1e0d582fbacf3fffceb00afdfd191a Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 14:03:48 -0600
Subject: [PATCH] DSPBRIDGE: Remove unused custom error codes

This patch removes unused custom errorcodes.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |  158 ------------------------
 1 files changed, 0 insertions(+), 158 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 02cf8c6..38101a3 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -66,36 +66,13 @@
 
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
-/* No error text was found for the specified error code. */
-#define DSP_ENOERRTEXT              (DSP_EBASE + 0xe)
-
 /* I/O is currently pending. */
 #define DSP_EPENDING                (DSP_EBASE + 0x11)
 
-/* A stream creation failure occurred on the DSP. */
-#define DSP_ESTREAM                 (DSP_EBASE + 0x15)
-
-/* A task creation failure occurred on the DSP. */
-#define DSP_ETASK                   (DSP_EBASE + 0x16)
-
-/* A data truncation occurred, e.g., when requesting a descriptive error
- * string, not enough space was allocated for the complete error message. */
-
-#define DSP_ETRUNCATED              (DSP_EBASE + 0x18)
-
 /* The state of the specified object is incorrect for the requested
  * operation. */
 #define DSP_EWRONGSTATE             (DSP_EBASE + 0x1b)
@@ -128,34 +105,13 @@
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
 
@@ -165,63 +121,12 @@
 /* Invalid segment ID */
 #define DSP_EBADSEGID               (DSP_EBASE + 0x38)
 
-/* Not shared memory */
-#define DSP_ENOTSHAREDMEM           (DSP_EBASE + 0x3c)
-
 /* Error occurred in a dynamic loader library function */
 #define DSP_EDYNLOAD                (DSP_EBASE + 0x3d)
 
 /* Device in 'sleep/suspend' mode due to DPM */
 #define DSP_EDPMSUSPEND             (DSP_EBASE + 0x3e)
 
-/* A node-specific error has occurred. */
-#define DSP_EUSER1                  (DSP_EBASE + 0x40)
-#define DSP_EUSER2                  (DSP_EBASE + 0x41)
-#define DSP_EUSER3                  (DSP_EBASE + 0x42)
-#define DSP_EUSER4                  (DSP_EBASE + 0x43)
-#define DSP_EUSER5                  (DSP_EBASE + 0x44)
-#define DSP_EUSER6                  (DSP_EBASE + 0x45)
-#define DSP_EUSER7                  (DSP_EBASE + 0x46)
-#define DSP_EUSER8                  (DSP_EBASE + 0x47)
-#define DSP_EUSER9                  (DSP_EBASE + 0x48)
-#define DSP_EUSER10                 (DSP_EBASE + 0x49)
-#define DSP_EUSER11                 (DSP_EBASE + 0x4a)
-#define DSP_EUSER12                 (DSP_EBASE + 0x4b)
-#define DSP_EUSER13                 (DSP_EBASE + 0x4c)
-#define DSP_EUSER14                 (DSP_EBASE + 0x4d)
-#define DSP_EUSER15                 (DSP_EBASE + 0x4e)
-#define DSP_EUSER16                 (DSP_EBASE + 0x4f)
-
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
-/* FAILURE Codes : CFG */
-#define CFG_EBASE                   (DSP_COMP_EBASE + 0x200)
-
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
 
@@ -231,36 +136,21 @@
 /* Symbol not found in for this board. */
 #define COD_E_SYMBOLNOTFOUND        (COD_EBASE + 0x01)
 
-/* ZL DLL module is not exporting the correct function interface. */
-#define COD_E_NOZLFUNCTIONS         (COD_EBASE + 0x02)
-
 /* Unable to initialize the ZL COFF parsing module. */
 #define COD_E_ZLCREATEFAILED        (COD_EBASE + 0x03)
 
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
@@ -268,15 +158,6 @@
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
 
@@ -305,43 +186,4 @@
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
-/* FAILURE Codes : REG */
-#define REG_EBASE                   (DSP_COMP_EBASE + 0x800)
-
-/* Invalid entry parameter. */
-#define REG_E_INVALIDENTRY          (REG_EBASE + 0x01)
-
-/* Insufficient space to hold data in registry value. */
-#define REG_E_MOREDATA              (REG_EBASE + 0x03)
-
 #endif /* ERRBASE_ */
-- 
1.6.0.4

