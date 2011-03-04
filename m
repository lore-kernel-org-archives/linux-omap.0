From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP2/3: VENC hwmod: add OCPIF_SWSUP_IDLE flag to interface
Date: Fri, 4 Mar 2011 11:57:56 +0100
Message-ID: <4D70C5B4.3080401@ti.com>
References: <alpine.DEB.2.00.1103032300480.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48835 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084Ab1CDK6F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 05:58:05 -0500
In-Reply-To: <alpine.DEB.2.00.1103032300480.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

+ Tomi

Hi Paul,

On 3/4/2011 7:02 AM, Paul Walmsley wrote:
>
> According to the hwmod interface data, the DSS submodule "VENC" uses a
> clock, "dss_54m_fck"/"dss_tv_fck", which the PRCM cannot autoidle.  By
> default, the hwmod code assumes that interface clocks can be autoidled
> by the PRCM.  When the interface clock can't be autoidled by the PRCM,
> those interfaces must be marked with the OCPIF_SWSUP_IDLE flag.
> Otherwise, the "interface clock" will always have a non-zero use
> count, and the device won't enter idle.  This problem was observed on
> N8x0.
>
> Fix the immediate problem by marking the VENC interface with the
> OCPIF_SWSUP_IDLE flag.  But it's not clear that
> "dss_54m_fck"/"dss_tv_fck" is really the correct interface clock for
> VENC.  It may be that the VENC interface should use a
> hardware-autoidling interface clock.  This is the situation on OMAP4,
> which uses "l3_div_ck" as the VENC interface clock, which can be
> autoidled by the PRCM.  Clarification from TI is needed.

Yep, this is clearly wrong, all DSS modules are using the same 
interconnect port from the L4, thus they should all use the dss_ick as 
interface clock and not the functional clock dss_tv_fck.

There is something strange with that module because the main_clk is 
attached to dss1_alwon_fck instead of dss_tv_fck.

I'm quite sure that both are needed to make that module work and that's 
why it was added as an interface clock.
In theory, one of them should be an optional clock like on OMAP4.


Sumit,

Could you explain the rational behind the usage of dss_tv_fck as an iclk 
and dss1_alwon_fck as a fclk?

Thanks,
Benoit
