From: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] omap: beagle: add support for wl1271 on the board
 file
Date: Thu, 23 Sep 2010 14:56:38 +0300
Message-ID: <1285242998.3231.57.camel@chilepepper>
References: <1285230003-5065-1-git-send-email-luciano.coelho@nokia.com>
	 <AANLkTinLjQbvbTj3LTnw+54S-ojWzojqgyd=-3F783We@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinLjQbvbTj3LTnw+54S-ojWzojqgyd=-3F783We-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-09-23 at 12:30 +0200, ext Grazvydas Ignotas wrote:
> On Thu, Sep 23, 2010 at 11:20 AM, Luciano Coelho
> <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> > Add board configuration for the wl1271 daughter board.  This patch is based
> > on Ohad Ben-Cohen's patches for Zoom boards.
> 
> Hm can that daughter board be detected? With your patch all beagle
> users will get GPIO139 toggled, and if someone has that wired to
> chainsaw switch somebody might get hurt.

Very good point.  This was just me, working on my chainsaw-free bubble,
who didn't realize the danger of the code! :)

But actually I have no idea how to detect what kind of daughter board is
connected.  Hopefully there is generic way of doing this in beagle
boards.  Otherwise the only way I can think of is to add a Kconfig
option for this... :/


> > Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > ---
> > There was a useless variable defined in omap3_beagle_init() that was causing a
> > warning.  I have removed it in v2.
> >
> >  arch/arm/mach-omap2/board-omap3beagle.c |   69 +++++++++++++++++++++++++++++++
> >  drivers/net/wireless/wl12xx/wl1271.h    |    2 +-
> >  2 files changed, 70 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> > index 87969c7..755df29 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> 
> <snip>
> 
> > +static struct regulator_consumer_supply beagle_vmmc2_supply = {
> > +       .supply         = "vmmc",
> > +       .dev_name       = "mmci-omap-hs.1",
> > +};
> > +
> > +
> 
> single newline is enough.

I'll fix it.


> >  static struct regulator_consumer_supply beagle_vsim_supply = {
> >        .supply                 = "vmmc_aux",
> >  };
> >
> > +
> 
> here too.

Here too.


> > +static struct regulator_init_data beagle_vmmc2 = {
> > +       .constraints = {
> > +               .valid_ops_mask = REGULATOR_CHANGE_STATUS,
> > +       },
> > +       .num_consumer_supplies = 1,
> > +       .consumer_supplies = &beagle_vmmc2_supply,
> > +};
> > +
> > +static struct fixed_voltage_config beagle_vwlan = {
> > +       .supply_name = "vwl1271",
> > +       .microvolts = 1800000,  /* 1.8V */
> > +       .gpio = OMAP_BEAGLE_WLAN_EN_GPIO,
> > +       .startup_delay = 70000, /* 70ms */
> > +       .enable_high = 1,
> > +       .enabled_at_boot = 0,
> > +       .init_data = &beagle_vmmc2,
> > +};
> 
> We tabify all structures in board files, take a look at other structures.

Sure, I'll do that.  I just copied this from a previous patch to which
someone commented the same thing.  I just forgot to fix it before
submitting, because I got so excited when it worked :)


> > diff --git a/drivers/net/wireless/wl12xx/wl1271.h b/drivers/net/wireless/wl12xx/wl1271.h
> > index 4134f44..8bb028e 100644
> > --- a/drivers/net/wireless/wl12xx/wl1271.h
> > +++ b/drivers/net/wireless/wl12xx/wl1271.h
> > @@ -60,7 +60,7 @@ enum {
> >        DEBUG_ALL       = ~0,
> >  };
> >
> > -#define DEBUG_LEVEL (DEBUG_NONE)
> > +#define DEBUG_LEVEL (DEBUG_MAC80211 | DEBUG_CMD | DEBUG_ACX | DEBUG_BOOT)
> 
> I guess you didn't want that?

No, I certainly didn't.  I have already sent a v3 without that.


-- 
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
