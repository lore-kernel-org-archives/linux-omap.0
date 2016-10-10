From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: camera on n900, v4.8
Date: Mon, 10 Oct 2016 10:48:59 +0200
Message-ID: <20161010084859.GD4467@pali>
References: <20161005190340.GA25755@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161005190340.GA25755@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 05 October 2016 21:03:41 Pavel Machek wrote:
> Hi!
> 
> Camera has some non-trivial dependencies on N900; it seems to rely on
> gpio-switch.c, for example. I'll try to strip the diff further, but in
> the meantime, here's the version I'm working with.
> 
> 									Pavel
> 
> 

With "Camera" do you mean some Maemo userspace application? Because I
think that nobody else could depends on gpio-switch kernel driver.

Anyway, it should be easy to rewrite such gpio-switch application to use
either input kernel events (from /dev/input/something) or directly check
gpio state via /sys/class/gpio/.

IIRC Maemo's Camera needed gpio-switch for testing if back camera cover
is open or closed and for checking when camera push button pressed and
released.

-- 
Pali Rohár
pali.rohar@gmail.com
