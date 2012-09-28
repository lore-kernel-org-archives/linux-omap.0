From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/6] usb: dwc3-omap: use of_platform API to create dwc3
 core pdev
Date: Fri, 28 Sep 2012 15:57:59 +0300
Message-ID: <20120928125758.GK31006@arwen.pp.htv.fi>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
 <1348836795-4783-2-git-send-email-kishon@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348836795-4783-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 28, 2012 at 06:23:10PM +0530, Kishon Vijay Abraham I wrote:
> Used of_platform_populate() to populate dwc3 core platform_device
> from device tree data. Since now the allocation of unique device id is
> handled be of_*, removed the call to dwc3_get_device_id.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

I think it's best if you split the use of device_for_each_child() from
this patch. So first do the device_for_each_child() part, then later use
of_platform_populate().

--=20
balbi

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQZZ7WAAoJEIaOsuA1yqREvicP/iSiSRqKzYixvbs41pSk/vLs
ePMUi2ckZkFwsijxkUAJxARc4La2SU6cgIdjSv/6HnZS9UwOtMGWzEo3yt5h5IQ7
/8gHdvaBweQQV7eI3/lHfDGNhmbJxvWaXbhT9g/puQM+VPNZMNkgUaPQNZeEDjFA
49idLXJtwZ2WuunvsyzgUNeiX3PE5uM9C9d358YYhkdtPqr+CDokEK7cM8BcMgxN
JbFfrwp25npfYRYbZdSlLnrQZI0CrpeWp5W5kw25h5ATw+W+xjywNnKu2EAmG5rZ
xnRmeFCgcT1yB9hvX4wJ5/IOMNBN8vSNakq9JslIYbl04tiA+RxoBzI5wg/zMsAI
PscGICKm6LVHQx94uep20gWe7zn96/w3HWUNWi2Es7lvvml4ms52Dkbhu2TcNEXM
j4KbKUxiL+WBpJ6skdtAAkabouqDYIK9abhIcDlgHHIkhRMerYG6T9ZWI5IAwBeM
NdDkm7yLZPiP9cAAP9jDrZD9S7tgHmzmTHlpegp4g4mtaExCN9tjQMAiIl5O8rAC
6d6yBU6N5zVWMdKDJEIDMi1zit6FiwLCy18cHNjr6VMSJLnxC1JI8lex0Vq1xDNe
fR9yP3eAqFrMqvPQRo9/CDRAFXD1Jd19mAMrxK75l3Rov4pnYxa8yGX69lv2/Kfh
Zt4+HMxpjhn8BMR2CF3b
=HZuv
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
