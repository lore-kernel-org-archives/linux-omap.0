From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
Date: Tue, 15 Aug 2006 15:01:27 -0700
Message-ID: <200608151501.28384.david-b@pacbell.net>
References: <8C5B35906ACE4C48ACB3E1FAC65DB5B6231BA7@dlee08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8C5B35906ACE4C48ACB3E1FAC65DB5B6231BA7@dlee08.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Johnson, Steve-OMAP" <stevej@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 15 August 2006 10:25 am, Johnson, Steve-OMAP wrote:
> Hi Dave,
>=20
> For OMAP2 and OMAP3, the RTC is in the Power Management companion chip
> (TWL92230 and TWL4030).
>=20
> Where do you see an RTC on the web site for OMAP2420?  The only picture
> I see shows the RTC in the companion chip.

=46rom www.omap.com, click the left hand option then the JavaScript omap2420
link to reach what I suspect is the same page you list (despite linewrap
manglage) and includes this graphic:

http://focus.ti.com/graphics/wtbu/blockdiagrams/l4_omap2420.gif

which is a GIF that shows an RTC on the omap2420 chip, in the block
labeled "Timers, Interrupt Controllers, RTC".  The product overview
link on that page gives a PDF document which agrees.  (Agreed that the
2420 gif shows another RTC, on the PM chip ... but not for 2430/3430.)

=2D Dave


>=20
> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=3D
> 6123&navigationId=3D11990&contentId=3D4671
>=20
> Regards,
>=20
> Steve
> =20
>=20
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com=20
> > [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> > Behalf Of David Brownell
> > Sent: Tuesday, August 15, 2006 12:04 PM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
> >=20
> > Cleaning out my patch queue ... here's an "rtc class" driver.=20
> >  Much more suitable for upstream merging than the previous=20
> > version, even though that code has gotten much cleaner over time.
> >=20
> > Could someone confirm that this RTC can't actually do system=20
> > wakeups without external hardware support?  My documentation=20
> > isn't at all clear on that issue.  There's certainly an=20
> > external wakeup signal available, but text also says that the=20
> > alarm irq should work the normal way ... but I don't see that=20
> > happening.  It could easily be just a bug in=20
> > enable_irq_wakeup(INT_RTC_ALARM) handling, which ISTR looked=20
> > like a big NOP last I checked (for almost all IRQs).
> >=20
> > Also, someone with an OMAP2 setup should confirm that the=20
> > Kconfig is right, and this particular controller isn't=20
> > provided on OMAP2.  That certainly matches the lack of RTC in=20
> > the .../mach-omap2 directory, but the TI website says 2420=20
> > (but not {2,3}430) has an RTC.  Maybe the OMAP 2420 support=20
> > is just missing, and it's really the same RTC...
> >=20
> > - Dave
> >=20
> >=20
> > This creates a new RTC-framework driver for the RTC/calendar=20
> > module found in various OMAP chips, giving a more=20
> > correct/standard replacement for the older=20
> > drivers/char/omap-rtc.c driver.  Differences include:
> >=20
> >  - much smaller/simpler, because it reuses shared infrastructure
> >  - the RTC name will normally be "rtc0" not "rtc"
> >  - the /dev node has a different major and minor numbers
> >  - RTC_ALM_SET handled as on PCs (alarm within 24 hours)
> >  - RTC_WKALM_SET handled as on PCs (alarm within this century)
> >  - epoch not changeable (why bother)
> >  - rtc alarm may optionally be a system wakeup event (board-specific)
> > =20
> > If you use udev and statically link this, some init script=20
> > can just create a symbolic link (rtc -> rtc0) so tools like=20
> > "hwclock" will work as usual.
> > Or, updates to hwclock (and busybox) are available which=20
> > teach it to use the /dev/rtc0 path as a backup, and to=20
> > support "hwclock --file=3D/dev/rtc0".=20
> >=20
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> >=20
> > ----
> > Presumably an upstream merge should remove the devices.c=20
> > support for the older non-framework driver.
> >=20
> >  arch/arm/mach-omap1/devices.c |    2=20
> >  drivers/rtc/Kconfig           |    8=20
> >  drivers/rtc/Makefile          |    1=20
> >  drivers/rtc/rtc-omap.c        |  573=20
> > ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 583 insertions(+), 1 deletion(-)
> >=20
> > ... deletia ...
