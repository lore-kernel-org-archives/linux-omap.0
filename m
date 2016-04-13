From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Wed, 13 Apr 2016 08:15:27 -0700
Message-ID: <20160413151526.GO5995@atomide.com>
References: <20160407213229.GO16484@atomide.com>
 <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com>
 <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com>
 <570DDE9C.10504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570DDE9C.10504@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [160412 22:53]:
> 
> On 12/04/16 19:30, Tony Lindgren wrote:
> 
> > With LCD enabled, both LEDs are on contantly. I think we should
> > be able to hit retention in that state, at least n950 is doing it
> > with the Nokia kernel.
> 
> N900's display needs constant updating, where N950's display has
> internal framebuffer, allowing OMAP to be off.

OK, so the results are as expected then.

Regards,

Tony
