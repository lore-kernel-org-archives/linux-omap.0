From: Pavel Machek <pavel@ucw.cz>
Subject: Re: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
Date: Tue, 12 Jan 2016 22:53:52 +0100
Message-ID: <20160112215352.GA5248@amd>
References: <20160109230709.GA30551@amd>
 <5693BB75.70409@ti.com>
 <20160111214247.GA9735@amd>
 <56942344.9070609@ti.com>
 <56951A2C.9010602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56951A2C.9010602@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, a.hajda@samsung.com
List-Id: linux-omap@vger.kernel.org

Hi!

> >>If not, tell me, and I can do it, but it will involve a lot of swaring...
> >
> >I'll give it a look over.
> 
> OK, I'm still looking for a test setup, but this was definitely a problem,
> could you give this a try?:

Well, search no more. I tested it and seems to work ok. There's one
more blank line in the source, so I had to apply patch by hand.

Tested-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reported-by: Pavel Machek <pavel@ucw.cz>
Cc: stable@vger.kernel.org

? :-).

And... thanks!
									Pavel

> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
> index 880233c..4fec3cf 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -470,8 +470,9 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
>  static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
>  {
>  	int soc;
> +	bool single = di->chip == BQ27000 || di->chip == BQ27010;
> -	soc = bq27xxx_read(di, BQ27XXX_REG_SOC, false);
> +	soc = bq27xxx_read(di, BQ27XXX_REG_SOC, single);
>  	if (soc < 0)
>  		dev_dbg(di->dev, "error reading State-of-Charge\n");

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
