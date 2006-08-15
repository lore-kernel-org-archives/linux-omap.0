From: "Johnson, Steve-OMAP" <stevej@ti.com>
Subject: RE: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
Date: Tue, 15 Aug 2006 17:03:02 -0500
Message-ID: <8C5B35906ACE4C48ACB3E1FAC65DB5B6231F5B@dlee08.ent.ti.com>
References: <200608151501.28384.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200608151501.28384.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David,

Thanks.  I'll let marketing know and ask them to fix the graphic.

Regards,

Steve
=20

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]=20
> Sent: Tuesday, August 15, 2006 5:01 PM
> To: Johnson, Steve-OMAP
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc=20
> framework driver
>=20
> On Tuesday 15 August 2006 10:25 am, Johnson, Steve-OMAP wrote:
> > Hi Dave,
> >=20
> > For OMAP2 and OMAP3, the RTC is in the Power Management=20
> companion chip=20
> > (TWL92230 and TWL4030).
> >=20
> > Where do you see an RTC on the web site for OMAP2420?  The only=20
> > picture I see shows the RTC in the companion chip.
>=20
> From www.omap.com, click the left hand option then the=20
> JavaScript omap2420 link to reach what I suspect is the same=20
> page you list (despite linewrap
> manglage) and includes this graphic:
>=20
> http://focus.ti.com/graphics/wtbu/blockdiagrams/l4_omap2420.gif
>=20
> which is a GIF that shows an RTC on the omap2420 chip, in the=20
> block labeled "Timers, Interrupt Controllers, RTC".  The=20
> product overview link on that page gives a PDF document which=20
> agrees.  (Agreed that the 2420 gif shows another RTC, on the=20
> PM chip ... but not for 2430/3430.)
>=20
> - Dave
>=20
>=20
> >=20
> >=20
> http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateI
> > d=3D
> > 6123&navigationId=3D11990&contentId=3D4671
> >=20
> > Regards,
> >=20
> > Steve
> > =20
> >=20
> > > -----Original Message-----
> > > From: linux-omap-open-source-bounces@linux.omap.com
> > > [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of=20
> > > David Brownell
> > > Sent: Tuesday, August 15, 2006 12:04 PM
> > > To: linux-omap-open-source@linux.omap.com
> > > Subject: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc=20
> framework driver
> > >=20
> > > Cleaning out my patch queue ... here's an "rtc class" driver.=20
> > >  Much more suitable for upstream merging than the=20
> previous version,=20
> > > even though that code has gotten much cleaner over time.
> > >=20
> > > Could someone confirm that this RTC can't actually do=20
> system wakeups=20
> > > without external hardware support?  My documentation isn't at all=20
> > > clear on that issue.  There's certainly an external wakeup signal=20
> > > available, but text also says that the alarm irq should work the=20
> > > normal way ... but I don't see that happening.  It could=20
> easily be=20
> > > just a bug in
> > > enable_irq_wakeup(INT_RTC_ALARM) handling, which ISTR=20
> looked like a=20
> > > big NOP last I checked (for almost all IRQs).
> > >=20
> > > Also, someone with an OMAP2 setup should confirm that the=20
> Kconfig is=20
> > > right, and this particular controller isn't provided on=20
> OMAP2.  That=20
> > > certainly matches the lack of RTC in the .../mach-omap2=20
> directory,=20
> > > but the TI website says 2420 (but not {2,3}430) has an=20
> RTC.  Maybe=20
> > > the OMAP 2420 support is just missing, and it's really the same=20
> > > RTC...
> > >=20
> > > - Dave
> > >=20
> > >=20
> > > This creates a new RTC-framework driver for the=20
> RTC/calendar module=20
> > > found in various OMAP chips, giving a more correct/standard=20
> > > replacement for the older drivers/char/omap-rtc.c driver. =20
> > > Differences include:
> > >=20
> > >  - much smaller/simpler, because it reuses shared infrastructure
> > >  - the RTC name will normally be "rtc0" not "rtc"
> > >  - the /dev node has a different major and minor numbers
> > >  - RTC_ALM_SET handled as on PCs (alarm within 24 hours)
> > >  - RTC_WKALM_SET handled as on PCs (alarm within this century)
> > >  - epoch not changeable (why bother)
> > >  - rtc alarm may optionally be a system wakeup event=20
> > > (board-specific)
> > > =20
> > > If you use udev and statically link this, some init=20
> script can just=20
> > > create a symbolic link (rtc -> rtc0) so tools like "hwclock" will=20
> > > work as usual.
> > > Or, updates to hwclock (and busybox) are available which=20
> teach it to=20
> > > use the /dev/rtc0 path as a backup, and to support "hwclock=20
> > > --file=3D/dev/rtc0".
> > >=20
> > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > >=20
> > > ----
> > > Presumably an upstream merge should remove the devices.c=20
> support for=20
> > > the older non-framework driver.
> > >=20
> > >  arch/arm/mach-omap1/devices.c |    2=20
> > >  drivers/rtc/Kconfig           |    8=20
> > >  drivers/rtc/Makefile          |    1=20
> > >  drivers/rtc/rtc-omap.c        |  573=20
> > > ++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 583 insertions(+), 1 deletion(-)
> > >=20
> > > ... deletia ...
>=20
>=20
