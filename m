From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] omapfb: In omapfb_probe return -EPROBE_DEFER when
 display driver is not loaded yet
Date: Sat, 13 Jul 2013 21:56:52 +0200
Message-ID: <20130713195652.GA29130@amd.pavel.ucw.cz>
References: <1373461739-10168-1-git-send-email-pali.rohar@gmail.com>
 <20130713182733.GA25019@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130713182733.GA25019@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi!


> One thing I'd like to know: how do you configure kernel to get output
> on qemu? I was doing CONFIG_DEBUG_LL with specific uart, but that
> needed patching the kernel, you apparently have something more
> clever.

Aha, normal console=ttyO2 option. Got it now :-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
