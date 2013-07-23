From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 23 Jul 2013 14:23:34 -0700
Message-ID: <20130723212334.GA21945@kroah.com>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <1731726.KENstTPhkb@flatron>
 <20130723205007.GA27166@kroah.com>
 <1769609.rbAYfG9ir3@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1769609.rbAYfG9ir3@flatron>
Sender: linux-doc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kishon Vijay Abraham I <kishon@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, kyungmin.park@samsung.com, balbi@ti.com, jg1.han@samsung.com, s.nawrocki@samsung.com, kgene.kim@samsung.com, grant.likely@linaro.org, tony@atomide.com, arnd@arndb.de, swarren@nvidia.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-media@vger.kernel.org, linux-fbdev@vger.kernel.org, akpm@linux-foundation.org, balajitk@ti.com, george.cherian@ti.com, nsekhar@ti.com, olof@lixom.net, Stephen Warren <swarren@wwwdotor>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 23, 2013 at 11:05:48PM +0200, Tomasz Figa wrote:
> > That's not so bad, as long as you let the phy core use whatever name it
> > wants for the device when it registers it with sysfs.
> 
> Yes, in regulator core consumer names are completely separated from this. 
> Regulator core simply assigns a sequential integer ID to each regulator 
> and registers /sys/class/regulator/regulator.ID for each regulator.

Yes, that's fine.

> > Use the name you
> > are requesting as a "tag" or some such "hint" as to what the phy can be
> > looked up by.
> > 
> > Good luck handling duplicate "tags" :)
> 
> The tag alone is not a key. Lookup key consists of two components, 
> consumer device name and consumer tag. What kind of duplicate tags can be 
> a problem here?

Ok, I didn't realize it looked at both parts, that makes sense, thanks.

greg k-h
