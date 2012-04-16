From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/3] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Mon, 16 Apr 2012 19:50:42 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9EEE43@DBDE01.ent.ti.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
 <1334579125-15566-3-git-send-email-tarun.kanti@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9EE79A@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204161326420.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47713 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754374Ab2DPTuv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 15:50:51 -0400
In-Reply-To: <alpine.DEB.2.00.1204161326420.29048@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Tue, Apr 17, 2012 at 00:57:40, Paul Walmsley wrote:
> On Mon, 16 Apr 2012, Hiremath, Vaibhav wrote:
> 
> > Doesn't this impact OMAP3x family?
> > The interface clocks will be enabled in omap_hwmod_enable(), 
> > only if you set OCPIF_SWSUP_IDLE flag.
> 
> In the autoidle case, the interface clock should be enabled by the call to 
> omap_hwmod_setup_one() earlier in the same function.
> 

You are right Paul, iclk is getting enabled in omap_hwmod_setup_one() -

static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
{
	...
		if (os->flags & OCPIF_SWSUP_IDLE) {
			/* XXX omap_iclk_deny_idle(c); */
		} else {
			/* XXX omap_iclk_allow_idle(c); */
			clk_enable(os->_clk);
		}
	...
}

Thanks,
Vaibhav

> 
> 
> - Paul
> 

