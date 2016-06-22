From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 22 Jun 2016 11:00:32 +0300
Message-ID: <87lh1xlkkf.fsf@linux.intel.com>
References: <20160621063936.GB5108@shlinux2> <87d1nbovp7.fsf@linux.intel.com> <20160621080209.GC5108@shlinux2> <87mvmfneeq.fsf@linux.intel.com> <20160621091437.GE5108@shlinux2> <87fus6n2iz.fsf@linux.intel.com> <20160621131205.GG5108@shlinux2> <874m8mmwdo.fsf@linux.intel.com> <20160622033356.GB21361@shlinux2> <87shw5lnrs.fsf@linux.intel.com> <20160622073041.GC21361@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160622073041.GC21361@shlinux2>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> >> >> >> > So, unless we use OTG FSM defined in OTG spec, we should not =
mention
>> >> >> >> > "OTG" in Linux, right?
>> >> >> >>=20
>> >> >> >> to avoid confusion with the terminology, yes. With that settled=
, let's
>> >> >> >> figure out how you can deliver what your marketting guys are as=
king of
>> >> >> >> you.
>> >> >> >>=20
>> >> >> >
>> >> >> > Since nxp SoC claims they are OTG compliance, we need to pass us=
b.org
>> >> >> > test. The internal bsp has passed PET test, and formal complianc=
e test
>> >> >> > is on the way (should pass too).=20
>> >> >> >
>> >> >> > The dual-role and OTG compliance use the same zImage, but differ=
ent
>> >> >> > dtb.
>> >> >>=20
>> >> >> okay, that's good to know. Now, the question really is: considerin=
g we
>> >> >> only have one user for this generic OTG FSM layer, do we really ne=
ed to
>> >> >> make it generic at all? I mean, just look at how invasive a change=
 that
>> >> >> is.
>> >> >
>> >> > If the chipidea is the only user for this roger's framework, I don't
>> >> > think it is necessary. In fact, Roger introduces this framework, and
>> >> > the first user is dwc3, we think it can be used for others. Let's
>> >>=20
>> >> Right, we need to look at the history of dwc3 to figure out why the
>> >> conclusion that dwc3 needs this was made.
>> >>=20
>> >> Roger started working on this framework when Power on Reset section of
>> >> databook had some details which weren't always clear and, for safety,=
 we
>> >> always had reset asserted for a really long time. It was so long (abo=
ut
>> >> 400 ms) that resetting dwc3 for each role swap was just too much.
>> >>=20
>> >> Coupled with that, the OTG chapter wasn't very clear either on
>> >> expections from Host and Peripheral side initialization in OTG/DRD
>> >> systems.
>> >>=20
>> >> More recent version of dwc3 databook have a much better description of
>> >> how and which reset bits _must_ be asserted and which shouldn't be
>> >> touched unless it's for debugging purposes. When I implemented that, =
our
>> >> ->probe() went from 400ms down to about 50us.
>> >>=20
>> >> Coupled with that, the OTG chapter also became a lot clearer to the
>> >> point that it states you just don't initialize anything other than the
>> >> OTG block, and just wait for OTG interrupt to do whatever it is you n=
eed
>> >> to do.
>> >>=20
>> >> This meant that we could actually afford to do full reinitialization =
of
>> >> dwc3 on role swap (it's now only 50us anyway) and we knew how to swap
>> >> roles properly.
>> >>=20
>> >> (The reason for needing soft-reset during role swap is kinda long. But
>> >> in summary dwc3 shadows register writes to both host and peripheral
>> >> sides)
>> >>=20
>> >> > just discuss if it is necessary for dual-role switch.
>> >>=20
>> >> fair. However, if we have a single user we don't have a Generic
>> >> layer. There's not enough variance to come up with truly generic
>> >> architecture for this.
>> >>=20
>> >> --=20
>> >
>> > I have put some points in my last reply [1], I summery it here to
>> > see if a generic framework is deserved or not?
>> >
>> > 1. If there are some parts we can use during the role switch
>> > - The common start/stop host and peripheral operation
>> > eg, when switch from host to peripheral, all drivers can use
>> > usb_remove_hcd to finish it.
>>=20
>> a UDC such as dwc3 already implements start/stop for peripheral and
>> host. Why would go through and indirection layer that just comes back to
>> us? (well, dwc3's host side, start/stop translates to adding/removing
>> xhci-plat's device)
>>=20
>> > - A common workqueue to handle vbus and id event
>>=20
>> I already have a threaded IRQ handler. Why do I need a workqueue?
>>=20
>
> I know it can be done in individual driver, don't you think
> we need a common part to manage the dual-role switch process,

A common part will be a requirement when we have at least 3 users for
it. Right now there's only one. So how can this be common at all?

> since dual-role switch is used more and more common, and
> there are so many switch methods:
>
> - ID pin
> - sysfs
> - type-c
> - OTG FSM
> - Registers
>
> Maybe Roger's framework is a little complicated, but if it is the
> correct direction, we can improve it.

IMO, we don't have enough users

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXakWgAAoJEIaOsuA1yqREaUkQAIvniQ7hk3rzpZTEEkmvpASC
vMLvY/6z9N/jOlaICxF3QT6HslQOjA5OmIMWztht3cHYCWPf8gq9FTCVZzoo6NY4
3GmOpZjS+zdR7L53shuWt5yaTAUysZ81S432ky+Zkin9hWpjRzANWec+xfjHvLSa
TlQw2FS75VPA4tyiQtVWK2YQ1SaIoNn06/h7yZusgRl2oz7n5Dujx2b9ot/nLMSz
2Q+s/Kj+dfoS7OGTO/6lmqh5S3/rKiJBRr72QZuYY/pG7dWgOPfZ253Ce5OfdZPl
BGhv5bY8gS9rVHZuYgQtKQhrOLhDdhMGSjkrYICY8F7veX6e+0+z9rQF3t/3/kvh
EMU4SBkFfdplomg0BejE7X0E4Wi+cma3gSgK5e2bI1ZYWOMldvzabZi12HNWYw/7
N7/QZSHM7yl5Uvwoxmz68oj1Ax0pzY6X5OU3WwpxuvPyXLab61K2i6tAga6TyA6E
H6Y+lDzTF3h0QkcYvd82+UKkZV6ntiVelbGH+FInsRZjY8AeL4VgJE0GL6rGkVYp
0jPzVjQ7KeCGZIfhKh6YQ8pX+aU1SFzCQ0+IxXWOZ9HTfNsKcSUhAc//nxJOyVxT
9S9i68sicOclOUcE49WcDkcJrIB0sM1aiLx5YA7V+BKjESm6tQab/kpAGi2Muso3
DaowddtaVMYyHK/Vrzxb
=6VXL
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
