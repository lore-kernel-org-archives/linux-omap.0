From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [Patch 4/8] DSPBRIDGE: typedef cleanup -DSP_HSTREAM
Date: Wed, 3 Feb 2010 00:37:45 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA5737AE@dlee06.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044A6B9674@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41945 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862Ab0BCGhr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 01:37:47 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o136blqu009284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 00:37:47 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o136bkuB023666
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 00:37:46 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o136bkKD012692
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 00:37:46 -0600 (CST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A6B9674@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>, linux-omap <linux-omap@vger.kernel.org>



Looks good to me.

Regards,
Fernando.

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Hebbar, Shivananda
>Sent: Tuesday, February 02, 2010 6:44 PM
>To: linux-omap
>Subject: [Patch 4/8] DSPBRIDGE: typedef cleanup -DSP_HSTREAM
>
>From d3edb20499a7b084a7510d9930264ff2935a6048 Mon Sep 17 00:00:00 2001
>From: Shivananda Hebbar <x0hebbar@ti.com>
>Date: Fri, 29 Jan 2010 15:32:44 -0600
>Subject: [PATCH] DSPBRIDGE :Remove typedefs used for stream handle and
>replace it with normal C types
>
>This patch removes typedef used for stream handle and replaces it with the
>normal C types.
>---
> arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    1 -
> arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
> arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   22 +++++++++++--------
>---
> 3 files changed, 12 insertions(+), 13 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-
>omap/include/dspbridge/dbdefs.h
>index 36cd569..c0d4c1d 100644
>--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
>+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
>@@ -111,7 +111,6 @@
>
> 	typedef HANDLE DSP_HNODE;	/* Handle to a DSP Node object  */
> 	typedef HANDLE DSP_HPROCESSOR;	/* Handle to a Processor object
>*/
>-	typedef HANDLE DSP_HSTREAM;	/* Handle to a Stream object    */
>
> /* Handy Macros */
> #define IsValidProcEvent(x) (((x) == 0) || (((x) &
>(DSP_PROCESSORSTATECHANGE | \ diff --git a/arch/arm/plat-
>omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
>index e4e91f3..3eb1abd 100644
>--- a/arch/arm/plat-omap/include/dspbridge/drv.h
>+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
>@@ -116,7 +116,7 @@ struct DSPHEAP_RES_OBJECT {
> /* New structure (member of process context) abstracts stream resource
>info */  struct STRM_RES_OBJECT {
> 	s32                    streamAllocated; /* Stream status */
>-	DSP_HSTREAM             hStream;
>+	void *hStream;
> 	u32                    uNumBufs;
> 	u32                    uDir;
> 	struct STRM_RES_OBJECT         *next;
>diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
>b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
>index 0dcbef7..9d1cdb3 100644
>--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
>+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
>@@ -262,40 +262,40 @@ union Trapped_Args {
> 	/* STRM module */
>
> 	struct {
>-		DSP_HSTREAM hStream;
>+		void *hStream;
> 		u32 uSize;
> 		u8 *__user *apBuffer;
> 		u32 uNumBufs;
> 	} ARGS_STRM_ALLOCATEBUFFER;
>
> 	struct {
>-		DSP_HSTREAM hStream;
>+		void *hStream;
> 	} ARGS_STRM_CLOSE;
>
> 	struct {
>-		DSP_HSTREAM hStream;
>+		void *hStream;
> 		u8 *__user *apBuffer;
> 		u32 uNumBufs;
> 	} ARGS_STRM_FREEBUFFER;
>
> 	struct {
>-		DSP_HSTREAM hStream;
>+		void *hStream;
> 		HANDLE *phEvent;
> 	} ARGS_STRM_GETEVENTHANDLE;
>
> 	struct {
>-		DSP_HSTREAM hStream;
>+		void *hStream;
> 		struct STRM_INFO __user *pStreamInfo;
> 		u32 uStreamInfoSize;
> 	} ARGS_STRM_GETINFO;
>
> 	struct {
>-		DSP_HSTREAM hStream;
>+		void *hStream;
> 		bool bFlush;
> 	} ARGS_STRM_IDLE;
>
> 	struct {
>-		DSP_HSTREAM hStream;
>+		void *hStream;
> 		u8 *pBuffer;
> 		u32 dwBytes;
> 		u32 dwBufSize;
>@@ -307,11 +307,11 @@ union Trapped_Args {
> 		u32 uDirection;
> 		u32 uIndex;
> 		struct STRM_ATTR __user *pAttrIn;
>-		DSP_HSTREAM __user *phStream;
>+		void *__user *phStream;
> 	} ARGS_STRM_OPEN;
>
> 	struct {
>-		DSP_HSTREAM hStream;
>+		void *hStream;
> 		u8 *__user *pBufPtr;
> 		u32 __user *pBytes;
> 		u32 __user *pBufSize;
>@@ -319,14 +319,14 @@ union Trapped_Args {
> 	} ARGS_STRM_RECLAIM;
>
> 	struct {
>-		DSP_HSTREAM hStream;
>+		void *hStream;
> 		u32 uEventMask;
> 		u32 uNotifyType;
> 		struct DSP_NOTIFICATION __user *hNotification;
> 	} ARGS_STRM_REGISTERNOTIFY;
>
> 	struct {
>-		DSP_HSTREAM __user *aStreamTab;
>+		void *__user *aStreamTab;
> 		u32 nStreams;
> 		u32 __user *pMask;
> 		u32 uTimeout;
>--
>1.6.0.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
