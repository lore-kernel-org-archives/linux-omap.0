From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] musb: Kill __init from function that are called at other
 times as well.
Date: Thu, 6 Sep 2012 20:07:41 +0300
Message-ID: <20120906170740.GB17754@arwen.pp.htv.fi>
References: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com>
 <20120906130425.GF29202@arwen.pp.htv.fi>
 <B7BE7E99-90E8-4E54-B146-C09C6643BAFE@antoniou-consulting.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:51725 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932400Ab2IFRMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 13:12:06 -0400
Received: by lagy9 with SMTP id y9so1259149lag.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 10:12:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <B7BE7E99-90E8-4E54-B146-C09C6643BAFE@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, Russ Dill <Russ.Dill@ti.com>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 06, 2012 at 05:58:27PM +0300, Pantelis Antoniou wrote:
> Hi Felipe,
>=20
> A proper answer required some instrumentation printks().
>=20
> So what I did is that I peppered each function marked with a removed
> __init or __devinit with a=20
>=20
> > printk(KERN_INFO "%s:%d (%s) %s\n", __FILE__, __LINE__, KBUILD_MODNAME,=
 __func__);
> >=20
>=20
> Both omap2430 & musb_hdrc are compiled as module, and I issued the follow=
ing=20
> commands on a beagleboard xm.
>=20
> # modprobe omap2430
> # modprobe g_mass_storage file=3Dbacking_file
> # rmmod g_mass_storage
> # rmmod omap2430
> # modprobe omap2430
>=20
> The problem is obvious when you see that functions marked as init or devi=
nit are
> called when re-loading the omap2430 module again. Those functions if mark=
ed as
> much can (and will as I have witnessed) be removed from memory, leading t=
o a=20
> crash.
>=20
> What do you think?

the problem would be with usage of __init. __devinit will only drop
=2Edevinit.text if HOTPLUG and MODULE isn't set, AFAICT. I also can't see
a crash on below logs.

--=20
balbi

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSNhcAAoJEIaOsuA1yqREsFkQALK1YoKldw+1xrEQ1TyIEghH
cxA0SFFMDHDUsvod4ObRb068x0egrBfDnKhvWq+SgDxJqPHFhuO7hv85iBjMBW1J
MlFU2RodOodnWo1TlnVZe+dxhosQftkzNuK5GCO9yf0cB7jAu9LS34PGidmfdrEp
0CzV+FN8onIEczEHVepuE5VqSE6t51TUjh+r50DGGSojEIW2fycMmGJtPSZEDq+Z
oLbH5kRGOMj7SBST2kfMve12OV0QMZaxEchMexWcZSJLXheAu/YEu9TtREej2+R/
Sad9Mf7p28/VnACNFPjThrU4UvEwgdcOkni8y38UDy6ZajJnwwj2W4MHPvidH4sS
T/by5mA+qJXdlzPoyILJWxyEvTtOjhXxjYBDosGOBku8GL4G5xKqmWqqu+NmWNsq
QC4Z1ipDjDtM593Ucn0jvY1qDtso+lJDmEqzjVbzmBzYXAln1TLyqS8UIoOKwDMd
T8vEk3MlukNml4kbJo76N/TnPEkMyAGmh4vq85xRfREUZcptTCyuX3uISnOQiCPi
cBLumQvpqzZ2hWmzMrsuo54qq9iOfKfd8KF2E5njhjMR5YR7slw3B+q30nZyMbLF
7WcIB7gIHKwWA8Xh/bGKVFt1HbTpzAeycUG+HD/JtDWzJCFM6qF2TZ6+w11sBwZn
8OjSLtbhLfwtOTpIbFl0
=abED
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
