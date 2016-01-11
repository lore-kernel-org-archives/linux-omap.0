From: Pavel Machek <pavel@ucw.cz>
Subject: Re: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
Date: Mon, 11 Jan 2016 22:42:47 +0100
Message-ID: <20160111214247.GA9735@amd>
References: <20160109230709.GA30551@amd>
 <5693BB75.70409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5693BB75.70409@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, a.hajda@samsung.com
List-Id: linux-omap@vger.kernel.org

Hi!

> >Did /sys/class/power_supply/bq27200-0/capacity change meaning between
> >4.1 and 4.4?

> There was a resent overhaul of this driver and a lot of code is
> vestigial as you have seen. I've been meaning to continue
> cleaning it up, my next step would probably to bring up regmap

Ok, 1wire is probably reasonable approach. But we have an regression
between 4.1 and 4.4, and to debug it is probably by reading code.

I can't prove you caused the regression, but you basically rewrote the
driver, so it should be easier for you to spot the bug.

n900 has this variant:

      	 bq27200: bq27200@55 {
	                 compatible = "ti,bq27200";
 			 reg = <0x55>;
 	};

Will you try?

If not, tell me, and I can do it, but it will involve a lot of swaring...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
