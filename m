From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: Status of led-backlight driver
Date: Mon, 9 Sep 2019 12:14:10 +0100
Message-ID: <20190909111410.dwqvg6b4lgxymn2o@holly.lan>
References: <20190907100726.GA12763@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190907100726.GA12763@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, tomi.valkeinen@ti.com, jjhiblot@ti.com
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 07, 2019 at 12:07:27PM +0200, Pavel Machek wrote:
> Hi!
> 
> I don't see the LED-backlight driver in -next. Could it be pushed? It
> is one of last pieces to get working backlight on Motorola Droid 4...

Sorry, I dropped the ball on this and was therefore rather late
reviewing this patchset.

Assuming I have read the code correctly I think there are some
problems with the max_brightness handling in the backlight code.


Daniel.
