From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 15:35:00 +0300
Message-ID: <87fus6n2iz.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <5767C1B9.2060805@ti.com> <878ty0qd7q.fsf@linux.intel.com> <20160621063936.GB5108@shlinux2> <87d1nbovp7.fsf@linux.intel.com> <20160621080209.GC5108@shlinux2> <87mvmfneeq.fsf@linux.intel.com> <20160621091437.GE5108@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160621091437.GE5108@shlinux2>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> >> >> >>> + * @otg_dev: OTG controller device, if needs to be used with =
OTG core.
>> >> >> >>=20
>> >> >> >> do you really know of any platform which has a separate OTG con=
troller?
>> >> >> >>=20
>> >> >> >
>> >> >> > Andrew had pointed out in [1] that Tegra210 has separate blocks =
for OTG, host
>> >> >> > and gadget.
>> >> >> >
>> >> >> > [1] http://article.gmane.org/gmane.linux.ports.tegra/22969
>> >> >>=20
>> >> >> that's not an OTG controller, it's just a mux. No different than I=
ntel's
>> >> >> mux for swapping between XHCI and peripheral-only DWC3.
>> >> >>=20
>> >> >> frankly, I would NEVER talk about OTG when type-C comes into play.=
 They
>> >> >> are two competing standards and, apparently, type-C is winning whe=
n it
>> >> >> comes to role-swapping.
>> >> >>=20
>> >> >
>> >> > In fact, OTG is mis-used by people. Currently, if the port is dual-=
role,
>> >> > It will be considered as an OTG port.
>> >>=20
>> >> That's because "dual-role" is a non-standard OTG. Seen as people real=
ly
>> >> didn't care about OTG, we (linux-usb folks) ended up naturally referr=
ing
>> >> to "non-standard OTG" as "dual-role". Just to avoid confusion.
>> >
>> > So, unless we use OTG FSM defined in OTG spec, we should not mention
>> > "OTG" in Linux, right?
>>=20
>> to avoid confusion with the terminology, yes. With that settled, let's
>> figure out how you can deliver what your marketting guys are asking of
>> you.
>>=20
>
> Since nxp SoC claims they are OTG compliance, we need to pass usb.org
> test. The internal bsp has passed PET test, and formal compliance test
> is on the way (should pass too).=20
>
> The dual-role and OTG compliance use the same zImage, but different
> dtb.

okay, that's good to know. Now, the question really is: considering we
only have one user for this generic OTG FSM layer, do we really need to
make it generic at all? I mean, just look at how invasive a change that
is.

My fear is that, as stated before, we don't have enough variance to be
able to design something that many could use. On top of that, most folks
are moving to type-c connector which, in reality, can't really implement
OTG.

Considering that Apple/Intel have already announced [1] that they will
use type-c connector, it's not too farfetched to speculate that CarPlay
will, eventually, rely on Power Delivery for role swapping. IOW, OTG has
its days counted. In 2 years' time, the market will have moved on to
Type-C and the generic OTG layer will be left to bit rot as time goes
by.

This is why I think that these changes should be local to chipidea,
considering chipidea is the only user for them. As for dwc3, we can get
something much simpler since, at least so far, there's no full OTG
requirement from anywhere I know and, even if OTG becomes a requirement
for any of dwc3 users, the HW handles the state machine for us.

What do you think?

[1] https://thunderbolttechnology.net/blog/thunderbolt-3-usb-c-does-it-all

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaTR0AAoJEIaOsuA1yqRECs0QAKKr3e6XPode7reT7clYTFMU
wMI9YDeXHEY2tiQ8V+NY2He8kUtkA3sMowjnMhryoJcPmHTWsOtdD2My+fcuIQN0
skR66ApNBcXtkOCMbGMl3IcEBPScDghJLSVADm8vev6jz1yeenpP9I9e1CGk/F2+
0JZtsxVL27lIkwa7POjGMis95CS0Yg3K/ikx+dPiE7te0E3BdHjYIbMUKke4gs2H
f0gJdjRuYg1kREl68aX4q2c1rQsYf4uBx5T1Bg6eHLSxqg2L1XIQ1yTzeVEpYgSD
j2n6YN6o9ESoSQxUm/vqZS1paOHlSj86gYAFZzx7qacEu3dZI2jBj/4CfpqprLNU
0K2q5jCH2X9fBD/KKOnImLOkTFmkoHflRJh6YSUC5XVFLlxHDh9kZdkg+rpZ0OqD
S1/9SCRAv012c4J2cL9KXcMdL5+Jt5SyT6lUfFhLVqymzT+2iy1r5SAc1kUiCiM/
uGSUjtaHF7lp2WzVngXET670whhXc69T9xmzR0nBuzfOVVijsiuyaS9GCeUiNb8I
+l8AkKy1R9AYrVOt77bLjmNMfIFsG0sc+jW0jZqjsqQynhahICHyXSSqKKpVkMCf
cMHseIZgcyxY8Dcwh2y5kQhHoKewzWPRkltjCDYVz7qa5bpU1H71qC18JttkB8xg
jokq6LMDJgN3wPT0i09F
=q5Nw
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
