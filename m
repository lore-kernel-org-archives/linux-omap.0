From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 11:18:21 +0300
Message-ID: <87mvmfneeq.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <5767C1B9.2060805@ti.com> <878ty0qd7q.fsf@linux.intel.com> <20160621063936.GB5108@shlinux2> <87d1nbovp7.fsf@linux.intel.com> <20160621080209.GC5108@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160621080209.GC5108@shlinux2>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> >> >>> +
>> >> >>> +		/* start host */
>> >> >>> +		ret =3D hcd_ops->add(otg->primary_hcd.hcd,
>> >> >>> +				   otg->primary_hcd.irqnum,
>> >> >>> +				   otg->primary_hcd.irqflags);
>> >> >>=20
>> >> >> this is usb_add_hcd(), is it not? Why add an indirection?
>> >> >
>> >> > I've introduced the host and gadget ops interface to get around the
>> >> > circular dependency issue we can't avoid.
>> >> > otg needs to call host/gadget functions and host/gadget also needs =
to
>> >> > call otg functions.
>> >>=20
>> >> IMO, this shows a fragility of your design. You're, now, lying to
>> >> usb_hcd and usb_udc and making them register into a virtual layer that
>> >> doesn't exist. And that layer will end up calling the real registrati=
on
>> >> function when some magic event happens.
>> >>=20
>> >> This is only really needed for quirky devices like dwc3 (but see more=
 on
>> >> dwc3 below) where host and peripheral registers shadow each
>> >> other. Otherwise we would be able to always keep hcd and udc always
>> >> registered. They would get different interrupt statuses anyway and
>> >> nothing would ever break.
>> >>=20
>> >> However, when it comes to dwc3, we already have all the code necessary
>> >> to workaround this issue by destroying the XHCI pdev when OTG interru=
pt
>> >> says we should be peripheral (and vice-versa). DWC3 also keeps track =
of
>> >> the OTG states for those folks who really care about OTG (Hint: nobody
>> >> has cared for the past 10 years, why would they do so now?) and we do=
n't
>> >> need a SW state machine when the HW handles that for us, right?
>> >>=20
>> >> As for chipidea, IIRC, that doesn't need a SW state machine either, b=
ut
>> >> I know very little about that IP and don't even have documentation on
>> >> it. My understanding, however, is that chipidea behaves kinda like MU=
SB,
>> >> which changes roles automatically in HW based on ID pin state.
>> >
>> > Chipidea needs to set register for USB role manually.
>>=20
>> okay, so chipidea has private control of role. Much like dwc3. That's go=
od.
>>=20
>> >> >>> + * @otg_dev: OTG controller device, if needs to be used with OTG=
 core.
>> >> >>=20
>> >> >> do you really know of any platform which has a separate OTG contro=
ller?
>> >> >>=20
>> >> >
>> >> > Andrew had pointed out in [1] that Tegra210 has separate blocks for=
 OTG, host
>> >> > and gadget.
>> >> >
>> >> > [1] http://article.gmane.org/gmane.linux.ports.tegra/22969
>> >>=20
>> >> that's not an OTG controller, it's just a mux. No different than Inte=
l's
>> >> mux for swapping between XHCI and peripheral-only DWC3.
>> >>=20
>> >> frankly, I would NEVER talk about OTG when type-C comes into play. Th=
ey
>> >> are two competing standards and, apparently, type-C is winning when it
>> >> comes to role-swapping.
>> >>=20
>> >
>> > In fact, OTG is mis-used by people. Currently, if the port is dual-rol=
e,
>> > It will be considered as an OTG port.
>>=20
>> That's because "dual-role" is a non-standard OTG. Seen as people really
>> didn't care about OTG, we (linux-usb folks) ended up naturally referring
>> to "non-standard OTG" as "dual-role". Just to avoid confusion.
>
> So, unless we use OTG FSM defined in OTG spec, we should not mention
> "OTG" in Linux, right?

to avoid confusion with the terminology, yes. With that settled, let's
figure out how you can deliver what your marketting guys are asking of
you.

>> > You are right, if the connector is type-c, it will be called as "type-c
>> > port" by people :)
>>=20
>> oh no, that's not what I'm talking about. If you read Type-C and PD
>> specs, they define their own method for data role swapping. USB OTG
>> doesn't fit on top of a Type-C environment. It's not about what people
>> will call it, it's really that OTG can't work on top of type-c. For
>> starters, there's no ID pin ;-)
>
> I know type-c, yes, there is no relationship between OTG and type-c.

okay, thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaPhNAAoJEIaOsuA1yqRENHcP/jmghSW2gkCWzdckoE3R64hw
TI0aAHygYkOEyuYM0j+mUoBUAlVkeXcvnQ3W9aiaCNdf5ot0eo+2qPWIpo/eTmXP
SvMA9WkjJcDnz6aiuJmTK4QDiWt6h7AQk7hEc8N8kodp4sgqqW+iV+MmzSEFmUqZ
kuwo0eP4hs0v1kNF8mlqXApBdo/my1mL7QfE2spfWoGVzTBUEc/M6123ZVSnawWm
fcpHYQKz4SyRSJtb1unmkTgQtZH1l1bjjFHFM90Ri/c93u8rrZWqxeal6XPZuvtn
EhRdMaESLyZibzT32jwLPxMPrdtiAIymxXNf+0XgqssmQwfDcWYs8qNsevGdKrnU
Iz8Uc1CkQtsE302CKKeHXE2KkUFEQcNnEIJMD4EkawX0usfOSsWKXNM7Fx7r+Y60
+0iJCOAHNLCwnyjdQNKEeJOnQmePEmOoXSnwHPRemXG+lD+O9RbsRLIwv9z5DqPF
8IfCOqkLNpmtUMFzWClOq4lJGWfU3WPMc3aubCTuFSY5EEJOVswoCxoCM8EuTxrr
RhVG9KkO5Lq2q6zwwoLuPT90VEs8YA9694F0+8sUVWi6AyJObsApfYzn3tq+Zkzn
u+TLsu9AqgsGELzL4IEohbBhX6nr9aJYCqNjIrAZ+6fJk7jm42N5Vmcxm7upu7t1
YgFS9w8qxBL3tQnL8/a8
=AmA0
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
