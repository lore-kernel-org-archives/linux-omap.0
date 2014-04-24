From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: regressions in linux-next?
Date: Thu, 24 Apr 2014 22:59:17 +0300
Message-ID: <20140424195917.GF575@drone.musicnaut.iki.fi>
References: <53566C20.6000208@ti.com>
 <53566EBA.808@ti.com>
 <CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
 <CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
 <7hr44mpxk6.fsf@paris.lan>
 <CAGo_u6r79StfHwf8t8OB5vyhByfusi3EF=PZA186piiAci_wjw@mail.gmail.com>
 <20140424154031.GA22987@atomide.com>
 <535931F3.10805@ti.com>
 <20140424161711.GC22987@atomide.com>
 <535944F0.6030809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:33141 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbaDXUDh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 16:03:37 -0400
Content-Disposition: inline
In-Reply-To: <535944F0.6030809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hi,

On Thu, Apr 24, 2014 at 12:08:00PM -0500, Nishanth Menon wrote:
> The trigger was that even at TI, OMAP1s are hard to get to, in fact, I
> do not of one person in TI who seems to have a functioning OMAP1
> platform - and context of my question came from that background and
> noticing others going through similar pain as well. Will continue to
> look around.

There has been commercially available consumer products based on OMAP1
which can be still found places like ebay. E.g Nokia 770 runs mainline
kernel out of the box. (Also Amstrad E3 works fine but you need
to find an unused one because they locked the bootloader in a later
firmware upgrade.) Never tested myself, but I think QEMU might even
emulate some OMAP1 board.

A.
