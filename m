From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 0/7] usb: phy: twl4030-usb fixes
Date: Wed, 20 Mar 2013 14:54:25 +0200
Message-ID: <20130320125425.GQ29659@arwen.pp.htv.fi>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aJ74fq0Y6SrIeKCM"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1363544607-17634-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--aJ74fq0Y6SrIeKCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2013 at 08:23:20PM +0200, Grazvydas Ignotas wrote:
> I have a pandora board which has similar musb setup to beagleboard
> (OMAP3530 + TWL4030) and musb never worked well on it for me in mainline.
> Well it usually works if you plug the cable once, but as soon as you start
> replugging cables and mixing host adapter into the game it totally breaks
> and reboot is then needed. Host mode is especially broken, any replugs
> after musb has been in host mode result in dead port that needs reboot
> to recover.
>=20
> With this series I can switch host/peripheral cables any way I like and
> even suspend works with cable plugged with musb in peripheral mode!
> ("ARM: OMAP3: hwmod data: keep MIDLEMODE in force-standby for musb" is
> needed that was sent separately). This also fixes power drain when cable
> is plugged an no gadget driver is loaded.
>=20
> Changed since v1:
> - rebased on Felipe's testing branch
> - added locking for patch 4 to take care of possible races
>   between work item and IRQ
> - changed patch 6 to only disable VBUS if not runtime suspended,
>   otherwise we get data abort on OMAP3
>=20
> Grazvydas Ignotas (7):
>   usb: phy: twl4030-usb: don't enable PHY during init
>   usb: phy: twl4030-usb: ignore duplicate events
>   usb: phy: twl4030-usb: don't switch the phy on/off needlessly
>   usb: phy: twl4030-usb: poll for ID disconnect
>   usb: phy: twl4030-usb: check if vbus is driven by twl itself
>   usb: musb: omap2430: turn off vbus on cable disconnect
>   usb: musb: gadget: use platform callback to enable vbus

since this falls into "has never worked before" I will apply them for
v3.10. If you have any objections, let me know.

--=20
balbi

--aJ74fq0Y6SrIeKCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSbGBAAoJEIaOsuA1yqRET6EP/2FMviDh3nvh51BMyFfluLSg
Kl1uUHsaPT32LVtXhNgPhYhF8Uvzrj4g82wbQWhtyMWs9Z92fIbwwfk5nzUESKf5
6LHaLb8BoY7KEmfSPL81ijOSNEuzO442B3UE/i4NdSKNF+vK5adQrmNd9+4z+W01
v96k1T+MPevfuX/KfxcVpPVWenj36hzo9uNSQp40FGyq+NmIcx/LV8tcdJZWH2mj
DsGFNQNDzb1yhZvXvL0egHYlylMacYBAmHNGUDVgHgUtLX3VdUN+IkQ87j2QWRAj
EoObia5VmERlH1ZI2HmB8XXZhQkQl12TO3dST2EQCztCjqfrr7MjMRF6MEWwwcIA
EqJT1R5l3guK4EWFTi52Xa+JVgX0/Qas3ANuSc0p/oLB+FkV4mfu8oNu1GI6Bwsj
xVpINoOkQlO/9+sByTwjSVSWQGCFU9rJjvfw2nFLOWreqj65pE6gy9136JVlln81
sbHG/utCmdf7tDJtwzr/pZjUb38+4sa5gjPcYeQ9X0zOfoqgqYJ1lZDwxI0e/VHN
tQz5jHN6uRnjQV1Zf3kf+lMJWBGM5q5LDYAwy2FI9Wn/ljrak7VLZfuXFxRDWWIK
R5l5VIQUCRPy06OUrIpr8Bs3jueid+g+P9VgcahAY41xfl3yVtW1C0F6bcy50ywd
SKrnbNu8y9x8hwBw3gdH
=z914
-----END PGP SIGNATURE-----

--aJ74fq0Y6SrIeKCM--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
