From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] arm: boot: dts: am4372: add operating points
Date: Mon, 11 May 2015 10:19:30 -0500
Message-ID: <20150511151930.GA19183@saruman.tx.rr.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <554D17F3.7090008@ti.com>
 <554D18AB.6060901@ti.com>
 <20150508202439.GA25459@saruman.tx.rr.com>
 <554FF686.5050704@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36191 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbbEKPVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 11:21:51 -0400
Content-Disposition: inline
In-Reply-To: <554FF686.5050704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 10, 2015 at 07:23:34PM -0500, Nishanth Menon wrote:
> On 05/08/2015 03:24 PM, Felipe Balbi wrote:
> > On Fri, May 08, 2015 at 03:12:27PM -0500, Nishanth Menon wrote:
> >> On 05/08/2015 03:09 PM, Nishanth Menon wrote:
> >>> On 05/08/2015 02:57 PM, Felipe Balbi wrote:
> >>>> By adding operating points, cpufreq-dt has a
> >>>> chance of running and doing something useful.
> >>>>
> >>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >>>> ---
> >>>>  arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
> >>>>  1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am437=
2.dtsi
> >>>> index c80a3e233792..ea1db20f64fc 100644
> >>>> --- a/arch/arm/boot/dts/am4372.dtsi
> >>>> +++ b/arch/arm/boot/dts/am4372.dtsi
> >>>> @@ -38,6 +38,15 @@
> >>>>  			clocks =3D <&dpll_mpu_ck>;
> >>>>  			clock-names =3D "cpu";
> >>>> =20
> >>>> +			operating-points =3D <
> >>>> +				/* kHz		uV */
> >>>> +				1000000		1325000 /* OPP_NITRO */
> >>>> +				 800000		1260000 /* OPP_TURBO */
> >>>> +				 720000		1200000 /* OPP_120 */
> >>>> +				 600000		1100000 /* OPP_100 */
> >>>> +				 300000		 950000 /* OPP_50 */
> >>>> +			>;
> >>>> +
> >>>>  			clock-latency =3D <300000>; /* From omap-cpufreq driver */
> >>>>  		};
> >>>>  	};
> >>>>
> >>> which of these OPPs need AVS? which of these are dependent on Efuse b=
it
> >>> dependent?
> >>>
> >>
> >>
> >> You can use
> >> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-3.14.=
y/arch/arm/mach-omap2/opp43xx_data.c
> >> for reference.
> >=20
> > heh, why isn't that upstream yet ? Seems to be ready already. The point
>=20
> we have tried in the past[1] - unfortunately that was just bandaid since
> the existing OPP device tree bindings have very limiting behavior across
> multiple SoCs.This was one of the reasons why we stopped adding more
> OPPs, since we are hoping to see the new bindings[2] which is under
> discussion settle down and help enable support for cases like that we
> have on TI SoCs, iMX SoCs etc.

fair enough.

> > is that as of now, u-boot will set maximum OPP it can find and, for
> > AM437x, that will be 800MHz or 1GHz depending on your board. 1GHz might
> > not be supported in all SoCs and letting that be used all the time is
> > likely going to reduce silicon lifetime.
>=20
> > At least allowing ondemand governor run, we will be mostly running at
> > 300MHz and only jump to "invalid" OPPs under load which, granted, is
> > still not perfect, but better than running at 1GHz all the time, don't
> > you agree ?
> The fix for this should ideally be in u-boot - we are trying not to

right, ideally, yeah; but then we go back to the discussion regarding
kernel vs bootloader dependencies :-)

> introduce dts changes in the hopes that the new proposed bindings that
> Viresh has on discussion comes to conclusion and help introduce new dtb
> support with proper SoC description. allowing an SoC to enter an invalid
> OPP is broken by design. we must attempt to curb it. unfortunately, we
> already do have a broken implementation for AM335x, DRA7 in place which
> went with the assumption that we will be able to do modifiers on top of
> existing dt description and the hopes that [1] will eventually get
> upstream. But, as is clear now, [1] has no future path in upstream
> kernel. following the same broken path for newer SoC definitions will
> probably very short sighted by us.
>=20
> in my opinion, doing a temporary hack in upstream kernel is not an
> elegant approach. I suggest helping review and approving Viresh's new

however this is not a hack, right ? If we get rid of OPP_NITRO and
OPP_TURBO, then we will more than likely always be dealing with safe
OPPs (yeah, I need to confirm this since it's not on public TRM, so as
of now, take this statement with a grain of salt :-), moreover, even
though we're trying to change opp bindings, the current situation is
still very much accepted and will remain valid even after changing
binding :-)

Not to mention that people using AM43xx today might be using it under
invalid OPPs and decreasing silicon life; I'd assume that's a very
urgent detail to sort out.

> bindings so that we have a longer term solution is more the way to do thi=
s.
>=20
> Just my 2 cents. Thanks once again for identifying the urgent need for
> helping Viresh's series along - will be great if folks could help review
> and approve his series to get them upstream and help all of us ARM SoC
> variations along.

np.

--=20
balbi

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVUMiCAAoJEIaOsuA1yqREdxUQAI6lMscTGeZiPazHxAsHh+4Y
kn4ka14+era/4vTZIDBwVVh/FkbVE6E1vyJMstb1L+h7CqCg0iwebWz/D6ZwtFoF
eKPs3YVkGQDIAuvi0UkepeJCyaZPoXq9zyJqg5ksDkHL/Rp83Nu3DUJeASjyVYXe
5201r5/9siymjwrlGS0P+CK6/GqU44sEfMjKVzTxoin+p6JeY5alSMb2wDovWxY/
hALL36VCv3P6i6+QSfb4xMed/LZrMsXnaRqCqSlFz4lCIAOv5+iuK9MS6XKOqoLp
GwtUkzan0TD/n3rJsMFYC9e+lil1bno9c3KZnEeLDMIoHNbuwWtUATxKecmss039
8V9CWvjYQu6bcCmV7EYq+hr9WcqqfYMJ8i4dyhpPaDP0QDn/L48Slz1P355x1Yi+
ypnszPaCkVulxjp8LnBPV6DqHjoWWn6tCzFjKpsWmQaVcZHaIAJbmzpMcogmF31O
H56Xv0GFbVsqjY5RUXB6ccFpn/JpnJbgYqyTzg9IhHmzp/p1e0+XEVp1DEfxc/nw
GtMEDCV/grpZLcnCst8sT57FbCFgtMAfbFIjNYfyE1qvHdvJjmNQ/+fxJskdcV9l
Y8OJdSXMfl4cjyIN5voaCHf+QqIjQetJ/N0+Akoc6wfh9f7zMXqH1R9zFARGQDUu
XMu1bp+K8ePyoz8IkuRa
=xBCR
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
