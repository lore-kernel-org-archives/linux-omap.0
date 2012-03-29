From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V3 0/3] ARM: OMAP2+: Add powerdomain & PRM support for AM33XX device
Date: Thu, 29 Mar 2012 11:03:40 -0700
Message-ID: <87limjl1xf.fsf@ti.com>
References: <1331809586-24652-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:43274 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755465Ab2C2SDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Mar 2012 14:03:45 -0400
Received: by pbcun4 with SMTP id un4so491603pbc.22
        for <linux-omap@vger.kernel.org>; Thu, 29 Mar 2012 11:03:43 -0700 (PDT)
In-Reply-To: <1331809586-24652-1-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Thu, 15 Mar 2012 16:36:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, tony@atomide.com, paul@pwsan.com, rnayak@ti.com

Hi Vaibhav,

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> After going round-n-round on how to add support for AM33XX family
> of device into kernel, especially for PRM and CM support, we have
> decided to handle it separately; as AM33XX-PRCM module is different
> than OMAP3 and OMAP4 architecture.
>
> The difference becomes very interesting/weird when it comes to
> the consistency for register offsets in PRM address space and
> bit-field offsets inside PRM registers,
> So along with Powerdomain data and PRM api's required for AM33XX
> device, this patch series adds,
>
>  - XXX_RSTST register offset to "struct omap_hwmod_omap4_prcm"
>  - PWRSTCTRL & PWRSTST register offsets to "struct powerdomain"
>  - Logicretstate and mem_on/ret/pwrst/retst mask to "struct powerdomain"
>
>
> Testing: This patch series has been boot tested on AM37xEVM and AM335x
>          based BeagleBone community board.
>
> THANKS TO PAUL HERE...for helping and concluding on this, soon I will
> have similar patch for CM support, then clock-tree and hwmod will follow...
>
> Changes from V1 & V2:
> 	- Rolled back to my original approach, where AM33xx device was
> 	  handled separately (RFC version).

My apologies for causing the run around.  

This approach (without the prminst layer) is indeed a better approach.

Thanks for your patience (and persistence.)

I went to give this a test on my BeagleBone, but it doesn't apply to
mainline.  What upstream commit is this supposed to apply onto.  I tried
it on v3.3, but patch 3 fails with a conflict in io.c.

Looking at your am335x-staging branch, it seems that it depends on
previous changes to io.c made in:

        arm:omap:am33xx: Add AM335XEVM machine support

That patch appears to need an update for mainline as well.

Kevin
