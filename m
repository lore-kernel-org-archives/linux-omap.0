From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH] usb: dwc3: ep0: Fix mem corruption on OUT transfers
 of more than 512 bytes
Date: Tue, 9 Jun 2015 12:16:50 -0500
Message-ID: <20150609171650.GC18072@saruman.tx.rr.com>
References: <5576FBBA.4000905@ti.com>
 <Pine.LNX.4.44L0.1506091057100.1324-100000@iolanthe.rowland.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40090 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbbFIRTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2015 13:19:12 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1506091057100.1324-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Michael Trimarchi <michael@amarulasolutions.com>, Felipe Balbi <balbi@ti.com>, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2015 at 10:59:50AM -0400, Alan Stern wrote:
> On Tue, 9 Jun 2015, Kishon Vijay Abraham I wrote:
>=20
> > Hi,
> >=20
> > On Tuesday 09 June 2015 08:09 PM, Michael Trimarchi wrote:
> > > Hi
> > >
> > > On Jun 9, 2015 4:36 PM, "Kishon Vijay Abraham I" <kishon@ti.com
> > > <mailto:kishon@ti.com>> wrote:
> > >  >
> > >  > DWC3 uses bounce buffer to handle non max packet aligned OUT trans=
fers and
> > >  > the size of bounce buffer is 512 bytes. However if the host initia=
tes OUT
> > >  > transfers of size more than 512 bytes (and non max packet aligned)=
, the
> > >  > driver throws a WARN dump but still programs the TRB to receive mo=
re than
> > >  > 512 bytes. This will cause bounce buffer to overflow and corrupt t=
he
> > >  > adjacent memory locations which can be fatal.
> > >  >
> > >  > Fix it by programming the TRB to receive a maximum of DWC3_EP0_BOU=
NCE_SIZE
> > >  > (512) bytes.
> > >  >
> > >  > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com <mailto:kisho=
n@ti.com>>
> > >  > ---
> > >  > Steps to see the issue (before this patch)
> > >  > 1) Insert g_zero in DUT
> > >  > 2) run './testusb -t 14 -c 1 -s 520 -v 1' in host (size should be =
> 512)
> > >  >
> > >  > The test should FAIL since bounce buffer can handle only 512 bytes=
, but the
> > >  > test PASS. There is a WARN dump in DUT but still there will be mem=
ory
> > >  > corruption since the bounce buffer overflows.
> > >  >
> > >  > Tested this patch using USB3 Gen X CV (ch9 tests: usb2 and usb3, l=
ink layer
> > >  > testing and MSC tests) and using USB2 X CV (ch9 tests, MSC tests).
> > >  >
> > >  > After the patch, the tests timeout!
> > >  > ./testusb -t 14 -c 1 -s 514 -v 1
> > >  > unknown speed   /dev/bus/usb/001/018    0
> > >  > /dev/bus/usb/001/018 test 14 --> 110 (Connection timed out)
> > >  >
> > >  > IMO a patch to fix this is required for stable releases too. So If=
 this
> > >  > patch is alright, I can post the patch cc'ing stable. While the ac=
tual fix
> > >  > would be to have chained TRB, I'm not sure if it can go to stable
> > >  > releases.
> > >  >  drivers/usb/dwc3/ep0.c |   12 ++++++++++--
> > >  >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >  >
> > >  > diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> > >  > index 2ef3c8d..8858c60 100644
> > >  > --- a/drivers/usb/dwc3/ep0.c
> > >  > +++ b/drivers/usb/dwc3/ep0.c
> > >  > @@ -816,6 +816,11 @@ static void dwc3_ep0_complete_data(struct dwc=
3 *dwc,
> > >  >                 unsigned maxp =3D ep0->endpoint.maxpacket;
> > >  >
> > >  >                 transfer_size +=3D (maxp - (transfer_size % maxp));
> > >  > +
> > >  > +               /* Maximum of DWC3_EP0_BOUNCE_SIZE can only be rec=
eived */
> > >  > +               if (transfer_size > DWC3_EP0_BOUNCE_SIZE)
> > >  > +                       transfer_size =3D DWC3_EP0_BOUNCE_SIZE;
> > >  > +
> > >
> > > Can you just use maxp in the correct way?
> >=20
> > what do you mean by correct way? Using roundup() to calculate transfer_=
size?
>=20
> Why not just make the bounce buffer size the same as the maxpacket=20
> size?  In other words, 1024 bytes instead of 512, for ep0 on a USB-3=20
> device.

EP0 max packet size is 512 on USB3.

--=20
balbi

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVdx+CAAoJEIaOsuA1yqREB8gQAKgLqa6bKPZHJBSzNkLisagT
nm6hxcGcYH4eGMZWnfvw4JjDXEcyly4a1kZCl4Ttg3G0tqRQHZIFLnaHLxymn4ST
jdO/2jXtzAURS11aTsp7CarkWBTzGbeks6I95JUiNwba1EjQByupjyXT38IA38L3
RbWGtYpMQFUFAkn8sid8ynTbj4xJ1ORzZzoonMHCmW/VMIarCaaJXNWO2eMoW/Mr
2Saxzxw9LYeHwMubV6w02gomeUEmvzz5rAhjG52Ucox3rNjfhklIK3jcmX5HQt+a
X5+kBXqTMCPxKMhOKi7F6FXmLJyDhhW/WL1EyA9eDPVHJx0gFG5R87e5GS1VH+fZ
FIVCoqev1PnCruvxZ/2vT3PHioPlAn9Mih9JcvQVKFtxaEZ4fH6ZEUFamt9No07K
tTXZaW8nZTEqmWXvv/Tk84dv2xffOEMwB1VTaZRoLYvDrtX3VUFVHHXq6CnE53WX
wQzwLQVqewHINdOMQwWn2mohedUnGmoimIhWoeG9Y/3O1YzbAMSgZOaUAOAmhq4n
TucsgY6dM4hFe1VHAZO1eW5eg1asE3owA1zSMMHtyqg6AdTqogknf9vKPL9HN8gk
WlHNUIDAPxs7fKM1gpDsQ9GqSSgE60ASOl4AD96wSb8IgT7iAGRxCnRuPlBn4vYd
nELg7pA0k9j1l0YhdkiP
=DD74
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
