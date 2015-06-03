From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/12] ARM: OMAP2+: Fix scrm compatible for dm814x
Date: Wed, 3 Jun 2015 12:38:07 -0700
Message-ID: <20150603193806.GW30984@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
 <1433348601-8966-3-git-send-email-tony@atomide.com>
 <556F50B8.6000903@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55721 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbbFCTiJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 15:38:09 -0400
Content-Disposition: inline
In-Reply-To: <556F50B8.6000903@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>

* Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [150603 12:10]:
> Hello.
> 
> On 06/03/2015 07:23 PM, Tony Lindgren wrote:
> 
> >Fix scrm compatible for dm814x.
> 
>    So, scrm...
> 
> >Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> >Signed-off-by: Tony Lindgren <tony@atomide.com>
> >---
> >  arch/arm/mach-omap2/control.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> >index af95a62..364925c 100644
> >--- a/arch/arm/mach-omap2/control.c
> >+++ b/arch/arm/mach-omap2/control.c
> >@@ -649,6 +649,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
> >  	{ .compatible = "ti,am4-scm", .data = &ctrl_data },
> >  	{ .compatible = "ti,omap2-scm", .data = &omap2_ctrl_data },
> >  	{ .compatible = "ti,omap3-scm", .data = &omap2_ctrl_data },
> >+	{ .compatible = "ti,dm814-scm", .data = &ctrl_data },
> 
>    ... or scm? :-)
> 
> >  	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
> >  	{ .compatible = "ti,omap4-scm-core", .data = &ctrl_data },
> >  	{ .compatible = "ti,omap5-scm-core", .data = &ctrl_data },

Thanks, yeah we should standardize on scm.

Tony
