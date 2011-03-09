From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: PM: Set static dependency between MPUSS and EMIF
Date: Tue, 08 Mar 2011 16:12:17 -0800
Message-ID: <87ei6hnoda.fsf@ti.com>
References: <1299596946-31334-1-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1103081619500.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39123 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756692Ab1CIAMV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 19:12:21 -0500
Received: by gyh3 with SMTP id 3so126gyh.36
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 16:12:20 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103081619500.15132@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 8 Mar 2011 16:22:52 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 8 Mar 2011, Santosh Shilimkar wrote:
>
>> As per OMAP4430 TRM, the dynamic dependency between MEMIF and MPUSS
>> clockdomains is enable by default. Refer register CM_MPU_DYNAMICDEP
>> description for details.
>> 
>> But it doesn't seems to work as expected and MPUSS doesn't wakeup
>> from off-mode if the static dependency is not set between MPUSS and
>> EMIF clockdomains. i.e CM_MPU_STATICDEP.MEMIF_STATDEP = 0
>> 
>> The issue is under investigation with hardware team.
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> Nice work!
>
> Kevin, you want to take this one?

Yup

> My only comment is that it might be nice to add a pr_info("OMAP4 
> PM: Temporary static dependency added between EMIF and MPUSS");
> in there to reduce the risk that the issue will be forgotten...
>
> Acked-by: Paul Walmsley <paul@pwsan.com>

Santosh, 

Please update with the pr_info() as suggested by Paul, repost with
linux-arm-kernel in Cc, add Paul's ack and I'll queue for 2.6.39.

Thanks,

Kevin
