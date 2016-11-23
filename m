From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Wed, 23 Nov 2016 17:54:37 +0200
Message-ID: <47c6e11e-3725-8955-5cc4-654df4d1c3bc@ti.com>
References: <20161107215020.31399-1-tony@atomide.com>
 <1557347.d3YjqqaO81@avalon> <839f0f26-3bb0-d368-8cff-dbccaffa7244@ti.com>
 <10445300.62NO2xvFpp@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="cIFMCfwPV60GVODSgj0sIVwivWLtXi3DT"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <10445300.62NO2xvFpp@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--cIFMCfwPV60GVODSgj0sIVwivWLtXi3DT
Content-Type: multipart/mixed; boundary="ciLAa3RPNqfUU9GI32J9Xa7m49dearo24";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>,
 Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
 Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
 Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
 Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
 linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <47c6e11e-3725-8955-5cc4-654df4d1c3bc-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
References: <20161107215020.31399-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <1557347.d3YjqqaO81@avalon> <839f0f26-3bb0-d368-8cff-dbccaffa7244-l0cyMroinI0@public.gmane.org>
 <10445300.62NO2xvFpp@avalon>
In-Reply-To: <10445300.62NO2xvFpp@avalon>

--ciLAa3RPNqfUU9GI32J9Xa7m49dearo24
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/11/16 17:49, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Wednesday 23 Nov 2016 12:14:17 Tomi Valkeinen wrote:
>> On 10/11/16 23:25, Laurent Pinchart wrote:
>>>>>> [    2.766174] musb_bus_suspend 2586: trying to suspend as a_idle =
while
>>>>>> active
>>>>>>
>>>>>> printed in a loop at boot time. I've traced musb->is_active being =
set
>>>>>> to 1 in musb_start() with
>>>
>>> Actually disabling CONFIG_USB_MUSB_HDRC gets rid of the problem, quit=
e
>>> understandably. It's not a fix though, just a workaround. Are you
>>> interested in investigating this ?
>>
>> I'm seeing this too. Did you manage to boot your Panda? If I disable
>> CONFIG_USB_MUSB_HDRC, I don't see that error print, but the ethernet
>> doesn't work, and so my nfsroot doesn't mount.
>=20
> Do you use ethernet over USB gadget or over LAN9514 (smsx95xx) ? The LA=
N9514=20
> is connected to the EHCI USB interface so it shouldn't depend on MUSB.

smsx95xx. I didn't look at it further, so possibly there's something
else broken/changed that prevented the ethernet from working.

 Tomi


--ciLAa3RPNqfUU9GI32J9Xa7m49dearo24--

--cIFMCfwPV60GVODSgj0sIVwivWLtXi3DT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNbu9AAoJEPo9qoy8lh71O3cQAKPH+Rv95K49szHZE2OLXi9i
L93JnigGoTqa6W6HQmgArTkvWp2oN1m+H+imnefFvGHq2OHg9Bu8C2hwNx0Qe3Oz
6IXHDHu4GKXWN4OXGW8e3BuhP/Gpr0MuNYBthYzuAZg6HYpUCw/0fDctNn2injKt
W3Fr+Ry4+Ikp4mZu1ZDN1Uu5iDd0pUcH0Esl1Wtu830ZEGRDT4U7bPCefF9H/r1H
HFP26G3tLtJOEDwiWsuAnAcHb7kOpiIbxdhPQJT4Ebsqzh5tYo2LK/68QIFKheod
D2yqJ0ok/G2iZRkrq4EQak4HoC5kUq9znrauehLW6KDA3dKQ6T48Ln9Rmd5pnQcf
CwJII6dnlkgrYtAV5wkIvHPU7ob7ivBxvvb8ye1hlfLFzj81Pfq3HvmPA7RxFPEY
qzQV8vI1WSHXEsZYYwVUt7fP530Bz+JkKynbNdRrrEqVbmQZTKjGw/HZqxtxmFxi
+uYgoNhgqrc9E810tp+P0qysVXyzoHmU+0+qi6EeGjpPqRKYUBu5YM5SSRMahmQT
e5C0LFHtDsMQuTPbafA0OhZDlF/vz3mJ1FZsmyjcPtqogoFjQpFvNxN8golwQA7A
RmVGBTfWYCvEB1JakFhoDvtrCw+djIFE5XO/bCn/kLvc1wzAHPHeZMA/qgawAO9L
PmLV9YKIOjunzyvSu0Tv
=0p7E
-----END PGP SIGNATURE-----

--cIFMCfwPV60GVODSgj0sIVwivWLtXi3DT--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
