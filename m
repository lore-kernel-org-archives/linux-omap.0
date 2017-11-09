From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add support for bq27521 battery monitor
Date: Thu, 9 Nov 2017 22:52:36 +0100
Message-ID: <20171109215236.ntmrgoobrs5k7ufh@pali>
References: <20171109210615.GA27638@amd>
 <20171109212945.2sgu56zkse7nbzo3@pali>
 <20171109214540.GB23376@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171109214540.GB23376@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, afd-l0cyMroinI0@public.gmane.org, kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 09 November 2017 22:45:40 Pavel Machek wrote:
> On Thu 2017-11-09 22:29:45, Pali Rohár wrote:
> > On Thursday 09 November 2017 22:06:15 Pavel Machek wrote:
> > > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> > > index ed44439..ee2851a 100644
> > > --- a/drivers/power/supply/bq27xxx_battery.c
> > > +++ b/drivers/power/supply/bq27xxx_battery.c
> > > @@ -381,6 +381,30 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
> > >  		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
> > >  		BQ27XXX_DM_REG_ROWS,
> > >  	},
> > > +	[BQ27521] = {				/* FIXME */
> > > +		[BQ27XXX_REG_CTRL] = 0x02,
> > > +		[BQ27XXX_REG_TEMP] = 0x0a,
> > > +		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_VOLT] = 0x0c,
> > > +		[BQ27XXX_REG_AI] = 0x0e,
> > > +		[BQ27XXX_REG_FLAGS] = 0x08,
> > > +		[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_FCC] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_SOC] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_DM_CTRL] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_DM_CLASS] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
> > > +		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
> > > +	},
> > >  	[BQ27530] = {
> > >  		[BQ27XXX_REG_CTRL] = 0x00,
> > >  		[BQ27XXX_REG_TEMP] = 0x06,
> > 
> > Hi! IIRC those registers are valid only for sn27521 chip in revision 14
> > (or new). For older revision is used different register map. And
> > detection of chip revision is somehow possible via some registers.
> 
> Yes, I know.. I even had this, but as I can't test it, and early N950
> samples should be very very rare, I'd prefer the patch as is.
> 
> @@ -1905,6 +1940,23 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>  
>  	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
>  
> +	if (di->chip == BQ27521) {
> +		int val;
> +		val = di->bus.read(di, 0x32, false);
> +		if (val == 0x2100) {
> +			printk("rev. 13 chip detected; add support\n");
> +			/* https://elinux.org/N950 has details */
> +			return PTR_ERR(ENODEV);
> +		}
> +
> +		val = di->bus.read(di, 0x34, false);
> +		if ((val & 0xff00) != 0x2100) {
> +			printk("rev. 14 chip not detected?!\n");
> +			return PTR_ERR(EINVAL);
> +		}
> +		printk("verified chip rev. 14\n");
> +	}
> +
>  	bq27xxx_battery_settings(di);
>  	bq27xxx_battery_update(di);

This change could be useful, specially if somebody got device with
sn27521 chip which is not in revision 14 (no idea if in world are those
chips used) -- at least would get message that current driver does not
support it.

-- 
Pali Rohár
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
