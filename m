From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH RESEND] usb: otg: OMAP4: Fix the omap4430_phy_set_clk function
Date: Mon, 2 Jul 2012 20:10:49 +0300
Message-ID: <CAEa47NokHNwkpoM-7q1BoxsNw7Cfr+qd7YsvJ2VKriHEU-A+og@mail.gmail.com>
References: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
	<20120702081358.GF16670@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37373 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445Ab2GBRKv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 13:10:51 -0400
Received: by vbbez10 with SMTP id ez10so5041032vbb.3
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 10:10:50 -0700 (PDT)
In-Reply-To: <20120702081358.GF16670@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi,


On Mon, Jul 2, 2012 at 11:13 AM, Felipe Balbi <balbi@ti.com> wrote:
>
> Hi,
>
> On Tue, Jun 12, 2012 at 08:36:21PM +0300, Ruslan Bilovol wrote:
> > If the clocks are enabled and we want to enable them again
> > omap4430_phy_set_clk disables them.
> >
> > Fix this - so now if we try to enable already enabled clocks
> > it works correctly.
> >
> > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_phy_internal.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
> > b/arch/arm/mach-omap2/omap_phy_internal.c
> > index 4c90477..0196683 100644
> > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > @@ -97,7 +97,7 @@ int omap4430_phy_set_clk(struct device *dev, int on)
> >               clk_enable(clk48m);
> >               clk_enable(clk32k);
> >               state = 1;
> > -     } else if (state) {
> > +     } else if (!on && state) {
>
> why don't you let clocks be enabled twice then ? That would cut down the
> churn.

Currently we have unbalanced call of this function.
I meet first during musb initialization - it tries to disable the phy
that leads to disabling already disabled clocks.
Next goal is to use internal clocks counter and to throw static
variable 'state'.
But since this is not investigated fully and work is not finished -
simple and obvious fix is pushed.

--
Best regards,
Ruslan Bilovol
