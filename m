From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] DSPBRIDGE: remove unused macros
Date: Thu, 14 Jan 2010 20:31:34 -0600
Message-ID: <1263522694-20759-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab0AOCbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 21:31:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

A tiny step in cleaning up the bridge - removed unused macros

I used ctags to generate tags for all dspbridge relevant files
 grep '	d$' tags gives a list of all defines.
then, the following script searched and listed all defines which were
unused in dspbridge files:
 for i in `grep '	d$' tags|cut -d '	' -f1`
 do
   # search for more than a single occurance of the define==usage
   k=`cat dsp_bridge_files |xargs grep $i|wc -l`
   # if only a single usage(#define, it is unused) - list it
   if [ "$k" -eq "1" ]; then echo $i>>unused_defines; fi;
 done
the defines in unused_defines where then removed from the files

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/brddefs.h     |    1 -
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h     |    5 --
 arch/arm/plat-omap/include/dspbridge/chnldefs.h    |    2 -
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h    |    3 -
 arch/arm/plat-omap/include/dspbridge/cod.h         |    3 -
 arch/arm/plat-omap/include/dspbridge/dbdefs.h      |   17 -----
 arch/arm/plat-omap/include/dspbridge/dbg.h         |    1 -
 arch/arm/plat-omap/include/dspbridge/dbldefs.h     |    4 -
 arch/arm/plat-omap/include/dspbridge/dbtype.h      |    3 -
 arch/arm/plat-omap/include/dspbridge/drv.h         |    5 --
 .../plat-omap/include/dspbridge/dynamic_loader.h   |    1 -
 arch/arm/plat-omap/include/dspbridge/errbase.h     |   36 -----------
 arch/arm/plat-omap/include/dspbridge/io_sm.h       |    4 -
 arch/arm/plat-omap/include/dspbridge/iodefs.h      |    1 -
 arch/arm/plat-omap/include/dspbridge/mbx_sh.h      |   28 ---------
 arch/arm/plat-omap/include/dspbridge/memdefs.h     |    1 -
 arch/arm/plat-omap/include/dspbridge/pwr_sh.h      |    4 -
 arch/arm/plat-omap/include/dspbridge/rms_sh.h      |    4 -
 arch/arm/plat-omap/include/dspbridge/strmdefs.h    |    1 -
 arch/arm/plat-omap/include/dspbridge/utildefs.h    |    5 --
 arch/arm/plat-omap/include/dspbridge/wmd.h         |    1 -
 arch/arm/plat-omap/include/dspbridge/wmdioctl.h    |    5 --
 drivers/dsp/bridge/dynload/dload_internal.h        |    3 -
 drivers/dsp/bridge/dynload/doff.h                  |    2 -
 drivers/dsp/bridge/dynload/header.h                |    2 -
 drivers/dsp/bridge/dynload/module_list.h           |    1 -
 drivers/dsp/bridge/dynload/params.h                |    3 -
 drivers/dsp/bridge/dynload/reloc_table.h           |    7 --
 drivers/dsp/bridge/hw/GlobalTypes.h                |   27 --------
 drivers/dsp/bridge/hw/MMUAccInt.h                  |    1 -
 drivers/dsp/bridge/hw/PRCMAccInt.h                 |    2 -
 drivers/dsp/bridge/hw/PRCMRegAcM.h                 |   64 --------------------
 drivers/dsp/bridge/hw/hw_dspssC64P.h               |    1 -
 drivers/dsp/bridge/hw/hw_mbox.h                    |    3 -
 drivers/dsp/bridge/pmgr/chnlobj.h                  |    3 -
 drivers/dsp/bridge/wmd/_tiomap.h                   |   31 ----------
 drivers/dsp/bridge/wmd/_tiomap_util.h              |    1 -
 drivers/dsp/bridge/wmd/tiomap_io.h                 |    4 -
 38 files changed, 0 insertions(+), 290 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/brddefs.h b/arch/arm/plat-omap/include/dspbridge/brddefs.h
index c62388c..d86da21 100644
--- a/arch/arm/plat-omap/include/dspbridge/brddefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/brddefs.h
@@ -41,7 +41,6 @@
 #define BRD_SYNCINIT    0x4
 #define BRD_LOADED      0x5
 #define BRD_LASTSTATE   BRD_LOADED	/* Set to highest legal board state. */
-#define BRD_SLEEP_TRANSITION 0x6	/* Sleep transition in progress  */
 #define BRD_HIBERNATION 0x7		/* MPU initiated hibernation */
 #define BRD_RETENTION     0x8       /* Retention mode */
 #define BRD_DSP_HIBERNATION     0x9       /* DSP initiated hibernation */
diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index 0155e13..854a56e 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -46,20 +46,15 @@
 #define CFG_MAXSEARCHPATHLEN    255
 
 /* Maximum length of general paths. */
-#define CFG_MAXPATH             255
 
 /* Host Resources:  */
 #define CFG_MAXMEMREGISTERS     9
-#define CFG_MAXIOPORTS          20
-#define CFG_MAXIRQS             7
-#define CFG_MAXDMACHANNELS      7
 
 /* IRQ flag */
 #define CFG_IRQSHARED           0x01	/* IRQ can be shared */
 
 /* DSP Resources: */
 #define CFG_DSPMAXMEMTYPES      10
-#define CFG_DEFAULT_NUM_WINDOWS 1	/* We support only one window. */
 
 /* A platform-related device handle: */
 	struct CFG_DEVNODE;
diff --git a/arch/arm/plat-omap/include/dspbridge/chnldefs.h b/arch/arm/plat-omap/include/dspbridge/chnldefs.h
index 9f59229..c2ba4fe 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnldefs.h
@@ -45,7 +45,6 @@
 #define CHNL_PICKFREE       (~0UL)	/* Let manager pick a free channel. */
 
 /* Channel manager limits: */
-#define CHNL_INITIOREQS      4	/* Default # of I/O requests.       */
 
 /* Channel modes */
 #define CHNL_MODETODSP       0x0000	/* Data streaming to the DSP.      */
@@ -62,7 +61,6 @@
 #define CHNL_IOCSTATEOS      0x8000	/* End Of Stream reached.    */
 
 /* Macros for checking I/O Completion status: */
-#define CHNL_IsEOS(ioc)         (ioc.status & CHNL_IOCSTATEOS)
 #define CHNL_IsIOComplete(ioc)  (!(ioc.status & ~CHNL_IOCSTATEOS))
 #define CHNL_IsIOCancelled(ioc) (ioc.status & CHNL_IOCSTATCANCEL)
 #define CHNL_IsTimedOut(ioc)    (ioc.status & CHNL_IOCSTATTIMEOUT)
diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index fdcda24..71c7068 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -74,7 +74,6 @@
 
 /* The following modes are private: */
 #define CHNL_MODEUSEREVENT  0x1000	/* User provided the channel event. */
-#define CHNL_MODEMASK       0x1001
 
 /* Higher level channel states: */
 #define CHNL_STATEREADY     0x0000	/* Channel ready for I/O.    */
@@ -82,7 +81,6 @@
 #define CHNL_STATEEOS       0x0002	/* End Of Stream reached.    */
 
 /* Determine if user supplied an event for this channel:  */
-#define CHNL_IsUserEvent(mode)  (mode & CHNL_MODEUSEREVENT)
 
 /* Macros for checking mode: */
 #define CHNL_IsInput(mode)      (mode & CHNL_MODEFROMDSP)
@@ -90,7 +88,6 @@
 
 /* Types of channel class libraries: */
 #define CHNL_TYPESM         1	/* Shared memory driver. */
-#define CHNL_TYPEBM         2	/* Bus Mastering driver. */
 
 /* Max string length of channel I/O completion event name - change if needed */
 #define CHNL_MAXEVTNAMELEN  32
diff --git a/arch/arm/plat-omap/include/dspbridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
index a8a12c6..2fb633c 100644
--- a/arch/arm/plat-omap/include/dspbridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -76,9 +76,6 @@
 #define COD_MAXPATHLENGTH       255
 #define COD_TRACEBEG            "SYS_PUTCBEG"
 #define COD_TRACEEND            "SYS_PUTCEND"
-#define COD_TRACESECT           "trace"
-#define COD_TRACEBEGOLD         "PUTCBEG"
-#define COD_TRACEENDOLD         "PUTCEND"
 
 #define COD_NOLOAD              DBLL_NOLOAD
 #define COD_SYMB                DBLL_SYMB
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index acd291f..94d5f5f 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -83,7 +83,6 @@
 #define DBAPI                       DSP_STATUS
 
 /* Infinite time value for the uTimeout parameter to DSPStream_Select() */
-#define DSP_FOREVER                 (-1)
 
 /* Maximum length of node name, used in DSP_NDBPROPS */
 #define DSP_MAXNAMELEN              32
@@ -104,7 +103,6 @@
 #define DSP_PWRERROR                0x00000080
 
 /* IVA exception events (IVA MMU fault) */
-#define IVA_MMUFAULT                0x00000040
 /* Types of events for nodes */
 #define DSP_NODESTATECHANGE         0x00000100
 #define DSP_NODEMESSAGEREADY        0x00000200
@@ -125,9 +123,7 @@
 #define DSP_NODE_MAX_PRIORITY       15
 
 /* Pre-Defined Message Command Codes available to user: */
-#define DSP_RMSUSERCODESTART RMS_USER	/* Start of RMS user cmd codes */
 /* end of user codes */
-#define DSP_RMSUSERCODEEND (RMS_USER + RMS_MAXUSERCODES);
 #define DSP_RMSBUFDESC RMS_BUFDESC	/* MSG contains SM buffer description */
 
 /* Shared memory identifier for MEM segment named "SHMSEG0" */
@@ -147,11 +143,8 @@
 /* Power control enumerations */
 #define PROC_PWRCONTROL             0x8070
 
-#define PROC_PWRMGT_ENABLE          (PROC_PWRCONTROL + 0x3)
-#define PROC_PWRMGT_DISABLE         (PROC_PWRCONTROL + 0x4)
 
 /* Bridge Code Version */
-#define BRIDGE_VERSION_CODE         333
 
 #define    MAX_PROFILES     16
 
@@ -188,16 +181,6 @@
 				    DSP_SYSERROR | \
 				    DSP_PWRERROR))))
 
-#define IsValidNodeEvent(x)    (((x) == 0) || (((x) & (DSP_NODESTATECHANGE | \
-				DSP_NODEMESSAGEREADY)) && \
-				!((x) & ~(DSP_NODESTATECHANGE | \
-				DSP_NODEMESSAGEREADY))))
-
-#define IsValidStrmEvent(x)     (((x) == 0) || (((x) & (DSP_STREAMDONE | \
-				DSP_STREAMIOCOMPLETION)) && \
-				!((x) & ~(DSP_STREAMDONE | \
-				DSP_STREAMIOCOMPLETION))))
-
 #define IsValidNotifyMask(x)   ((x) & DSP_SIGNALEVENT)
 
 /* The Node UUID structure */
diff --git a/arch/arm/plat-omap/include/dspbridge/dbg.h b/arch/arm/plat-omap/include/dspbridge/dbg.h
index 7f44ff9..dda0aec 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbg.h
@@ -45,7 +45,6 @@
 /* Levels of trace debug messages: */
 #define DBG_ENTER   (u8)(0x01)	/* Function entry point. */
 #define DBG_LEVEL1  (u8)(0x02)	/* Display debugging state/varibles */
-#define DBG_LEVEL2  (u8)(0x04)	/* Display debugging state/varibles */
 #define DBG_LEVEL3  (u8)(0x08)	/* Display debugging state/varibles */
 #define DBG_LEVEL4  (u8)(0x10)	/* Display debugging state/varibles */
 #define DBG_LEVEL5  (u8)(0x20)	/* Module Init, Exit */
diff --git a/arch/arm/plat-omap/include/dspbridge/dbldefs.h b/arch/arm/plat-omap/include/dspbridge/dbldefs.h
index 79b9e54..7808ff2 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbldefs.h
@@ -30,12 +30,8 @@
 /*
  *  Bit masks for DBL_Flags.
  */
-#define DBL_NOLOAD   0x0	/* Don't load symbols, code, or data */
-#define DBL_SYMB     0x1	/* load symbols */
 #define DBL_CODE     0x2	/* load code */
 #define DBL_DATA     0x4	/* load data */
-#define DBL_DYNAMIC  0x8	/* dynamic load */
-#define DBL_BSS      0x20	/* Unitialized section */
 
 #define DBL_MAXPATHLENGTH       255
 
diff --git a/arch/arm/plat-omap/include/dspbridge/dbtype.h b/arch/arm/plat-omap/include/dspbridge/dbtype.h
index b4953a0..841b4b8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbtype.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbtype.h
@@ -94,10 +94,7 @@ typedef void *HANDLE;		/* h    */
 
 #define TEXT(x) x
 
-#define DLLIMPORT
-#define DLLEXPORT
 
 /* Define DSPAPIDLL correctly in dspapi.h */
-#define _DSPSYSDLL32_
 
 #endif				/* DBTYPE_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index d14613f..41a1ae2 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -77,18 +77,15 @@
 /* MEM1 is L2 RAM + L2 Cache space */
 #define OMAP_DSP_MEM1_BASE 0x5C7F8000
 #define OMAP_DSP_MEM1_SIZE 0x18000
-#define OMAP_DSP_GEM1_BASE 0x107F8000
 
 
 /* MEM2 is L1P RAM/CACHE space */
 #define OMAP_DSP_MEM2_BASE 0x5CE00000
 #define OMAP_DSP_MEM2_SIZE 0x8000
-#define OMAP_DSP_GEM2_BASE 0x10E00000
 
 /* MEM3 is L1D RAM/CACHE space */
 #define OMAP_DSP_MEM3_BASE 0x5CF04000
 #define OMAP_DSP_MEM3_SIZE 0x14000
-#define OMAP_DSP_GEM3_BASE 0x10F04000
 
 
 #define OMAP_IVA2_PRM_BASE 0x48306000
@@ -115,8 +112,6 @@
 #define OMAP_DMMU_BASE 0x5D000000
 #define OMAP_DMMU_SIZE 0x1000
 
-#define OMAP_PRCM_VDD1_DOMAIN 1
-#define OMAP_PRCM_VDD2_DOMAIN 2
 
 #ifndef RES_CLEANUP_DISABLE
 
diff --git a/arch/arm/plat-omap/include/dspbridge/dynamic_loader.h b/arch/arm/plat-omap/include/dspbridge/dynamic_loader.h
index ea5f77f..0f9554f 100644
--- a/arch/arm/plat-omap/include/dspbridge/dynamic_loader.h
+++ b/arch/arm/plat-omap/include/dspbridge/dynamic_loader.h
@@ -48,7 +48,6 @@
  * Option flags to modify the behavior of module loading
  */
 #define DLOAD_INITBSS 0x1	/* initialize BSS sections to zero */
-#define DLOAD_BIGEND 0x2	/* require big-endian load module */
 #define DLOAD_LITTLE 0x4	/* require little-endian load module */
 
 	typedef void *DLOAD_mhandle;	/* module handle for loaded modules */
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 271315a..5afb1dc 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -51,7 +51,6 @@
 #define DSP_EBASE               (DSP_STATUS)0x80008000
 
 #define DSP_COMP_EBASE          (DSP_STATUS)0x80040200
-#define DSP_COMP_ELAST          (DSP_STATUS)0x80047fff
 
 /* SUCCESS Codes */
 
@@ -83,7 +82,6 @@
 #define DSP_SALREADYLOADED          (DSP_SBASE + 8)
 
 /* Some error occured, but it is OK to continue */
-#define DSP_OKTO_CONTINUE          (DSP_SBASE + 9)
 
 /* FAILURE Codes */
 
@@ -133,7 +131,6 @@
 #define DSP_ENODETYPE               (DSP_EBASE + 0xd)
 
 /* No error text was found for the specified error code. */
-#define DSP_ENOERRTEXT              (DSP_EBASE + 0xe)
 
 /* No more connections can be made for this node. */
 #define DSP_ENOMORECONNECTIONS      (DSP_EBASE + 0xf)
@@ -166,7 +163,6 @@
 /* A data truncation occurred, e.g., when requesting a descriptive error
  * string, not enough space was allocated for the complete error message. */
 
-#define DSP_ETRUNCATED              (DSP_EBASE + 0x18)
 
 /* A parameter is invalid. */
 #define DSP_EVALUE                  (DSP_EBASE + 0x1a)
@@ -207,25 +203,20 @@
 #define DSP_EDCDNOAUTOREGISTER      (DSP_EBASE + 0x22)
 
 /* A requested resource is not available. */
-#define DSP_ERESOURCE               (DSP_EBASE + 0x28)
 
 /* A critical error has occurred, and the DSP is being re-started. */
 #define DSP_ERESTART                (DSP_EBASE + 0x29)
 
 /* A DSP memory free operation failed. */
-#define DSP_EFREE                   (DSP_EBASE + 0x2a)
 
 /* A DSP I/O free operation failed. */
-#define DSP_EIOFREE                 (DSP_EBASE + 0x2b)
 
 /* Multiple instances are not allowed. */
-#define DSP_EMULINST                (DSP_EBASE + 0x2c)
 
 /* A specified entity was not found.  */
 #define DSP_ENOTFOUND               (DSP_EBASE + 0x2d)
 
 /* A DSP I/O resource is not available. */
-#define DSP_EOUTOFIO                (DSP_EBASE + 0x2e)
 
 /* A shared memory buffer contained in a message or stream could not be
  * mapped to the GPP client process's virtual space. */
@@ -269,21 +260,6 @@
 
 /* A node-specific error has occurred. */
 #define DSP_EUSER1                  (DSP_EBASE + 0x40)
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
 
 /* FAILURE Codes : DEV */
 #define DEV_EBASE                   (DSP_COMP_EBASE + 0x000)
@@ -316,10 +292,8 @@
 #define CFG_E_RESOURCENOTAVAIL      (CFG_EBASE + 0x02)
 
 /* Unable to find board name key in registry. */
-#define CFG_E_INVALIDBOARDNAME      (CFG_EBASE + 0x03)
 
 /* Unable to find a device node in registry with given unit number. */
-#define CFG_E_INVALIDUNITNUM        (CFG_EBASE + 0x04)
 
 /* Insufficient buffer size */
 #define CFG_E_INSUFFICIENTBUFSIZE   (CFG_EBASE + 0x05)
@@ -355,7 +329,6 @@
 #define CHNL_E_MAXCHANNELS          (CHNL_EBASE + 0x00)
 
 /* No channel manager exists for this mini-driver. */
-#define CHNL_E_NOMGR                (CHNL_EBASE + 0x01)
 
 /* No free channels are available. */
 #define CHNL_E_OUTOFSTREAMS         (CHNL_EBASE + 0x02)
@@ -367,7 +340,6 @@
 #define CHNL_E_CHANBUSY             (CHNL_EBASE + 0x04)
 
 /* Invalid channel mode argument. */
-#define CHNL_E_BADMODE              (CHNL_EBASE + 0x05)
 
 /* dwTimeOut parameter was CHNL_IOCNOWAIT, yet no I/O completions were
  * queued. */
@@ -380,10 +352,8 @@
 #define CHNL_E_EOS                  (CHNL_EBASE + 0x09)
 
 /* Unable to create the channel event object. */
-#define CHNL_E_CREATEEVENT          (CHNL_EBASE + 0x0A)
 
 /* Board name and unit number do not identify a valid board name. */
-#define CHNL_E_BRDID                (CHNL_EBASE + 0x0B)
 
 /* Invalid IRQ configured for this WMD for this system. */
 #define CHNL_E_INVALIDIRQ           (CHNL_EBASE + 0x0C)
@@ -417,16 +387,12 @@
 #define CHNL_E_WAITTIMEOUT          (CHNL_EBASE + 0x15)
 
 /* User supplied hEvent must be specified with pstrEventName attribute */
-#define CHNL_E_BADUSEREVENT         (CHNL_EBASE + 0x16)
 
 /* Illegal user event name specified */
-#define CHNL_E_USEREVENTNAME        (CHNL_EBASE + 0x17)
 
 /* Unable to prepare buffer specified */
-#define CHNL_E_PREPFAILED           (CHNL_EBASE + 0x18)
 
 /* Unable to Unprepare buffer specified */
-#define CHNL_E_UNPREPFAILED         (CHNL_EBASE + 0x19)
 
 /* FAILURE Codes : SYNC */
 #define SYNC_EBASE                  (DSP_COMP_EBASE + 0x600)
@@ -456,12 +422,10 @@
 #define REG_E_INVALIDSUBKEY         (REG_EBASE + 0x00)
 
 /* Invalid entry parameter. */
-#define REG_E_INVALIDENTRY          (REG_EBASE + 0x01)
 
 /* No more registry values. */
 #define REG_E_NOMOREITEMS           (REG_EBASE + 0x02)
 
 /* Insufficient space to hold data in registry value. */
-#define REG_E_MOREDATA              (REG_EBASE + 0x03)
 
 #endif				/* ERRBASE_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 3dcbf74..a43921a 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -60,13 +60,9 @@
 #define IO_INPUT            0
 #define IO_OUTPUT           1
 #define IO_SERVICE          2
-#define IO_MAXSERVICE       IO_SERVICE
 
 #define IO_MGRSIGNATURE     0x494f4D43	/* "IOGR" */
 
-#define DSPFieldAddr(type, field, base, wordsize) \
-    ((((s32)&(((type *)0)->field)) / wordsize) + (u32)base)
-
 /* Access can be different SM access word size (e.g. 16/32 bit words) */
 #define IO_SetValue(pContext, type, base, field, value) (base->field = value)
 #define IO_GetValue(pContext, type, base, field)	(base->field)
diff --git a/arch/arm/plat-omap/include/dspbridge/iodefs.h b/arch/arm/plat-omap/include/dspbridge/iodefs.h
index f45890a..68a9026 100644
--- a/arch/arm/plat-omap/include/dspbridge/iodefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/iodefs.h
@@ -28,7 +28,6 @@
 #ifndef IODEFS_
 #define IODEFS_
 
-#define IO_MAXIRQ   0xff	/* Arbitrarily large number. */
 
 /* IO Objects: */
 	struct IO_MGR;
diff --git a/arch/arm/plat-omap/include/dspbridge/mbx_sh.h b/arch/arm/plat-omap/include/dspbridge/mbx_sh.h
index be0909e..849179f 100644
--- a/arch/arm/plat-omap/include/dspbridge/mbx_sh.h
+++ b/arch/arm/plat-omap/include/dspbridge/mbx_sh.h
@@ -125,8 +125,6 @@
 #ifndef _MBX_SH_H
 #define _MBX_SH_H
 
-#define MBX_CLASS_MSK      0xFC00	/* Class bits are 10 thru 15 */
-#define MBX_VALUE_MSK      0x03FF	/* Value is 0 thru 9 */
 
 #define MBX_DEH_CLASS      0x0000	/* DEH owns Mbx INTR */
 #define MBX_DDMA_CLASS     0x0400	/* DSP-DMA link drvr chnls owns INTR */
@@ -151,24 +149,17 @@
 /* DSP-DMA */
 #define MBX_DDMA_NUMCHNLBITS 5	/* # chnl Id: # bits available */
 #define MBX_DDMA_CHNLSHIFT   0	/* # of bits to shift */
-#define MBX_DDMA_CHNLMSK     0x01F	/* bits 0 thru 4 */
 
-#define MBX_DDMA_NUMBUFBITS  5	/* buffer index: # of bits avail */
 #define MBX_DDMA_BUFSHIFT    (MBX_DDMA_NUMCHNLBITS + MBX_DDMA_CHNLSHIFT)
-#define MBX_DDMA_BUFMSK      0x3E0	/* bits 5 thru 9 */
 
 /* Zero-Copy */
-#define MBX_ZCPY_NUMCHNLBITS 5	/* # chnl Id: # bits available */
 #define MBX_ZCPY_CHNLSHIFT   0	/* # of bits to shift */
-#define MBX_ZCPY_CHNLMSK     0x01F	/* bits 0 thru 4 */
 
 /*  Power Management Commands */
 #define MBX_PM_DSPIDLE                  (MBX_PM_CLASS + 0x0)
 #define MBX_PM_DSPWAKEUP                (MBX_PM_CLASS + 0x1)
 #define MBX_PM_EMERGENCYSLEEP           (MBX_PM_CLASS + 0x2)
 #define MBX_PM_SLEEPUNTILRESTART        (MBX_PM_CLASS + 0x3)
-#define MBX_PM_DSPGLOBALIDLE_OFF        (MBX_PM_CLASS + 0x4)
-#define MBX_PM_DSPGLOBALIDLE_ON         (MBX_PM_CLASS + 0x5)
 #define MBX_PM_SETPOINT_PRENOTIFY       (MBX_PM_CLASS + 0x6)
 #define MBX_PM_SETPOINT_POSTNOTIFY      (MBX_PM_CLASS + 0x7)
 #define MBX_PM_DSPRETN                  (MBX_PM_CLASS + 0x8)
@@ -176,26 +167,11 @@
 #define MBX_PM_DSPHIBERNATE        (MBX_PM_CLASS + 0x9)
 #define MBX_PM_HIBERNATE_EN        (MBX_PM_CLASS + 0xA)
 #define MBX_PM_OPP_REQ                  (MBX_PM_CLASS + 0xB)
-#define MBX_PM_OPP_CHG                  (MBX_PM_CLASS + 0xC)
 
-#define MBX_PM_TYPE_MASK 0x0300
 #define MBX_PM_TYPE_PWR_CHNG 0x0100
 #define MBX_PM_TYPE_OPP_PRECHNG 0x0200
-#define MBX_PM_TYPE_OPP_POSTCHNG 0x0300
-#define MBX_PM_TYPE_OPP_MASK 0x0300
-#define MBX_PM_OPP_PRECHNG (MBX_PM_CLASS | MBX_PM_TYPE_OPP_PRECHNG)
 /* DSP to MPU */
-#define MBX_PM_OPP_CHNG(OPP) (MBX_PM_CLASS | MBX_PM_TYPE_OPP_PRECHNG | (OPP))
-#define MBX_PM_RET (MBX_PM_CLASS | MBX_PM_TYPE_PWR_CHNG | 0x0006)
 #define MBX_PM_HIB (MBX_PM_CLASS | MBX_PM_TYPE_PWR_CHNG | 0x0002)
-#define MBX_PM_OPP_1 0
-#define MBX_PM_OPP_2 1
-#define MBX_PM_OPP_3 2
-#define MBX_PM_OPP_4 3
-#define MBX_OLDOPP_EXTRACT(OPPMSG) ((0x00F0 & (OPPMSG)) >> 4)
-#define MBX_NEWOPP_EXTRACT(OPPMSG) (0x000F & (OPPMSG))
-#define MBX_PREVOPP_EXTRACT(OPPMSG) ((0x00F0 & (OPPMSG)) >> 4)
-#define MBX_CUROPP_EXTRACT(OPPMSG) (0x000F & (OPPMSG))
 
 /* Bridge Debug Commands */
 #define MBX_DBG_SYSPRINTF       (MBX_DBG_CLASS + 0x0)
@@ -203,10 +179,6 @@
 /*
  * Useful macros
  */
-/* DSP-DMA channel */
-#define MBX_SETDDMAVAL(x, y)  (MBX_DDMA_CLASS | (x << MBX_DDMA_BUFSHIFT) | \
-	(y << MBX_DDMA_CHNLSHIFT))
-
 /* Zero-Copy channel */
 #define MBX_SETZCPYVAL(x)  (MBX_ZCPY_CLASS | (x << MBX_ZCPY_CHNLSHIFT))
 
diff --git a/arch/arm/plat-omap/include/dspbridge/memdefs.h b/arch/arm/plat-omap/include/dspbridge/memdefs.h
index a5bb259..e85fa23 100644
--- a/arch/arm/plat-omap/include/dspbridge/memdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/memdefs.h
@@ -47,6 +47,5 @@
 #define MEM_MASKVIRTUALSEGID    (MEM_SETVIRTUALSEGID | MEM_GETVIRTUALSEGID)
 
 #define TO_VIRTUAL_UNCACHED(x) x
-#define INTREG_TO_VIRTUAL_UNCACHED(x) x
 
 #endif				/* MEMDEFS_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/pwr_sh.h b/arch/arm/plat-omap/include/dspbridge/pwr_sh.h
index 40f1b84..eaa031a 100644
--- a/arch/arm/plat-omap/include/dspbridge/pwr_sh.h
+++ b/arch/arm/plat-omap/include/dspbridge/pwr_sh.h
@@ -32,10 +32,6 @@
 /* valid sleep command codes that can be sent by GPP via mailbox: */
 #define PWR_DEEPSLEEP           MBX_PM_DSPIDLE
 #define PWR_EMERGENCYDEEPSLEEP  MBX_PM_EMERGENCYSLEEP
-#define PWR_SLEEPUNTILRESTART   MBX_PM_SLEEPUNTILRESTART
 #define PWR_WAKEUP              MBX_PM_DSPWAKEUP
-#define PWR_AUTOENABLE          MBX_PM_PWRENABLE
-#define PWR_AUTODISABLE         MBX_PM_PWRDISABLE
-#define PWR_RETENTION             MBX_PM_DSPRETN
 
 #endif				/* PWR_SH_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/rms_sh.h b/arch/arm/plat-omap/include/dspbridge/rms_sh.h
index 5d4b49a..adad8b2 100644
--- a/arch/arm/plat-omap/include/dspbridge/rms_sh.h
+++ b/arch/arm/plat-omap/include/dspbridge/rms_sh.h
@@ -51,14 +51,10 @@
 #include <dspbridge/rmstypes.h>
 
 /* Node Types: */
-#define RMS_TASK                1	/* Task node */
-#define RMS_DAIS                2	/* xDAIS socket node */
-#define RMS_MSG                 3	/* Message node */
 
 /* Memory Types: */
 #define RMS_CODE                0	/* Program space */
 #define RMS_DATA                1	/* Data space */
-#define RMS_IO                	2	/* I/O space */
 
 /* RM Server Command and Response Buffer Sizes: */
 #define RMS_COMMANDBUFSIZE     256	/* Size of command buffer */
diff --git a/arch/arm/plat-omap/include/dspbridge/strmdefs.h b/arch/arm/plat-omap/include/dspbridge/strmdefs.h
index 44d217a..fbb92f6 100644
--- a/arch/arm/plat-omap/include/dspbridge/strmdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/strmdefs.h
@@ -29,7 +29,6 @@
 #ifndef STRMDEFS_
 #define STRMDEFS_
 
-#define STRM_MAXEVTNAMELEN      32
 
 	struct STRM_MGR;
 
diff --git a/arch/arm/plat-omap/include/dspbridge/utildefs.h b/arch/arm/plat-omap/include/dspbridge/utildefs.h
index bd53a5a..bd6e652 100644
--- a/arch/arm/plat-omap/include/dspbridge/utildefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/utildefs.h
@@ -32,13 +32,8 @@
 #define UTILDEFS_
 
 /* constants taken from configmg.h */
-#define UTIL_MAXMEMREGS     9
-#define UTIL_MAXIOPORTS     20
-#define UTIL_MAXIRQS        7
-#define UTIL_MAXDMACHNLS    7
 
 /* misc. constants */
-#define UTIL_MAXARGVS       10
 
 /* Platform specific important info */
 	struct UTIL_SYSINFO {
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index f584038..37398c4 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -74,7 +74,6 @@
  *  Any IOCTLS at or above this value are reserved for standard WMD
  *  interfaces.
  */
-#define WMD_RESERVEDIOCTLBASE   0x8000
 
 /* Handle to mini-driver's private device context.  */
 	struct WMD_DEV_CONTEXT;
diff --git a/arch/arm/plat-omap/include/dspbridge/wmdioctl.h b/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
index a41c61a..95846d0 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
@@ -50,9 +50,6 @@
 
 #define WMDIOCTL_CHNLREAD           (WMDIOCTL_RESERVEDBASE + 0x10)
 #define WMDIOCTL_CHNLWRITE          (WMDIOCTL_RESERVEDBASE + 0x20)
-#define WMDIOCTL_GETINTRCOUNT       (WMDIOCTL_RESERVEDBASE + 0x30)
-#define WMDIOCTL_RESETINTRCOUNT     (WMDIOCTL_RESERVEDBASE + 0x40)
-#define WMDIOCTL_INTERRUPTDSP       (WMDIOCTL_RESERVEDBASE + 0x50)
 #define WMDIOCTL_SETMMUCONFIG       (WMDIOCTL_RESERVEDBASE + 0x60)   /* DMMU */
 #define WMDIOCTL_PWRCONTROL         (WMDIOCTL_RESERVEDBASE + 0x70)   /* PWR */
 
@@ -64,8 +61,6 @@
 #define WMDIOCTL_DEEPSLEEP          (WMDIOCTL_PWRCONTROL + 0x0)
 #define WMDIOCTL_EMERGENCYSLEEP     (WMDIOCTL_PWRCONTROL + 0x1)
 #define WMDIOCTL_WAKEUP             (WMDIOCTL_PWRCONTROL + 0x2)
-#define WMDIOCTL_PWRENABLE          (WMDIOCTL_PWRCONTROL + 0x3)
-#define WMDIOCTL_PWRDISABLE         (WMDIOCTL_PWRCONTROL + 0x4)
 #define WMDIOCTL_CLK_CTRL		    (WMDIOCTL_PWRCONTROL + 0x7)
 #define WMDIOCTL_PWR_HIBERNATE (WMDIOCTL_PWRCONTROL + 0x8) /*DSP Initiated
 							    * Hibernate*/
diff --git a/drivers/dsp/bridge/dynload/dload_internal.h b/drivers/dsp/bridge/dynload/dload_internal.h
index 65d1f47..284e452 100644
--- a/drivers/dsp/bridge/dynload/dload_internal.h
+++ b/drivers/dsp/bridge/dynload/dload_internal.h
@@ -40,7 +40,6 @@ typedef u32 URVALUE;
  * Dynamic loader configuration constants
  */
 /* error issued if input has more sections than this limit */
-#define REASONABLE_SECTION_LIMIT 100
 
 /* (Addressable unit) value used to clear BSS section */
 #define dload_fill_bss 0
@@ -317,8 +316,6 @@ extern uint32_t dload_reverse_checksum_16(void *data, unsigned siz);
 #endif
 
 #define is_data_scn(zzz) (DLOAD_SECTION_TYPE((zzz)->type) != DLOAD_TEXT)
-#define is_data_scn_num(zzz) \
-		(DLOAD_SECT_TYPE(&dlthis->sect_hdrs[(zzz)-1]) != DLOAD_TEXT)
 
 /*
  * exported by reloc.c
diff --git a/drivers/dsp/bridge/dynload/doff.h b/drivers/dsp/bridge/dynload/doff.h
index 2b8fc37..51f6d2a 100644
--- a/drivers/dsp/bridge/dynload/doff.h
+++ b/drivers/dsp/bridge/dynload/doff.h
@@ -114,9 +114,7 @@ struct doff_filehdr_t {
 
 /* Supported processors */
 #define TMS470_ID   0x97
-#define LEAD_ID     0x98
 #define TMS32060_ID 0x99
-#define LEAD3_ID    0x9c
 
 /* Primary processor for loading */
 #if TMS32060
diff --git a/drivers/dsp/bridge/dynload/header.h b/drivers/dsp/bridge/dynload/header.h
index 0de744b..be71286 100644
--- a/drivers/dsp/bridge/dynload/header.h
+++ b/drivers/dsp/bridge/dynload/header.h
@@ -23,7 +23,6 @@
 #endif
 
 #include <linux/string.h>
-#define DL_STRCMP  strcmp
 
 /* maximum parenthesis nesting in relocation stack expressions */
 #define STATIC_EXPR_STK_SIZE 10
@@ -52,7 +51,6 @@ typedef unsigned short int	uint_least16_t;
 /* maximum number of code,data,etc. sections */
 #define MAX_REASONABLE_SECTIONS (200)
 /* maximum number of linker symbols */
-#define MAX_REASONABLE_SYMBOLS (100000)
 
 /* shift count to align F_BIG with DLOAD_LITTLE */
 #define ALIGN_COFF_ENDIANNESS 7
diff --git a/drivers/dsp/bridge/dynload/module_list.h b/drivers/dsp/bridge/dynload/module_list.h
index 9c4876a..cd00cdf 100644
--- a/drivers/dsp/bridge/dynload/module_list.h
+++ b/drivers/dsp/bridge/dynload/module_list.h
@@ -66,7 +66,6 @@ module's record from this list.  The dynamic loader also increments the
 
 /* Global pointer to the modules_header structure*/
 #define MODULES_HEADER "_DLModules"
-#define MODULES_HEADER_NO_UNDERSCORE "DLModules"
 
 /* Initial version number*/
 #define INIT_VERSION 1
diff --git a/drivers/dsp/bridge/dynload/params.h b/drivers/dsp/bridge/dynload/params.h
index ade430d..787c0e9 100644
--- a/drivers/dsp/bridge/dynload/params.h
+++ b/drivers/dsp/bridge/dynload/params.h
@@ -68,8 +68,6 @@
 /* TMS320C6x Target Specific Parameters (byte-addressable)                  */
 /*--------------------------------------------------------------------------*/
 #if TMS32060
-#define MEMORG          0x0L	/* Size of configured memory  */
-#define MEMSIZE         0x0L	/* (full address space)  */
 
 #define CINIT_ALIGN     8	/* alignment of cinit record in TDATA AUs */
 #define CINIT_COUNT	4	/* width of count field in TDATA AUs */
@@ -77,7 +75,6 @@
 #define CINIT_PAGE_BITS	0	/* Number of LSBs of address that
 				 * are page number */
 
-#define LENIENT_SIGNED_RELEXPS 0	/* DOES SIGNED ALLOW MAX UNSIGNED   */
 
 #undef TARGET_ENDIANNESS	/* may be big or little endian */
 
diff --git a/drivers/dsp/bridge/dynload/reloc_table.h b/drivers/dsp/bridge/dynload/reloc_table.h
index 6326146..bb3d519 100644
--- a/drivers/dsp/bridge/dynload/reloc_table.h
+++ b/drivers/dsp/bridge/dynload/reloc_table.h
@@ -24,7 +24,6 @@
 #include <linux/types.h>
 
 /* How does this relocation operation access the program image? */
-#define ROP_N	0		/* does not access image */
 #define ROP_R	1		/* read from image */
 #define ROP_W	2		/* write to image */
 #define ROP_RW	3		/* read from and write to image */
@@ -37,16 +36,11 @@
 #define ROP_MAX 3	  /* allow maximum range of either signed or unsigned */
 
 /* How does the relocation operation use the symbol reference */
-#define ROP_IGN	0		/* no symbol is referenced */
-#define ROP_LIT 0		/* use rp->r_uval literal field */
 #define ROP_SYM	1		/* symbol value is used in relocation */
 #define ROP_SYMD 2		/* delta value vs last link is used */
 
 /* How does the reloc op use the stack? */
-#define RSTK_N 0		/* Does not use */
-#define RSTK_POP 1		/* Does a POP */
 #define RSTK_UOP 2		/* Unary op, stack position unaffected */
-#define RSTK_PSH 3		/* Does a push */
 
 /*
  * Computational actions performed by the dynamic loader
@@ -90,7 +84,6 @@ enum Dload_Actions {
 #define RFV_SIGN(iii) (((iii) >> 2) & 0x3)
 #define RFV_SYM(iii) (((iii) >> 4) & 0x3)
 #define RFV_STK(iii) (((iii) >> 6) & 0x3)
-#define RFV_ACCS(iii) ((iii) & 0x3)
 
 #if (TMS32060)
 #define RFV_SCALE(iii) ((iii) >> 11)
diff --git a/drivers/dsp/bridge/hw/GlobalTypes.h b/drivers/dsp/bridge/hw/GlobalTypes.h
index 9004a37..1d004bf 100644
--- a/drivers/dsp/bridge/hw/GlobalTypes.h
+++ b/drivers/dsp/bridge/hw/GlobalTypes.h
@@ -58,31 +58,20 @@
  *
  * DESCRIPTION:  offset in bytes from start of 32-bit word.
  */
-#define LOWER_16BIT_OFFSET	  0
-#define UPPER_16BIT_OFFSET	  2
 
-#define LOWER_8BIT_OFFSET	   0
-#define LOWER_MIDDLE_8BIT_OFFSET    1
-#define UPPER_MIDDLE_8BIT_OFFSET    2
-#define UPPER_8BIT_OFFSET	   3
 
-#define LOWER_8BIT_OF16_OFFSET      0
-#define UPPER_8BIT_OF16_OFFSET      1
 
 /*
  * Definition: *BIT_SHIFT
  *
  * DESCRIPTION:  offset in bits from start of 32-bit word.
  */
-#define LOWER_16BIT_SHIFT	  0
 #define UPPER_16BIT_SHIFT	  16
 
-#define LOWER_8BIT_SHIFT	   0
 #define LOWER_MIDDLE_8BIT_SHIFT    8
 #define UPPER_MIDDLE_8BIT_SHIFT    16
 #define UPPER_8BIT_SHIFT	   24
 
-#define LOWER_8BIT_OF16_SHIFT      0
 #define UPPER_8BIT_OF16_SHIFT      8
 
 
@@ -175,15 +164,6 @@
 	LOWER_8BIT_MASK)
 
 /*
- * Definition: READ_LOWER_MIDDLE_8BITS_OF_32(value32bits)
- *
- * DESCRIPTION:  Returns a 8 lower middle bits of 32bit value
- */
-#define READ_UPPER_MIDDLE_8BITS_OF_32(value32bits)\
-	(((u8)((u32)(value32bits) >> LOWER_MIDDLE_8BIT_SHIFT)) &\
-	LOWER_8BIT_MASK)
-
-/*
  * Definition: READ_UPPER_8BITS_OF_32(value32bits)
  *
  * DESCRIPTION:  Returns a 8 upper bits of 32bit value
@@ -305,21 +285,14 @@ typedef enum ReturnCode_label {
 #define CHECK_RETURN_VALUE(actualValue, expectedValue,  returnCodeIfMismatch,\
 	spyCodeIfMisMatch)
 #define CHECK_RETURN_VALUE_RET(actualValue, expectedValue, returnCodeIfMismatch)
-#define CHECK_RETURN_VALUE_RES(actualValue, expectedValue, spyCodeIfMisMatch)
-#define CHECK_RETURN_VALUE_RET_VOID(actualValue, expectedValue,\
-	spyCodeIfMisMatch)
 
 #define CHECK_INPUT_PARAM(actualValue, invalidValue, returnCodeIfMismatch,\
 	spyCodeIfMisMatch)
-#define CHECK_INPUT_PARAM_NO_SPY(actualValue, invalidValue,\
-	returnCodeIfMismatch)
 #define CHECK_INPUT_RANGE(actualValue, minValidValue, maxValidValue,\
 	returnCodeIfMismatch, spyCodeIfMisMatch)
 #define CHECK_INPUT_RANGE_NO_SPY(actualValue, minValidValue, maxValidValue,\
 	returnCodeIfMismatch)
 #define CHECK_INPUT_RANGE_MIN0(actualValue, maxValidValue,\
 	returnCodeIfMismatch, spyCodeIfMisMatch)
-#define CHECK_INPUT_RANGE_NO_SPY_MIN0(actualValue, maxValidValue,\
-	returnCodeIfMismatch)
 
 #endif	/* __GLOBALTYPES_H */
diff --git a/drivers/dsp/bridge/hw/MMUAccInt.h b/drivers/dsp/bridge/hw/MMUAccInt.h
index 6ca1573..0558e03 100644
--- a/drivers/dsp/bridge/hw/MMUAccInt.h
+++ b/drivers/dsp/bridge/hw/MMUAccInt.h
@@ -55,7 +55,6 @@
 #define MMU_MMU_LD_TLB_OFFSET  0x54
 #define MMU_MMU_CAM_OFFSET   0x58
 #define MMU_MMU_RAM_OFFSET   0x5c
-#define MMU_MMU_GFLUSH_OFFSET  0x60
 #define MMU_MMU_FLUSH_ENTRY_OFFSET  0x64
 /* Bitfield mask and offset declarations */
 #define MMU_MMU_SYSCONFIG_IdleMode_MASK  0x18
diff --git a/drivers/dsp/bridge/hw/PRCMAccInt.h b/drivers/dsp/bridge/hw/PRCMAccInt.h
index 5a11f01..fbc6bae 100644
--- a/drivers/dsp/bridge/hw/PRCMAccInt.h
+++ b/drivers/dsp/bridge/hw/PRCMAccInt.h
@@ -32,8 +32,6 @@
 						(PRCM_BASE_EASIL1 + 1305)
 #define EASIL1_PRCMCM_ICLKEN1_COREEN_GPT7Write32	\
 						(PRCM_BASE_EASIL1 + 1315)
-#define EASIL1_PRCMCM_CLKSEL1_CORECLKSEL_L3ReadIssel132	\
-						(PRCM_BASE_EASIL1 + 2261)
 #define EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8Write32k32	\
 						(PRCM_BASE_EASIL1 + 2364)
 #define EASIL1_PRCMCM_CLKSEL2_CORECLKSEL_GPT8WriteSys32	\
diff --git a/drivers/dsp/bridge/hw/PRCMRegAcM.h b/drivers/dsp/bridge/hw/PRCMRegAcM.h
index 280a812..b293e37 100644
--- a/drivers/dsp/bridge/hw/PRCMRegAcM.h
+++ b/drivers/dsp/bridge/hw/PRCMRegAcM.h
@@ -41,16 +41,6 @@
 }
 
 
-#define CM_FCLKEN_PERReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),\
-      __raw_readl(((u32)(baseAddress))+CM_FCLKEN_PER_OFFSET))
-
-
-#define CM_ICLKEN_PERReadRegister32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),\
-      __raw_readl(((u32)(baseAddress))+CM_ICLKEN_PER_OFFSET))
-
-
 #define CM_FCLKEN_PER_GPT5WriteRegister32(baseAddress,value)\
 {\
     const u32 offset = CM_FCLKEN_PER_OFFSET;\
@@ -66,21 +56,6 @@
 }
 
 
-#define CM_FCLKEN_PER_GPT6WriteRegister32(baseAddress,value)\
-{\
-    const u32 offset = CM_FCLKEN_PER_OFFSET;\
-    register u32 data =\
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_CM_FCLKEN_PER_GPT5WriteRegister32);\
-   data &= ~(CM_FCLKEN_PER_GPT6_MASK);\
-   newValue <<= CM_FCLKEN_PER_GPT6_OFFSET;\
-   newValue &= CM_FCLKEN_PER_GPT6_MASK;\
-   newValue |= data;\
-    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
-}
-
-
 #define CM_ICLKEN_PER_GPT5WriteRegister32(baseAddress,value)\
 {\
     const u32 offset = CM_ICLKEN_PER_OFFSET;\
@@ -96,21 +71,6 @@
 }
 
 
-#define CM_ICLKEN_PER_GPT6WriteRegister32(baseAddress,value)\
-{\
-    const u32 offset = CM_ICLKEN_PER_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_CM_ICLKEN_PER_GPT5WriteRegister32);\
-   data &= ~(CM_ICLKEN_PER_GPT6_MASK);\
-   newValue <<= CM_ICLKEN_PER_GPT6_OFFSET;\
-   newValue &= CM_ICLKEN_PER_GPT6_MASK;\
-   newValue |= data;\
-    __raw_writel(newValue, ((u32)(baseAddress))+offset);\
-}
-
-
 #define CM_FCLKEN1_COREReadRegister32(baseAddress)\
     (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN1_COREReadRegister32),\
       __raw_readl(((u32)(baseAddress))+CM_FCLKEN1_CORE_OFFSET))
@@ -359,22 +319,6 @@
       PRCM_CM_CLKSEL1_PLL_APLLs_Clkin_MASK) >>\
       PRCM_CM_CLKSEL1_PLL_APLLs_Clkin_OFFSET))
 
-
-#define CM_FCLKEN_IVA2EN_DSPWrite32(baseAddress,value)\
-{\
-    const u32 offset = CM_FCLKEN_IVA2_OFFSET;\
-    register u32 data = \
-	__raw_readl(((u32)(baseAddress))+offset);\
-    register u32 newValue = ((u32)(value));\
-    _DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_FCLKEN_DSPEN_DSPWrite32);\
-    data &= ~(CM_FCLKEN_IVA2_EN_MASK);\
-    newValue <<= CM_FCLKEN_IVA2_EN_OFFSET;\
-    newValue &= CM_FCLKEN_IVA2_EN_MASK;\
-    newValue |= data;\
-    __raw_writel(newValue, (u32)(baseAddress)+offset);\
-}
-
-
 #define PRCMCM_ICLKEN_DSPEN_DSP_IPIWrite32(baseAddress, value)\
 {\
     const u32 offset = PRCM_CM_ICLKEN_DSP_OFFSET;\
@@ -403,14 +347,6 @@
       PRCM_CM_IDLEST_DSP_ST_IPI_OFFSET))
 
 
-#define PRM_IDLEST_IVA2ST_IVA2Read32(baseAddress)\
-    (_DEBUG_LEVEL_1_EASI(EASIL1_PRCMCM_IDLEST_DSPST_DSPRead32),\
-      (((__raw_readl((((u32)(baseAddress))+\
-	  (CM_IDLEST_IVA2_OFFSET)))) &\
-      CM_IDLEST_IVA2_ST_IVA2_MASK) >>\
-      CM_IDLEST_IVA2_ST_IVA2_OFFSET))
-
-
 #define PRCMCM_AUTOIDLE_DSPAUTO_DSP_IPIWrite32(baseAddress, value)\
 {\
     const u32 offset = PRCM_CM_AUTOIDLE_DSP_OFFSET;\
diff --git a/drivers/dsp/bridge/hw/hw_dspssC64P.h b/drivers/dsp/bridge/hw/hw_dspssC64P.h
index 50f9af4..bf7e4ad 100644
--- a/drivers/dsp/bridge/hw/hw_dspssC64P.h
+++ b/drivers/dsp/bridge/hw/hw_dspssC64P.h
@@ -39,7 +39,6 @@
 		HW_DSPSYSC_DEFAULTRESTORE = 0x4
 	} ;
 
-#define HW_DSP_IDLEBOOT_ADDR   0x007E0000
 
 	extern HW_STATUS HW_DSPSS_BootModeSet(const void __iomem *baseAddress,
 					enum HW_DSPSYSC_BootMode_t bootMode,
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
index 203964c..4f12d00 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -28,11 +28,8 @@
 
 /* Bitmasks for Mailbox interrupt sources */
 #define HW_MBOX_INT_NEW_MSG    0x1
-#define HW_MBOX_INT_NOT_FULL   0x2
-#define HW_MBOX_INT_ALL	0x3
 
 /* Maximum number of messages that mailbox can hald at a time. */
-#define HW_MBOX_MAX_NUM_MESSAGES   4
 
 /* HW_MBOX_Id_t: Enumerated Type used to specify Mailbox Sub Module Id Number */
 typedef enum HW_MBOX_Id_label {
diff --git a/drivers/dsp/bridge/pmgr/chnlobj.h b/drivers/dsp/bridge/pmgr/chnlobj.h
index da74c96..56b6203 100644
--- a/drivers/dsp/bridge/pmgr/chnlobj.h
+++ b/drivers/dsp/bridge/pmgr/chnlobj.h
@@ -42,9 +42,6 @@
 #define CHNL_IsValidMgr(h) \
 		((h != NULL) && ((h)->dwSignature == CHNL_MGRSIGNATURE))
 
-#define CHNL_IsValidChnl(h)\
-		((h != NULL) && ((h)->dwSignature == CHNL_SIGNATURE))
-
 /*
  *  This struct is the first field in a CHNL_MGR struct, as implemented in
  *  a WMD channel class library.  Other, implementation specific fields
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 96bf7d3..4093fcb 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -36,22 +36,13 @@ struct MAP_L4PERIPHERAL {
 	u32 dspVirtAddr;
 } ;
 
-#define ARM_MAILBOX_START               0xfffcf000
-#define ARM_MAILBOX_LENGTH              0x800
 
 /* New Registers in OMAP3.1 */
 
-#define TESTBLOCK_ID_START              0xfffed400
-#define TESTBLOCK_ID_LENGTH             0xff
 
 /* ID Returned by OMAP1510 */
-#define TBC_ID_VALUE                    0xB47002F
 
-#define SPACE_LENGTH                    0x2000
-#define API_CLKM_DPLL_DMA               0xfffec000
-#define ARM_INTERRUPT_OFFSET            0xb00
 
-#define BIOS_24XX
 
 #define L4_PERIPHERAL_NULL          0x0
 #define DSPVA_PERIPHERAL_NULL       0x0
@@ -98,8 +89,6 @@ struct MAP_L4PERIPHERAL {
 #define L4_PERIPHERAL_CAMERA      0x480BC000
 #define DSPVA_PERIPHERAL_CAMERA   0x11819000
 
-#define L4_PERIPHERAL_SDMA        0x48056000
-#define DSPVA_PERIPHERAL_SDMA     0x11810000 /*0x1181d000 conflicts with PER */
 
 #define L4_PERIPHERAL_UART1             0x4806a000
 #define DSPVA_PERIPHERAL_UART1          0x11811000
@@ -205,10 +194,8 @@ static const struct MAP_L4PERIPHERAL L4PeripheralTable[] = {
 #define MBX_PM_CLK_CMDMASK 7
 
 /* MBX_PM_MAX_RESOURCES: CORE 1 Clock resources. */
-#define MBX_CORE1_RESOURCES 7
 
 /* MBX_PM_MAX_RESOURCES: CORE 2 Clock Resources. */
-#define MBX_CORE2_RESOURCES 1
 
 /* MBX_PM_MAX_RESOURCES: TOTAL Clock Reosurces. */
 #define MBX_PM_MAX_RESOURCES 11
@@ -271,10 +258,7 @@ static const struct BPWR_Clk_t BPWR_Clks[] = {
 };
 
 /* Interrupt Register Offsets */
-#define INTH_IT_REG_OFFSET              0x00	/* Interrupt register offset  */
-#define INTH_MASK_IT_REG_OFFSET         0x04	/* Mask Interrupt reg offset  */
 
-#define   DSP_MAILBOX1_INT              10
 
 /*
  *  INTH_InterruptKind_t
@@ -295,15 +279,10 @@ enum INTH_SensitiveEdge_t {
  */
 
 /* Mail Box defines */
-#define MB_ARM2DSP1_REG_OFFSET          0x00
 
-#define MB_ARM2DSP1B_REG_OFFSET         0x04
 
-#define MB_DSP2ARM1B_REG_OFFSET         0x0C
 
-#define MB_ARM2DSP1_FLAG_REG_OFFSET     0x18
 
-#define MB_ARM2DSP_FLAG                 0x0001
 
 #define MBOX_ARM2DSP HW_MBOX_ID_0
 #define MBOX_DSP2ARM HW_MBOX_ID_1
@@ -313,22 +292,12 @@ enum INTH_SensitiveEdge_t {
 #define ENABLE                          true
 #define DISABLE                         false
 
-#define HIGH_LEVEL                      true
 #define LOW_LEVEL                       false
 
 /* Macro's */
-#define REG16(A)    (*(REG_UWORD16 *)(A))
 
 #define ClearBit(reg, mask)             (reg &= ~mask)
-#define SetBit(reg, mask)               (reg |= mask)
 
-#define SetGroupBits16(reg, position, width, value) \
-	do {\
-		reg &= ~((0xFFFF >> (16 - (width))) << (position)) ; \
-		reg |= ((value & (0xFFFF >> (16 - (width)))) << (position)); \
-	} while (0);
-
-#define ClearBitIndex(reg, index)   (reg &= ~(1 << (index)))
 
 /* This mini driver's device context: */
 struct WMD_DEV_CONTEXT {
diff --git a/drivers/dsp/bridge/wmd/_tiomap_util.h b/drivers/dsp/bridge/wmd/_tiomap_util.h
index bd1b571..8349dcb 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_util.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_util.h
@@ -38,7 +38,6 @@
 #define PWRSTST_TIMEOUT		200
 
 /*  Time delay for HOM->SAM transition. */
-#define  WAIT_SAM   1000000	/* in usec (1000 millisec) */
 
 /*
  *  ======== WaitForStart ========
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.h b/drivers/dsp/bridge/wmd/tiomap_io.h
index 84a7553..c68e9c8 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.h
+++ b/drivers/dsp/bridge/wmd/tiomap_io.h
@@ -39,9 +39,6 @@
 #define EXTBASE     "EXT_BEG"
 #define EXTEND      "_EXT_END"
 #define DYNEXTBASE  "_DYNEXT_BEG"
-#define DYNEXTEND   "_DYNEXT_END"
-#define IVAEXTMEMBASE   "_IVAEXTMEM_BEG"
-#define IVAEXTMEMEND   "_IVAEXTMEM_END"
 
 
 #define DSP_TRACESEC_BEG  "_BRIDGE_TRACE_BEG"
@@ -52,7 +49,6 @@
 #define BRIDGE_SYS_PUTC_current   "_BRIDGE_SYS_PUTC_current"
 
 
-#define WORDSWAP_ENABLE 0x3	/* Enable word swap */
 
 /*
  *  ======== ReadExtDspData ========
-- 
1.6.3.3

