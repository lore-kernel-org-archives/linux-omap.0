From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 5/9] DSPBRIDGE: trivial cleanup and indentation for io_sm
Date: Wed, 25 Nov 2009 13:47:00 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426F2677B@dlee03.ent.ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-4-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-5-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
 <20091125191509.GA28486@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54274 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbZKYTrA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 14:47:00 -0500
In-Reply-To: <20091125191509.GA28486@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

>From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
>Subject: Re: [PATCH 5/9] DSPBRIDGE: trivial cleanup and indentation for io_sm
>
>On Tue, Nov 24, 2009 at 01:50:26AM +0100, ext Omar Ramirez Luna wrote:
>>Remove duplicate set of braces from if statement and reduce
>>indentation.
>>
>>Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>>---
>> drivers/dsp/bridge/wmd/io_sm.c |   96 +++++++++++++++++-----------------------
>> 1 files changed, 40 insertions(+), 56 deletions(-)
>>
>>diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
>>index af31831..96a5aa6 100644
>>--- a/drivers/dsp/bridge/wmd/io_sm.c
>>+++ b/drivers/dsp/bridge/wmd/io_sm.c
>>@@ -115,7 +115,7 @@ struct IO_MGR {
>> 	/* private extnd proc info; mmu setup */
>> 	struct MGR_PROCESSOREXTINFO extProcInfo;
>> 	struct CMM_OBJECT *hCmmMgr; 	/* Shared Mem Mngr	      */
>>-       struct work_struct io_workq;     /*workqueue */
>>+	struct work_struct io_workq;     /*workqueue */
>
>while at that: /* workqueue */
>
>add the missing space.

Agree.

>
>> 	u32 dQuePowerMbxVal[MAX_PM_REQS];
>> 	u32 iQuePowerHead;
>> 	u32 iQuePowerTail;
>>@@ -185,7 +185,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
>> 	struct CFG_HOSTRES hostRes;
>> 	struct CFG_DEVNODE *hDevNode;
>> 	struct CHNL_MGR *hChnlMgr;
>>-       static int ref_count;
>>+	static int ref_count;
>> 	u32 devType;
>> 	/* Check requirements:  */
>> 	if (!phIOMgr || !pMgrAttrs || pMgrAttrs->uWordSize == 0) {
>>@@ -197,9 +197,10 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
>> 		status = DSP_EHANDLE;
>> 		goto func_end;
>> 	}
>>-	 /*  Message manager will be created when a file is loaded, since
>>+	/*  Message manager will be created when a file is loaded, since
>> 	 *  size of message buffer in shared memory is configurable in
>>-	 *  the base image.  */
>>+	 *  the base image.
>>+	 */
>
>same here... it should be:
>
>/* multi-line comment start here and has only one
>  * space after the * character.
>  * If you could remove the extra space above would
>  * be nice.
>  */
>

Agree.

- omar
