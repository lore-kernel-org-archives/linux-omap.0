From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 6/9] DSPBRIDGE: Remove DPC, create, destroy and schedule
 wrappers
Date: Wed, 25 Nov 2009 13:44:14 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426F26773@dlee03.ent.ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-4-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-5-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-7-git-send-email-omar.ramirez@ti.com>
 <20091125191726.GB28486@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39782 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758911AbZKYToO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 14:44:14 -0500
In-Reply-To: <20091125191726.GB28486@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

>From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
>Subject: Re: [PATCH 6/9] DSPBRIDGE: Remove DPC, create, destroy and schedule wrappers
>
>Hi,
>
>On Tue, Nov 24, 2009 at 01:50:27AM +0100, ext Omar Ramirez Luna wrote:
>>+/* The DPC object, passed to our priority event callback routine: */
>>+struct DPC_OBJECT {
>>+       u32 dwSignature;        /* Used for object validation.   */
>>+       void *pRefData;         /* Argument for client's DPC.    */
>>+       DPC_PROC pfnDPC;        /* Client's DPC.                 */
>>+       u32 numRequested;       /* Number of requested DPC's.      */
>>+       u32 numScheduled;       /* Number of executed DPC's.      */
>>+       struct tasklet_struct dpc_tasklet;
>
>as a suggestion for upcoming patches... how about removing the variable
>types from its name and get rid of CaMeLcAsE ?
>
>I mean:
>
>-	u32 dwSignature;
>+	u32 signature;

Done for patch DSPBRIDGE: Remove DPC object structure, I removed the structure because it was used only for IO and MMUfault (in future for WDT too), besides not every field were used anyway.

@@ -128,6 +126,12 @@ struct IO_MGR {
 	u32 ulGppVa;
 	u32 ulDspVa;
 #endif
+	/* IO Dpc */
+	u32 dpc_req;				/* Number of requested DPC's. */
+	u32 dpc_sched;				/* Number of executed DPC's. */
+	struct tasklet_struct dpc_tasklet;
+	spinlock_t dpc_lock;
+
 } ;

- omar
