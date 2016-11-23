From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Wed, 23 Nov 2016 12:14:17 +0200
Message-ID: <839f0f26-3bb0-d368-8cff-dbccaffa7244@ti.com>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161110175033.GD27724@atomide.com> <13695022.UUbBUaRpJY@avalon>
 <1557347.d3YjqqaO81@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="uDlhLDqD2ubpr1g1j4cqN9ubdQNKlRXnl"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1557347.d3YjqqaO81@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--uDlhLDqD2ubpr1g1j4cqN9ubdQNKlRXnl
Content-Type: multipart/mixed; boundary="jCUcvB2gp2TSPXa8rEuO8L2AQ1oVIg1vd";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>,
 Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
 Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
 Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
 Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
 linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <839f0f26-3bb0-d368-8cff-dbccaffa7244-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
References: <20161107215020.31399-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20161110175033.GD27724-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> <13695022.UUbBUaRpJY@avalon>
 <1557347.d3YjqqaO81@avalon>
In-Reply-To: <1557347.d3YjqqaO81@avalon>

--jCUcvB2gp2TSPXa8rEuO8L2AQ1oVIg1vd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/11/16 23:25, Laurent Pinchart wrote:

>>>> [    2.766174] musb_bus_suspend 2586: trying to suspend as a_idle wh=
ile
>>>> active
>>>>
>>>> printed in a loop at boot time. I've traced musb->is_active being se=
t to
>>>> 1 in musb_start() with

> Actually disabling CONFIG_USB_MUSB_HDRC gets rid of the problem, quite =

> understandably. It's not a fix though, just a workaround. Are you inter=
ested=20
> in investigating this ?

I'm seeing this too. Did you manage to boot your Panda? If I disable
CONFIG_USB_MUSB_HDRC, I don't see that error print, but the ethernet
doesn't work, and so my nfsroot doesn't mount.

 Tomi


--jCUcvB2gp2TSPXa8rEuO8L2AQ1oVIg1vd--

--uDlhLDqD2ubpr1g1j4cqN9ubdQNKlRXnl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNWv5AAoJEPo9qoy8lh71S+4P/0PGB00T7rQUfjPecUZyiihn
VkEE2lrqzo68EnMEf7+sGNg/4yelM/qeHf1Bs0GF6XnQAxcoiO6rQiBa5glZKbFw
B6bnQVMATOLUv519q6riirOtfJfCnGWnQ/V5xh1ujnatJMGoWvto+QlerkuSs2aD
Oe4QrLvMbpS76avfVYSmqHKa4oExzBtI+q5GRxLiDElQYgDfNTnF6QMgRtXcLyb/
iAIoMKJGuGaUtIHBOhgw6JNGmvWot1dMiFpU6ZydxYFcSN5Mtz8XG5I27kjOo3hI
OzY86hn0lwl7LjwSG3pfotEdjdsiN532lvBkF+ubY7hhKujLwU5ck+lIWIQCWp4O
Uez+NGQcCHmzrQAPB8HqWyeWGK/lqKpIc8j7vD+u+nJD9T8xgxpdOYXSgUK9SYIs
xU8SdCCrddg+3RM8VjrAAqMXhPvx6yLDMmIEjjtypX5PhNE8mSnAeZjU3SRuiiWB
hlBcFrSreUpW8+MoiI4mvmbQvwlm0BvPjO7mowUT7NSff5Nh6eoikXogW0ken/0T
mVWeRkKeflrWMlMfn3IrmLRBYvcZlX239dHZs+el1Cp/XQDEvtE47q92yUpg1AOv
kSmDj1m8ZRoq3ryMgRo08iKiA40Y8ICAzKJy32WHr0xUho2Akcf191i32lDRWQ+D
bx4MxNdRJkcFCqCjq6NU
=NNFd
-----END PGP SIGNATURE-----

--uDlhLDqD2ubpr1g1j4cqN9ubdQNKlRXnl--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
