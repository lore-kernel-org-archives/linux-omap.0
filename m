From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
	create twl6030 regulators
Date: Thu, 6 Aug 2009 12:57:26 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5D8155B@dbde02.ent.ti.com>
References: <1248842173-21821-1-git-send-email-balajitk@ti.com>
 <20090803142356.GA4265@rakim.wolfsonmicro.main>
 <20090804074544.GG24334@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8884@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301D8BD1708@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8BFF@dbde02.ent.ti.com>
 <20090804134247.GA32353@rakim.wolfsonmicro.main>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8C25@dbde02.ent.ti.com>
 <20090805213932.GD20853@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090805213932.GD20853-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "Premi, Sanjeev" <premi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org" <sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org] 
> Sent: Thursday, August 06, 2009 3:10 AM
> To: Shilimkar, Santosh
> Cc: Premi, Sanjeev; Tony Lindgren; Krishnamoorthy, Balaji T; 
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org; 
> david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org; wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org; 
> timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; 
> lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org; Nayak, Rajendra
> Subject: Re: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd 
> driver to create twl6030 regulators
> 
> On Tue, Aug 04, 2009 at 07:28:22PM +0530, Shilimkar, Santosh wrote:
> 
> > Do you have boards / use cases where more than one PM IC 
> would be used _and_ it will use the same driver ?
> 
> I don't personally but it's certainly something that I would consider
> realistic (if not mainstream).
So what you suggest here. 

Regards,
Santosh
 
 --
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
