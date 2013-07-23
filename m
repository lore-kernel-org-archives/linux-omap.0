From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 23 Jul 2013 11:01:10 -0700
Message-ID: <20130723180110.GA8688@kroah.com>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <51EE9EC0.6060905@ti.com> <20130723161846.GD2486@kroah.com>
 <1446965.6APW5ZgLBW@amdc1227> <20130723173710.GB28284@kroah.com>
 <20130723174456.GM9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130723174456.GM9858@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-doc@vger.kernel.org, tony@atomide.com, Tomasz Figa <t.figa@samsung.com>, nsekhar@ti.com, Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, s.nawrocki@samsung.com, kgene.kim@samsung.com, swarren@nvidia.com, jg1.han@samsung.com, Kishon Vijay Abraham I <kishon@ti.com>, Alan Stern <stern@rowland.harvard.edu>, grant.likely@linaro.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, george.cherian@ti.com, arnd@arndb.de, Stephen Warren <swarren@wwwdotorg.org>, b.zolnierkie@samsung.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 23, 2013 at 06:44:56PM +0100, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 10:37:11AM -0700, Greg KH wrote:
> > On Tue, Jul 23, 2013 at 06:50:29PM +0200, Tomasz Figa wrote:
> 
> > > I fully agree that a simple, single string will not scale even in some, not 
> > > so uncommon cases, but there is already a lot of existing lookup solutions 
> > > over the kernel and so there is no point in introducing another one.
> 
> > I'm trying to get _rid_ of lookup "solutions" and just use a real
> > pointer, as you should.  I'll go tackle those other ones after this one
> > is taken care of, to show how the others should be handled as well.
> 
> What are the problems you are seeing with doing things with lookups?

You don't "know" the id of the device you are looking up, due to
multiple devices being in the system (dynamic ids, look back earlier in
this thread for details about that.)

> Having to write platform data for everything gets old fast and the code
> duplication is pretty tedious...

Adding a single pointer is "tedious"?  Where is the "name" that you are
going to lookup going to come from?  That code doesn't write itself...

thanks,

greg k-h
