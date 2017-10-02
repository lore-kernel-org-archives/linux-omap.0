From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: i2c-omap.c vs. qemu: too much work in one irq (and broken boot)
Date: Mon, 2 Oct 2017 09:23:31 +0200
Message-ID: <20171002072331.GB25930@pali>
References: <20171001204215.GA9928@amd>
 <20171001221935.GA29628@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171001221935.GA29628@amd>
Sender: linux-i2c-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, balbi@ti.com, jlu@pengutronix.de, bigeasy@linutronix.de
List-Id: linux-omap@vger.kernel.org

On Monday 02 October 2017 00:19:35 Pavel Machek wrote:
> Hi!
> 
> > I'm trying to get qemu emulation of Nokia N900 to work, but
> > unfortunately i2c-omap.c breaks boot in the emulator (real hardware
> > works ok).
> 
> I started bisection. v4.6 works, v4.7 is broken. (It still may be
> config difference or something).
> 
> This looked suspect, so I tried reverting it, but it did not help. And
> it is only significant change in i2c-omap.c. So... this may be a lot
> of fun.
> 
> commit 126a66caec4a00b8d66dbc3174b0efa905cf68c3
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Mon Apr 4 16:55:23 2016 +0300
> 
> Unfortunately, mmc is broken in v4.6, so its useless for
> emulation... [ 3.236724] mmc1: error -22 whilst initialising SDIO card

Hi! You can apply special patch to make mmc work in both qemu and real
N900 device for previous kernel versions...

https://github.com/pali/linux-n900/commit/eb080ecdcfc5868d8e36d0f5f42d9cb7f13b4db9

-- 
Pali Rohár
pali.rohar@gmail.com
