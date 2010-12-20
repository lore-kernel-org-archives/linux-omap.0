From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v7 12/12] OMAP2: dmtimer: set wakeup enable explicitly in plat
Date: Mon, 20 Dec 2010 15:46:23 -0800
Message-ID: <877hf43t4g.fsf@deeprootsystems.com>
References: <1292882719-30255-1-git-send-email-tarun.kanti@ti.com>
	<1292882719-30255-13-git-send-email-tarun.kanti@ti.com>
	<4D0FE2A7.2000506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57697 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933365Ab0LTXq2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 18:46:28 -0500
Received: by ywl5 with SMTP id 5so1542194ywl.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 15:46:28 -0800 (PST)
In-Reply-To: <4D0FE2A7.2000506@ti.com> (Benoit Cousson's message of "Tue, 21
	Dec 2010 00:11:35 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Tarun,
>
> On 12/20/2010 11:05 PM, DebBarma, Tarun Kanti wrote:
>> For some reason the wakeup enable bit is not getting set on OMAP2430,
>> OMAP2420. This is inspite of the fact that SYSC_HAS_ENAWAKEUP flag is
>> present in the hwmod database.
>
> This is indeed strange. Did you observe that on OMAP3 & 4?
> Did you use the patch that Kevin did recently to fix an issue with the
> ENAWAKEUP bit?
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=d15ae13fc7428a95b02c1935ebf92324fcb80a5f
>
> The point is that this fix is not really acceptable for my point of view:-(
>
> You really have to check what is going on in the hwmod _enable_wakeup
> function.

I completely agree with Benoit.

We cannot merge a fix like this without understanding the root cause.

Kevin
