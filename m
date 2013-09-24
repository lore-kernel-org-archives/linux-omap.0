From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
Date: Tue, 24 Sep 2013 02:05:50 +0200
Message-ID: <20130924000550.GC30967@amd.pavel.ucw.cz>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309232116.19161@pali>
 <20130923200008.GA21808@earth.universe>
 <201309232206.47391@pali>
 <20130923204714.GB22995@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130923204714.GB22995@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Hi!

> > No, isp1704 is power supply driver and export data via power 
> > supply (sysfs) interface. It is not regulator but charger driver.
> 
> well it does not charge the battery directly, but just provides a
> power line with 5 Volt and a specified amount of current to the
> system, doesn't it?

I don't want to talk about isp1704, but...

LiION charger is just something that provides 4.2V power line with
C/10 current limitation...

(IOW line between regulators and chargers is very very thin, if it
even exists).

									Pavel

            (who did use laboratory power supply as emergency battery charger)
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
