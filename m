From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: RE: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 10:21:15 +0300
Message-ID: <87a8ifovmc.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <5767C1B9.2060805@ti.com> <SG2PR06MB0919045392F2545FF85033CED82B0@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <SG2PR06MB0919045392F2545FF85033CED82B0-ESzmfEwOt/zNQ8RBPPB5A20DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "peter.chen@freescale.com" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "tony@atomide.com" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "gregkh@linuxfoundation.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams@intel.com" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mathias.nyman@linux.intel.com" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Joao.Pinto@synopsys.com" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "jun.li@freescale.com" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grygorii.strashko@ti.com" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "robh@kernel.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar@ti.com" <nsekhar-l0cyMroinI0@public.gmane.org>, "b-liu@ti.com" <b-liu-l0cyMroinI0@public.gmane.org>, "joe@perches.com" <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> writes:
> Hi Roger,
>
>> From: Roger Quadros
>> Sent: Monday, June 20, 2016 7:13 PM
>>=20
>> Hi,
>>=20
>> On 20/06/16 10:45, Felipe Balbi wrote:
> < snip >
>> >> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> >> index f4fc0aa..1d74fb8 100644
>> >> --- a/include/linux/usb/gadget.h
>> >> +++ b/include/linux/usb/gadget.h
>> >> @@ -328,6 +328,7 @@ struct usb_gadget_ops {
>> >>   * @in_epnum: last used in ep number
>> >>   * @mA: last set mA value
>> >>   * @otg_caps: OTG capabilities of this gadget.
>> >> + * @otg_dev: OTG controller device, if needs to be used with OTG cor=
e.
>> >
>> > do you really know of any platform which has a separate OTG controller?
>> >
>>=20
>> Andrew had pointed out in [1] that Tegra210 has separate blocks for OTG,=
 host
>> and gadget.
>>=20
>> [1] http://article.gmane.org/gmane.linux.ports.tegra/22969
>>=20
>> Yoshihiro,
>>=20
>> How is the dual-role architecture on your Renesas platform?
>
> About the dual-role architecture, Renesas platform (R-Car H3) has a
> USB 2.0 host controller (EHCI/OHCI) with OTG function and a separate
> USB 2.0 peripheral controller (HS-USB).  The OTG function is related
> to some PHY control registers, so I intend to add the OTG/Dual-role
> core support into the phy driver (drivers/phy/phy-rcar-gen3-usb2.c).

that looks like a mux to me :-) thanks for the pointer

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaOrrAAoJEIaOsuA1yqRE5fAP/jXxU14GMCB7bMdXLtaewz9/
x4PaXQzVy0hTat2qiY7nU/hE9ziuatbDZfDRiCLFmPvVR9QF1pCPTU+RNkSd5iiY
5suleSvzoo8DWewojeRMBSDA2+7XWU785ktrb7l0XLHLtaTnNo2LnrbcYAPkGn2s
mn/8s0PElDihae3AlFef6Xp0426EWm9VZ8Eke5HOlvS5JJw3a02s3llpSeW3vrKr
KTphaVDbwNSf8gBtsyA0pNYJnKT6EEP8GKkXjg6CXuqXOb6mOeprSHJzzZ/LRc49
Fb5abyRZEGG98b5AS2y2AE3SQ6jau+FArN/rsclIc3uPKCkSh4vNRap8hTWZ3hJy
xQBTabd0Kfhe8/QClu6a0tUgMqrJ2LO27Nd7T7/MiGTrMISzDBJgBIeSjJ7a2Cd+
OOkTSKFS/23pdIryaouz2VY4oPJxewqFmcQQ4jMdZUyIravlQ+T5VE8wPXwqN8bJ
j5qSN3b+kaFfEOM3cFQ26+M7BFRqqsF0B2Fk2G2z6bTJqUNuiKWJ9MZjbuUhhjxt
lyDWWc0DXoj0F84usP6c4R3/vi56BZnTJYKRResB8bEp7h4OV5gaP8X8PyhQ6bKC
Ojyg5d+VlagdlfA5U1h6WETFShAjH+gS6Ec4yH23q+aMPkkh5Q/ADdJ9AUKSQFxN
W1dioIapEcJcLMHS+ntK
=/mPJ
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
