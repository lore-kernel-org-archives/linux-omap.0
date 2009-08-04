From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
 create twl6030 regulators
Date: Tue, 4 Aug 2009 19:28:22 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8C25@dbde02.ent.ti.com>
References: <1248842173-21821-1-git-send-email-balajitk@ti.com>
 <20090803142356.GA4265@rakim.wolfsonmicro.main>
 <20090804074544.GG24334@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8884@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D8BD1708@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8BFF@dbde02.ent.ti.com>
 <20090804134247.GA32353@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090804134247.GA32353-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "Premi, Sanjeev" <premi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org" <sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org]
> Sent: Tuesday, August 04, 2009 7:13 PM
> To: Shilimkar, Santosh
> Cc: Premi, Sanjeev; Tony Lindgren; Krishnamoorthy, Balaji T; linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org; david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org;
> linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org; wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org;
> timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org; Nayak,
> Rajendra
> Subject: Re: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
> create twl6030 regulators
> 
> On Tue, Aug 04, 2009 at 06:56:13PM +0530, Shilimkar, Santosh wrote:
> 
> > > > > is_class_twl4030() feels like it should have better namespacing,
> > > though
> > > > > having the part name in there means it's not actually an issue.
> 
> > > > How about twl_is_4030()?
> 
> > > The idea was to have a class of twl4030 IC's type IC's. There are many
> of
> > > them with just different name (TPS *)
> > > ... twl_class_is_4030().... What you say ?
> 
> > > Can I suggest: pmic_class_is_xxx() ?
> 
> > Even better
> 
> That feels like it's got a more global namespace than it ought - this is
> really only for this class of chip.  It's also got a bit of an
> assumption that there's only one PMIC in the system which isn't always
> the case.
Do you have boards / use cases where more than one PM IC would be used _and_ it will use the same driver ?


Regards,
Santosh
