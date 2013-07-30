From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] arm: omap: remove *.auto* from device names given in
 usb_bind_phy
Date: Tue, 30 Jul 2013 11:15:20 +0300
Message-ID: <20130730081520.GH16441@radagast>
References: <20130729175413.GC4964@radagast> <51F74BC8.7020903@ti.com>
 <20130730060134.GD9155@radagast> <51F7590B.4020705@ti.com>
 <20130730061830.GE9155@radagast> <51F75C40.4060406@ti.com>
 <20130730062844.GH9155@radagast> <51F7613C.5070803@ti.com>
 <20130730071611.GD16441@radagast> <51F7752B.8050804@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4714210123760949033=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F7752B.8050804@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, eballetbo@gmail.com, javier@dowhile0.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============4714210123760949033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline

--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2013 at 01:41:23PM +0530, Kishon Vijay Abraham I wrote:
> On Tuesday 30 July 2013 12:46 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Tue, Jul 30, 2013 at 12:16:20PM +0530, Kishon Vijay Abraham I wrote:
> >>>>>> the list of controller device (names) it can support (PHY framewor=
k does not
> >>>>>> maintain a separate list for binding like how we had in USB PHY li=
brary). e.g.
> >>>>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92817.ht=
ml. In such
> >>>>>
> >>>>> this has nothing to do with $subject though. We talk about generic =
PHY
> >>>>> framework once all these PHY drivers are moved there :-)
> >>>>>
> >>>>>> cases how do we pass the device names. Also will the MUSB core dev=
ice be
> >>>>>> created before twl4030-usb PHY device?
> >>>>>
> >>>>> and why would that be a problem ? We're telling the framework that =
the
> >>>>> musb device will use a phy with a name of 'twl4030'. If musb calls
> >>>>> usb_get_phy_dev() and doesn't find a phy, it'll return -EPROBE_DEFE=
R and
> >>>>> try again later.
> >>>>
> >>>> I think we are talking about different problems here ;-) I'm trying =
to tell
> >>>> using idr in MUSB core is needed for Generic PHY Framework. So in a =
way, the
> >>>> Generic PHY Framework series depends on this patch series or else MU=
SB in OMAP3
> >>>> platforms wont work after Generic PHY framework gets merged.
> >>>
> >>> then you just found a limitation in your framework, right ? :-) I mea=
n,
> >>> imagine if now we have to add an IDR to every single user of your
> >>> framework because they could end up in systems with multiple instances
> >>> of the same IP ?
> >>
> >> I raised a similar concern in the PHY framework discussion [1] :-) And=
 since
> >> it's used everywhere else regulators, clkdev, etc.. it's agreed to be =
used in
> >> PHY as well. Btw if PLATFORM_DEVID_AUTO is used even regulator, clk_ge=
t should
> >> fail IMO.
> >>
> >> [1] -> http://lkml.indiana.edu/hypermail/linux/kernel/1307.2/03573.html
> >=20
> > look at Greg's and my reply to that email.
>=20
> but finally Greg agreed to what Tomasz proposed no?

that's not what I see in the thread. I see Greg agreed to regulator's
own IDs being sequentially created, but he mentions device names can
change.

--=20
balbi

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR93YXAAoJEIaOsuA1yqRE2dgP/1ub6lcQOcC0FymtHYNtY0UM
iw5h7oeHKB+R09SmfF3Z5iEGv9gwPSp32gspFeFSy4mvtvQfjQlwNjEeUZQEsZhX
yZ3DHYkkAyOVXIr6IWZp2lvVVOuimj0W58ddUFQqEeV4L6SlP7GVKrYpENdwGz4o
CuG7ykx3GfGiscJFgWT8SlMCmo6PosLT6yf+eXo6Ta+YNPlqvmQmwgbeJqmZjWF/
D/1F/GoMviBKGW/wifsf0phUCfpHP8lkc6WTb0fDOXkdJtmq6DKnuiqJr7woeZZr
bCz85DhKIOCrRcMbNtoqFqStJ/BYvJwebTL3rolNRggM8zmQV3M9RspkqW/2QP3B
RSPEsLMhOdyJrhcheqCHZF4CjgT9amPKlQ/5lAjGiBMykfN9p73xfk0JmmILk6MK
WKDbj3Lh2jQvSLnFSLdDizun5RkuO+F1t1oLx4PeKfAeBaKpCWseEctlnJR/iBAR
vu7DLOsrDfLN11Ot5D4dGxiBToBQFhhDhxiOuMzQ24ajV83fyjmI2Pqan11LVVwh
NhApUt3nYWkYP+D+7Wgpzq6kE/5DK0IhRvyXVMHG49pYxFCqv21paoo9NgFr2bYx
2sA15RBNgEoDQdKDgKZC6VMPg8wWVZ71uBdnVXFyB6gRh4eCHaLCYECLlsySKZax
q2sWhY4fzN4sxbcuAXlK
=XK1L
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--


--===============4714210123760949033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4714210123760949033==--
