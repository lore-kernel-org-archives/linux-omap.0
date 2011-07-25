From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2 V2] OMAP3+: PM: SR: add suspend/resume handlers
Date: Mon, 25 Jul 2011 20:13:17 +0300
Message-ID: <20110725171317.GH18062@legolas.emea.dhcp.ti.com>
References: <1311526357-7578-1-git-send-email-nm@ti.com>
 <20110725084238.GC18062@legolas.emea.dhcp.ti.com>
 <CAOMWX4dC60SuF9=KDCrQo7zD5_PhTJhwuyqRkqj0ag8FHDQaxw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEpdcbHbO3kvNF3k"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:49780 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751223Ab1GYRNU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jul 2011 13:13:20 -0400
Received: by mail-ey0-f182.google.com with SMTP id 7so5233361eyg.41
        for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 10:13:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMWX4dC60SuF9=KDCrQo7zD5_PhTJhwuyqRkqj0ag8FHDQaxw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: balbi@ti.com, Kevin <khilman@ti.com>, Colin <ccross@google.com>, l-a <linux-arm-kernel@lists.infradead.org>, l-o <linux-omap@vger.kernel.org>


--PEpdcbHbO3kvNF3k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 25, 2011 at 11:59:10AM -0500, Menon, Nishanth wrote:
> > On Sun, Jul 24, 2011 at 11:52:37AM -0500, Nishanth Menon wrote:
> >> SmartReflex should be disabled while entering low power mode due to
> >> the following reasons:
> >> a) SmartReflex values are not defined for retention voltage.
> >> b) With SmartReflex enabled, if the CPU enters low power state, FSM
> >> =A0 =A0will try to bump the voltage to current OPP's voltage for which
> >> =A0 =A0it has entered low power state, causing power loss and potential
> >> =A0 =A0unknown states for the SoC.
> >> Since we are sure to attempt entering the lowest possible power state
> >> during suspend operation, SmartReflex needs to be disabled for the
> >> voltage domains in suspend path before achieving auto retention voltage
> >> on the device.
> >>
> >> Traditionally, this has been done with interrupts disabled as part of
> >> the common code which handles the idle sequence. Instead, by using the
> >> fact that we have to disable SmartReflex for sure during suspend
> >> operations, we can opportunistically disable SmartReflex in device
> >> standard pm ops, instead of disabling it as part of the code which
> >> executes with interrupts disabled and slave CPU{s} shutdown. This
> >> allows the system to do other parallel activities(such as suspending
> >> other devices in the system using slave CPU{s}) and save the time
> >> required to achieve suspend and resume from suspended state as a
> >> sequential activity.
> >>
> >> However, by being opportunistic as described above, we also increase
> >> the likelihood of SmartReflex library access functions being invoked in
> >> parallel contexts *after* SmartReflex driver's suspend handler (during
> >> suspend operation) or *before* resume handler (during resume operation)
> >> have been invoked (Example: DVFS for dependent devices, cpufreq for
> >> MPU etc.). We prevent this by using a flag to reject the callers in
> >> the duration where SmartReflex has been disabled.
> >
> > while at that, SR's IRQ is never freed on exit path, could fix it while
> > you're already there ?
>=20
> This is not really related to this patch is it? IMHO IRQ handling is

I didn't say to put it on the same patch ;-) I meant that while at that,
you could add that simple fix before this patch ;-)

> broken badly. Current support is for SmartReflex class3 - which does
> not use the IRQ, Class2 and Class1.5 use it, but the current code
> requires major fixes which I dont intend to support in this series.

And that's exactly what I mean. IMHO it's far better to fix the mess
before adding more stuff, otherwise it just becomes an even bigger mess,
even more difficult to fix in the long run. We've seen that with GPIO
and sDMA drivers _at_least_ ;-(

> >> @@ -998,10 +1020,75 @@ static int __devexit omap_sr_remove(struct plat=
form_device *pdev)
> >> =A0 =A0 =A0 return 0;
> >> =A0}
> >>
> >> +static int omap_sr_suspend(struct device *dev)
> >> +{
> >> + =A0 =A0 struct omap_sr_data *pdata;
> >> + =A0 =A0 struct omap_sr *sr_info;
> >> +
> >> + =A0 =A0 pdata =3D dev_get_platdata(dev);
> >
> > I'm not sure you need to use platform data here...
> see below
> >
> >> + =A0 =A0 if (!pdata) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: platform data missing\n", =
__func__);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 sr_info =3D _sr_lookup(pdata->voltdm);
> >
> > this field is held on struct omap_sr. Can't you:
> >
> > =A0 =A0 =A0 =A0struct omap_sr =A0*info =3D dev_get_drvdata(dev);
> >
> > ?? I see that a platform_set_drvdata() is missing from the driver, but
> > maybe you should add that instead of accessing platform_data.
> omap_sr_data is added in arch/arm/mach-omap2/sr_device.c
>=20
> With the current handling - it needs sr_data from which sr_info is
> pulled out. in the current implementation, sr_data contains the voltdm
> pointer from which sr_info is pulled out.

but sr_info is allocated on probe() isn't it ? if you add
platform_set_drvdata(pdev, sr_info) on probe, you won't need sr_data to
fetch sr_info, all you need is to use dev_get_drvdata(dev). Am I missing
something ?

> >> =A0static struct platform_driver smartreflex_driver =3D {
> >> =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_sr_remove,
> >> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "smartreflex",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &omap_sr_dev_pm_ops,
> >
> > this should not be valid in case CONFIG_PM isn't enabled.
> a) arch/arm/plat-omap/Kconfig
> CONFIG_OMAP_SMARTREFLEX depends on PM.
> b) SmartReflex is PM feature
>=20
> I dont see a need to add redundant code here.

fair enough if this will never build without CONFIG_PM ;-)

--=20
balbi

--PEpdcbHbO3kvNF3k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLaQtAAoJEAv8Txj19kN1q8wIAIThMpWXw0xf4QqOZdB9Uwhh
6+PRiLXBY3Igk5yu/7awBSqDnz8d1nDx6J55lzBCa06ZH5kIn+Wf10w8/t1lOxEt
3TQxsJhqc0RZX59GbXc1ihKDBUTPoJw72W7yeHIEKsVa1HCH4IB1P/fwmEzSqLWP
c62Qe/SuDUyOea5Tth+nMMXe3d0dwo7zOr+cqBl3yMgZVj4Ji5iyFtjrs+2fzZNp
mITSbbvPz4Hi2Iud4Hyz1DRtCcFQwRK6xHUVIMBTAnid5V4JShdJnluIukfCuewL
ZG2UF4x9I5mjfjIZegL0uIWYZPPMnCCBM4oSchrpDhLGyekhsp5tdKECKVn9WT8=
=fUDu
-----END PGP SIGNATURE-----

--PEpdcbHbO3kvNF3k--
