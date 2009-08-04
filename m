From: "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
	create twl6030 regulators
Date: Tue, 4 Aug 2009 13:46:47 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940432AF38F9@dbde02.ent.ti.com>
References: <1248842173-21821-1-git-send-email-balajitk@ti.com>
 <20090803142356.GA4265@rakim.wolfsonmicro.main>
 <20090804074544.GG24334@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8884@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8884-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org" <sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> From: Shilimkar, Santosh
> 
> > From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Tony Lindgren
> >
> > * Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> [090803 17:23]:
> > > On Wed, Jul 29, 2009 at 10:06:13AM +0530, balajitk-l0cyMroinI0@public.gmane.org wrote:
> > >
> > > > -	if (twl_has_regulator()) {
> > > > +	if (twl_has_regulator() && is_class_twl4030()) {
> > >
> > > is_class_twl4030() feels like it should have better namespacing, though
> > > having the part name in there means it's not actually an issue.
> >
> > How about twl_is_4030()?
> The idea was to have a class of twl4030 IC's type IC's. There are many of them
> with just different name (TPS *)
> ... twl_class_is_4030().... What you say ?
twl_class_is_4030 should return TRUE for  twl4030 / twl5030 / tps65950 /
 tps65930 / tps65920
