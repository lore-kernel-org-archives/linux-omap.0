From: NeilBrown <neilb@suse.de>
Subject: Re: bisected regression: arm: omap3: voltage: fix channel
 configuration
Date: Tue, 24 Jul 2012 11:30:57 +1000
Message-ID: <20120724113057.5f38806e@notabene.brown>
References: <20120723210635.25e0a0d8@notabene.brown>
	<1343053494.30247.22.camel@sokoban>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/=sxwa/YMZvVj4ki59dG_eW6"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36499 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755049Ab2GXBat (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jul 2012 21:30:49 -0400
In-Reply-To: <1343053494.30247.22.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

--Sig_/=sxwa/YMZvVj4ki59dG_eW6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Jul 2012 17:24:54 +0300 Tero Kristo <t-kristo@ti.com> wrote:

> Hi Neil,
>=20
> On Mon, 2012-07-23 at 21:06 +1000, NeilBrown wrote:
> > My GTA04 (mobile phone using OMAP3 and TWL4030 PMIC) has difficulty reb=
ooting
> > with 3.5.
> > The first boot (after power on) works fine.  But when I reboot it hangs=
 just
> > before
> >=20
> >   Switched to new clocking rate (Crystal/Core/MPU): 26.0/332/800 MHz
> >=20
> > is printed.  If I remove "mpurate=3D800" from the kernel command line t=
he
> > problem goes away.
> >=20
> > If I boot into 3.5, which works, and then reboot into an older working =
kernel
> > it freezes too.  So the 3.5 kernel leaves the device in a state which c=
auses
> > any kernel to hang.
>=20
> TWL chip retains its settings over warm boot which most likely explains
> this.
>=20
> >=20
> > I spent a while bisecting and narrowed it down to=20
> >=20
> > commit f9d29f1617eb1b2f1fd41622bd1a0fc51658d2f0
> > Author: Tero Kristo <t-kristo@ti.com>
> > Date:   Mon Feb 20 12:26:06 2012 +0200
> >=20
> >     arm: omap3: voltage: fix channel configuration
> >=20
> >=20
> > If I revert this patch then the problem goes away.  So that is the fix =
I'll
> > go with for now, but if anyone wants me to try something else to help f=
ind
> > out what the real problem is and to find a proper fix, I'm happy to hel=
p.
>=20
> Do you have cpufreq enabled in your build? If yes, then most likely the
> crash occurs because cpufreq scales the used OPP to minimum after boot
> and the warm reset doesn't switch the voltages properly and crashes as
> it attempts to raise CPU frequency.

Yes, I have cpufreq enabled.
CONFIG_ARCH_HAS_CPUFREQ=3Dy
CONFIG_ARM_OMAP2PLUS_CPUFREQ=3Dy

Interestingly cpufreq thinks the range is 300MHz to 600MHz:

/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:300000 6=
00000=20

where 600 is that the freq is at boot:

# dmesg | grep Cryst
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
[    0.056365] Switched to new clocking rate (Crystal/Core/MPU): 26.0/332/8=
00 MHz

Does that mean the mpurate=3D800 isn't doing anything at all?

>=20
> Also, if cpufreq is enabled, mpurate command line option doesn't really
> do much... it will just switch the frequency to the desired target
> during beginning of boot until cpufreq kicks in and switches the OPP to
> its own understanding of desired cpu rate. I think the handling of
> mpurate command line option should probably be ignored in cpufreq
> builds, or moved within the cpufreq driver.

So it looks like you are suggesting that I simply remove the "mpurate=3D800"
as it isn't doing anything useful anyway.  Is that right?

Might there be some way to get it to scale higher than 600MHz?
The first message from U-boot says:

OMAP3630/3730-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz

and the board manufacturer thinks it should be capable of 800MHz.

Thanks,
NeilBrown


>=20
> I tried to craft a quick boot time fix for this problem, but it seems
> the voltage layer is not properly initialized yet when the mpurate
> setting kicks in and it is not very straightforward to scale voltage
> during this time without writing a serious hack.
>=20
> If you don't have cpufreq enabled, then the vdd routing on your board
> might be interesting (I don't think this is the case as the kernel works
> okay after 1st boot.)
>=20
> -Tero
>=20


--Sig_/=sxwa/YMZvVj4ki59dG_eW6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBUA360Tnsnt1WYoG5AQKAWQ/9ExvTHz0sSNUUATjbr8rlWU61+5ybyfdI
o7aDYFhKuCzOvDdGZLg6fYrLSfd+5SMFrkr5eueJ4XHJsJ7lsO+dpZ7s+ATGL+iw
Lvb+DpIsalf1QLDB0G8p8IZ1HXiTI1D+YqyRu3z35j4NV81ZOgdXIG/OT8qF2+O+
j8jyi//L69jiO7GUPVsTGYLwECqTtifgzBPch3IVVoryZjLYPencz6CihSFCHnyA
rxcqtrFcdsjJ9aybXClFkqEO44BATNbpBoDqSzze5c7D7tjyZa0m5BZZcSrQPr8U
uSXJuefZ3ROJ+yo7q8Q9ig6kWZHs9AyT4+C5unHN695pa0TyTdGTJcgDgvt2JUgC
Jn9Axbfy+04yxXAzscGD1aSOByfawVJclPJPmOZ+vzV28ePmwWHCWdABTl3rzjOY
9IEg/keaErkHOhXmyfYXGAn8IaTm6kMiGVxN1PnurXl6gkKWoH7puwfHpY4cwskZ
oPDIODUOOjvVluol1i1OzxiIVdbM2GiJxTKjCDICBfB5xTDVWflsko9O7qIHRxTa
ctLX39kbuChCt2w+9M62cGHFTK7vAmMAatkoEs/hRAIPN7hpjjaiE4gdE+DNzAWI
bvqvbT72InNqF2aAMr3rj+sjZWybh6jQdsrN+jXDzaXnzcbmcwDu9SfoR6bEY3mz
IO8fC/hePiA=
=YHDm
-----END PGP SIGNATURE-----

--Sig_/=sxwa/YMZvVj4ki59dG_eW6--
