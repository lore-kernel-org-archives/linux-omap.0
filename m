From: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RESEND] usb: otg: OMAP4: Fix the omap4430_phy_set_clk function
Date: Thu, 5 Jul 2012 20:16:54 +0300
Message-ID: <CAEa47NpZu77b8dWOPOvGjPpZyNHQGvLAmVKmF40Beox-ugA1rA@mail.gmail.com>
References: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
	<20120702081358.GF16670@arwen.pp.htv.fi>
	<CAEa47NokHNwkpoM-7q1BoxsNw7Cfr+qd7YsvJ2VKriHEU-A+og@mail.gmail.com>
	<20120703161349.GA23380@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120703161349.GA23380-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jul 3, 2012 at 7:13 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>
> Hi,
>
> On Mon, Jul 02, 2012 at 08:10:49PM +0300, Ruslan Bilovol wrote:
> > Hi,
> >
> >
> > On Mon, Jul 2, 2012 at 11:13 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Jun 12, 2012 at 08:36:21PM +0300, Ruslan Bilovol wrote:
> > > > If the clocks are enabled and we want to enable them again
> > > > omap4430_phy_set_clk disables them.
> > > >
> > > > Fix this - so now if we try to enable already enabled clocks
> > > > it works correctly.
> > > >
> > > > Signed-off-by: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
> > > > ---
> > > >  arch/arm/mach-omap2/omap_phy_internal.c |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
> > > > b/arch/arm/mach-omap2/omap_phy_internal.c
> > > > index 4c90477..0196683 100644
> > > > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > > > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > > > @@ -97,7 +97,7 @@ int omap4430_phy_set_clk(struct device *dev, int
> > > > on)
> > > >               clk_enable(clk48m);
> > > >               clk_enable(clk32k);
> > > >               state = 1;
> > > > -     } else if (state) {
> > > > +     } else if (!on && state) {
> > >
> > > why don't you let clocks be enabled twice then ? That would cut down
> > > the
> > > churn.
> >
> > Currently we have unbalanced call of this function.
> > I meet first during musb initialization - it tries to disable the phy
> > that leads to disabling already disabled clocks.
> > Next goal is to use internal clocks counter and to throw static
> > variable 'state'.
>
> don't even go that way... what you need is to fix the unbalanced calls
> instead of hacking around some generic API.

Okay Felipe, I understand your position and agree with you. However,
right now the 'hack' that I'm fixing works incorrectly.
So while we do not have replacement of the 'hack', it will be good to
have at least fixed version of this 'hack'.

--
Best regards,
Ruslan Bilovol
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
