From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 3/5] usb: dwc3: omap: Don't set POWERPRESENT
Date: Tue, 10 May 2016 12:54:11 +0300
Message-ID: <87futqi6gs.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462873919-20532-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> TRM [1] recommends that POWERPRESENT bit must not be
> set and left at it's default value of 0.
>
> [1] OMAP542x TRM - http://www.ti.com/lit/pdf/swpu249
> Section 23.11.4.5.1 Mailbox VBUS/ID Management
>
> "Because PIPE powerpresent has a different meaning in host and in device =
mode,
> and because of the redundancy with the UTMI signals, the controller ORes
> together the appropriate PIPE and UTMI inputs to create its internal
> VBUS status. For that reason, it is recommended to leave field
> USBOTGSS_UTMI_OTG_STATUS[9] POWERPRESENT at its default value (=3D0), and=
 only to
> fill in the USB2 VBUS status fields in the same register."
>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

to make sure we avoid regressions, do you mind sharing on which
platforms you tested this patch ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMa/DAAoJEIaOsuA1yqREk+kP/ReHHndcqN7JTK34VQsUMQmM
4ODyqFoGNz/PQ21qXybmWI4tH11Z5gR0ma1sKpITIWCK+dqMHXrw+wL188RYYn3F
0KE9puwf7eW63Flz8w6Q4R1MDe6gDRU2jCiJfPyKPrrhYpD9qPT0QlCPNGG0Y34M
0M7/dCVOPkZ0oVoIuY1I3K30ebIDFINDmBUT4/cToD4UzMM2JQyCLlWNKbsmYc3z
S5Bu3ila5BpOe8oViHCgCzfoK+66bDkWFMCX5+l+TmsCmEPcx69badZvOcUSoDw8
2MyTE6xMgxfjyCBsuENZg7P6f0iXk8ddAh/KCycl59ckGAJO0xVxXhjBD74y3KTE
zbh7bANYiagXqxAUi2Jw7+q0kuoY16KFBU9JqDjnRZIXhZO/ONd5udAxCeFNH5t/
q4kWvINji2PJMjuE/tT80QPRqxr+Oyyn5Etlbc+XTvMUi8wE+VaVPtIsSqYZRnrH
dz6C1bgXduols6Jay7Zg+zDRP39vk1N5AvRKlDIu9bqui42R1z295YWJ64vgxfI1
6S7OKArunEjExwpFV9/TXJ3fNUjRgewLkhFwA2S6z8rebuy5UeT0f0xE7/iKRTv1
BxBZ8hUJ3hprYxMA/GFhm1Iluvf22/Ttxu4vB9aOT6bo9mHiBlIHN7aUapoT/Evy
yswP64hdK18PXPZxoKRF
=39Jm
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
