From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH RESEND] usb: otg: OMAP4: Fix the omap4430_phy_set_clk function
Date: Sat, 30 Jun 2012 00:50:29 +0300
Message-ID: <CAEa47NrLyKS-HDgruoSWAh-ZT_jtZs3Bd3C8xNtiqfOH3DejLQ@mail.gmail.com>
References: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
	<20120620133115.GL12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52336 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750840Ab2F2Vud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 17:50:33 -0400
Received: by vbkv13 with SMTP id v13so3135148vbk.0
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 14:50:29 -0700 (PDT)
In-Reply-To: <20120620133115.GL12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com

On Wed, Jun 20, 2012 at 4:31 PM, Tony Lindgren <tony@atomide.com> wrote=
:
>
> * Ruslan Bilovol <ruslan.bilovol@ti.com> [120612 10:42]:
> > If the clocks are enabled and we want to enable them again
> > omap4430_phy_set_clk disables them.
> >
> > Fix this - so now if we try to enable already enabled clocks
> > it works correctly.
>
> Sounds like Felipe is on vacation. Trying to figure out if this
> is something for the fixes branch:
>
> What happens if this not fixed, do you get some error?

The function is designed for simple clocks on-off:
if zero "on" parameter is passed - switch the clocks off,
if non-zero "on" parameter passed - switch the clocks on.

But due to error in implementation, it works wrong if called twice or m=
ore
times with non-zero "on" parameter.

=46or example, assuming that clocks are disabled:
    omap4430_phy_set_clk(dev, 1);   <=3D=3D=3D enables clocks
    omap4430_phy_set_clk(dev, 1);   <=3D=3D=3D suddenly disables clocks=
,
when we expect enabling.
    omap4430_phy_set_clk(dev, 1);   <=3D=3D=3D enables clocks again

It seems impact of this wrong behavior is not observed on current code
base, but we see
crashes caused by access to non-clocked registers when heavy use this f=
unction
in the charger detection or after implementing otg EYE improvement.

> Was this caused by some recent commit?

No, we have this wrong behavior since the omap_phy_internal.c file
creation (c33fad0c37)

--
Best regards,
Ruslan Bilovol


>
> > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/omap_phy_internal.c | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
> > b/arch/arm/mach-omap2/omap_phy_internal.c
> > index 4c90477..0196683 100644
> > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > @@ -97,7 +97,7 @@ int omap4430_phy_set_clk(struct device *dev, int =
on)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(clk48m);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(clk32k);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D 1;
> > - =A0 =A0 } else if (state) {
> > + =A0 =A0 } else if (!on && state) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable the phy clocks */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(phyclk);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(clk48m);
> > --
> > 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
