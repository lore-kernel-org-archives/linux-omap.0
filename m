From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Fri, 14 Aug 2015 22:46:49 +0200
Message-ID: <20150814204649.GA7628@Nokia-N900>
References: <201507251228.27128@pali>
 <201508011218.45076@pali>
 <55BFACE4.1010100@bitmer.com>
 <201508032017.45654@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201508032017.45654@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali Roh?r <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Lars-Peter Clausen <lars@metafoo.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> Maybe some power management problem? Something is not always initialized 
> correctly?
> 
> I remember that there is some problem (maybe in NoLo - Nokia bootloader) 
> that sometimes chainloaded U-Boot (booted via NoLo) is not able to 
> initialize mmc chip (all read operation fails). In U-Boot I added some 
> code to enable some parts in twl4030 regulator and after that mmc is 
> working always...

Could I get some details? Thay code should be moved to kernel,
I'd really like mmc to work, no matter how machine was booted.

Best regards,

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
