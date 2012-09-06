From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] musb: Kill __init from function that are called at other
 times as well.
Date: Thu, 6 Sep 2012 20:41:41 +0300
Message-ID: <20120906174139.GF30717@arwen.pp.htv.fi>
References: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com>
 <20120906130425.GF29202@arwen.pp.htv.fi>
 <B7BE7E99-90E8-4E54-B146-C09C6643BAFE@antoniou-consulting.com>
 <20120906170740.GB17754@arwen.pp.htv.fi>
 <7CED20FA-3501-40ED-B289-28FDC04FCF20@antoniou-consulting.com>
 <20120906173724.GE30717@arwen.pp.htv.fi>
 <5607ED12-1C7D-4455-A716-F611B747BADF@antoniou-consulting.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:40604 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759371Ab2IFRqF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 13:46:05 -0400
Received: by lbbgj3 with SMTP id gj3so1317723lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 10:46:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5607ED12-1C7D-4455-A716-F611B747BADF@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, Russ Dill <Russ.Dill@ti.com>


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 06, 2012 at 08:42:56PM +0300, Pantelis Antoniou wrote:
>=20
> On Sep 6, 2012, at 8:37 PM, Felipe Balbi wrote:
>=20
> > Hi,
> >=20
> > On Thu, Sep 06, 2012 at 08:36:39PM +0300, Pantelis Antoniou wrote:
> >> Hi Felipe
> >>=20
> >> I see about __devinit.
> >> There's no crash because in those logs the __init modifiers are gone.
> >=20
> > it'd be cool to see the crash, though ;-)
> >=20
> > --=20
> > balbi
>=20
> Heh, OK,
>=20
> My word is not enough? :)
>=20
> Gimme a few minutes...

Didn't say that, but I don't know what issue you're talking about since
__devinit is supposed to keep .devinit.text intact unless !HOTPLUG.

This could be a bug on some linker script (though unlikely) just trying
to get understand the issue before I apply the patch, that's all.

--=20
balbi

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSOBTAAoJEIaOsuA1yqREnkgP/3LVY1g2V/AMXZ3JdsqAwqJY
lztoiyMnkz0rpddZS+rv4jAjvpjFAm0a6BShj4cSVhpNxam80KkFPUnSxQLyjODB
SpOm/0oBqpN/XYgoSu3aNNs3RIE1OCBFT8imunjHcMpivqQ2T4CkcGyW4qDLiIov
5DYgiSPc5Y6amoQUfVFhZBhhuMohlPD2XoO/oQPzTxhVo6fhdyOYNOMvpQeN7nw6
f+JexzX0J3yC7tznnXLX3KHWgQfLKwl2wpo28GaNUXRvQdkhosRNZztcUsG6vy/S
tvX5QfeO4m/76Kk0jNxw2o5i/31k/BKXAu0m7p0E2JDySVOZtFIsh7Ifpq6rDWeu
t6LxHwSq2JHxytGGzjeUuvVlyG37/3ju05CN2AzGJNYAKy+BUP9HrpgL3g1sByXt
PoEoTJkEsQxfraMubh0wJWKj6ePWOuAea9LKJiunOUvzdJK13q2ALiQY3W7BVMuE
c5Jj9Nnknv8JA1LJOu4qe0z4z/2eoJRa/cPMTuI+buKqwHD2HHgchZ2L0OpC+bAC
QeBMFqHw14k3SmTzFgcxpg5tdovlEtLKqrxfWX+MccerGxDrNZa/Y5B1mzEFMcwT
sgOLN69Tpr3pIwdjWchO3aOC3g9bCe//j0x9CFKmV5DEuEZURINhHFxzbqP7ddqr
cZmb+uc7sweaUQwZ11QB
=fHHi
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--
