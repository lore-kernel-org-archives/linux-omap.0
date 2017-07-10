From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.13-rc0: stopped booting on Nokia N900
Date: Mon, 10 Jul 2017 06:06:03 -0700
Message-ID: <20170710130602.GS3730@atomide.com>
References: <20170710074610.GA22846@amd> <20170710081334.GA29726@amd>
 <20170710101608.qdamqomegbjwuweh@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170710101608.qdamqomegbjwuweh@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, abcloriens@gmail.com, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170710 03:16]:
> Hi,
> 
> On Mon, Jul 10, 2017 at 10:13:35AM +0200, Pavel Machek wrote:
> > On Mon 2017-07-10 09:46:10, Pavel Machek wrote:
> > > Hi!
> > > 
> > > First, I got segfault from make:
> > > 
> > > : 0: Can't open
> > > scripts/Makefile.build:561: recipe for target
> > > 'drivers/iio/imu/st_lsm6dsx' failed
> > > make[3]: *** [drivers/iio/imu/st_lsm6dsx] Segmentation fault (core
> > > dumped)
> > > scripts/Makefile.build:561: recipe for target 'drivers/iio/imu' failed
> > > make[2]: *** [drivers/iio/imu] Error 2
> > > scripts/Makefile.build:561: recipe for target 'drivers/iio' failed
> > > make[1]: *** [drivers/iio] Error 2
> > > make[1]: *** Waiting for unfinished jobs....
> > > Makefile:1008: recipe for target 'drivers' failed
> > > make: *** [drivers] Error 2
> > > make: *** Waiting for unfinished jobs....
> > > pavel@duo:/data/l/linux-n900$ ./mkit
> > > 
> > > Then compile worked, but it failed to boot. I've now cleaned caches
> > > and am rebuilding to make sure it is not build machine that has
> > > glitches.
> > > 
> > > No such luck :-(.
> > > 
> > > I tested linux-next relatively recently, and it worked ok.
> > 
> > > af3c8d98508d37541d4bf57f13a984a7f73a328c is broken.
> > > 650fc87 worked ok.
> > 
> > 2b97620 is broken.
> > 
> > commit a51166ce71844ffbb8f78d63647b44dd69e46cf1
> >     Add linux-next specific files for 20170628
> 
> I just rebased my droid4 development branch. I do not have any
> problems with segfaulting toolchain, but boot also fails on OMAP4
> based Droid 4. The problem seems to be SPI being accessed without
> runtime PM (clocks) being enabled:

Care to check if commit c5b3955828ba ("ARM: OMAP4: Fix legacy code
clean-up regression") make that one go away? I have already sent
a pull request for that one.

Regards,

Tony
