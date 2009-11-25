From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 6/9] DSPBRIDGE: Remove DPC, create, destroy and
 schedule wrappers
Date: Wed, 25 Nov 2009 21:17:26 +0200
Message-ID: <20091125191726.GB28486@nokia.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-4-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-5-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-7-git-send-email-omar.ramirez@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56036 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759080AbZKYTT7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 14:19:59 -0500
Content-Disposition: inline
In-Reply-To: <1259023830-7557-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

Hi,

On Tue, Nov 24, 2009 at 01:50:27AM +0100, ext Omar Ramirez Luna wrote:
>+/* The DPC object, passed to our priority event callback routine: */
>+struct DPC_OBJECT {
>+       u32 dwSignature;        /* Used for object validation.   */
>+       void *pRefData;         /* Argument for client's DPC.    */
>+       DPC_PROC pfnDPC;        /* Client's DPC.                 */
>+       u32 numRequested;       /* Number of requested DPC's.      */
>+       u32 numScheduled;       /* Number of executed DPC's.      */
>+       struct tasklet_struct dpc_tasklet;

as a suggestion for upcoming patches... how about removing the variable 
types from its name and get rid of CaMeLcAsE ?

I mean:

-	u32 dwSignature;
+	u32 signature;

-- 
balbi
