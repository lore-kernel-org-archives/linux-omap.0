From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] driver: misc: bmp085: remove "of_match_table" property.
Date: Tue, 7 Aug 2012 11:52:26 +0100
Message-ID: <20120807105225.GT16861@opensource.wolfsonmicro.com>
References: <1344245324-16704-1-git-send-email-sourav.poddar@ti.com>
 <20120806093033.GH17551@arwen.pp.htv.fi>
 <20120806154214.GC29272@sirena.org.uk>
 <20120807054342.GF8468@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120807054342.GF8468@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, arnd@arndb.de, gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 07, 2012 at 08:43:44AM +0300, Felipe Balbi wrote:
> On Mon, Aug 06, 2012 at 04:42:14PM +0100, Mark Brown wrote:

> > It's good practice to have an explict compatible string even if the
> > default happens to work in order to avoid any name clashes.

> of_i2c.c makes no use whatsoever of the compatible string. See that it
> will build an i2c_boardinfo and register a new device. That compatible

If that's all that's done it seems like a bug frankly, certainly based
on previous discussions it ought to be.  There are collisions out there,
they've just happened to not bite us yet

> string is just churn and has no use at all.

This is device tree we're talking about, there's a lot churn anyway.
