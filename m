From: Pavel Machek <pavel@ucw.cz>
Subject: Re: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
Date: Sun, 10 Jan 2016 09:06:34 +0100
Message-ID: <20160110080621.GA3929@amd>
References: <20160109230709.GA30551@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160109230709.GA30551@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
Cc: a.hajda@samsung.com, afd@ti.com, giometti@linux.it
List-Id: linux-omap@vger.kernel.org

Hi!

> Did /sys/class/power_supply/bq27200-0/capacity change meaning between
> 4.1 and 4.4?
> 
> It used to report battery capacity remaining in percent.
> 
> Not sure what it reports now, but ain't in percent....

> The patch does not compile, but I should be sleeping, not trying to
> understand crazy code. Whoever wrote it, please fix it. Maybe you can
> just do

...and more crazy code :-(.

        cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
		if ((cache.flags & 0xff) == 0xff)
		                cache.flags = -1; /* read error */
				        /* WTF? bq27xxx returns -ERRNO
        on error, we mask some bits off it, and then make it -1... */
	

...and one crazy optimalization...

        if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
	                di->cache = cache;

...are we playing obfuscated C code contest, yet?

        case POWER_SUPPLY_PROP_PRESENT:
	                val->intval = di->cache.flags < 0 ? 0 : 1;

...to decidegree C?
                if (ret == 0)
		   	        pval->intval -= 2731; /* convert decidegree k to c */

as read takes enum, make it enum like this?
static inline int bq27xxx_read(struct bq27xxx_device_info *di, enum bq27xxx_reg_index reg_index,
		                         bool single)
					 

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
