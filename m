From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in 4.2-rc0: repeating oopses
Date: Wed, 1 Jul 2015 23:16:21 -0700
Message-ID: <20150702061620.GY4156@atomide.com>
References: <20150416093234.GA17423@amd>
 <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd>
 <20150630095310.GF27720@pali>
 <20150701065932.GS4156@atomide.com>
 <20150701072255.GA17577@pali>
 <20150701095954.GD7969@amd>
 <20150701103421.GV4156@atomide.com>
 <20150701130903.GG7969@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150701130903.GG7969@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [150701 06:11]:
> On Wed 2015-07-01 03:34:22, Tony Lindgren wrote:
> > 
> > Works for me after enabling the idle timeouts with the following
> > script and blanking the screen and disconnecting USB:
> 
> Um. I'm forcing suspend with "echo mem > /sys/power/state" . (It
> worked in 4.1). That should just make it sleep, no autosuspend-related
> trickery... (But yes, I guess I should set up the leds and try
> autosuspend, too.)

That too works just fine for me with omap2plus_defconfig after
echo enabled > /sys/class/tty/ttyO2/power/wakeup as I have n900
in my test rack.

You probably have some additional drivers enabled?

Regards,

Tony
