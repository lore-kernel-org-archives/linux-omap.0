From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: i2c issue on Panda with DT boot, v3.10-rc4
Date: Fri, 7 Jun 2013 14:53:54 +0300
Message-ID: <51B1C9D2.6060703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2JQAIGSFAVWNSCEQPBEDN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57325 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab3FGLx5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 07:53:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

------enig2JQAIGSFAVWNSCEQPBEDN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I was testing DT boot with 3.10-rc1 and Pandaboard, and couldn't get the
DVI output's EDID reading to work. Testing with i2cget and i2cdump, I
see that I can read individual bytes with i2cget, but using i2cdump
doesn't work, it just shows 'XX'es.

The same issue is there with 3.10-rc4, although with that one I get
timeouts with i2cdump, whereas there were no timeouts with -rc1.

# i2cget -y 2 0x50 0x10
0x0a
# i2cget -y 2 0x50 0x20
0x0f
# i2cget -y 2 0x50 0x30
0x01
# i2cget -y 2 0x50 0x40
0x36
# i2cget -y 2 0x50 0x50
0x4c
# i2cdump -y 2 0x50
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 [   72.814086] omap_i2c 48060000.i2c: timeout waiting for bus read=
y
XX [   73.825134] omap_i2c 48060000.i2c: timeout waiting for bus ready
XX [   74.835327] omap_i2c 48060000.i2c: timeout waiting for bus ready
XX [   76.097167] omap_i2c 48060000.i2c: timeout waiting for bus ready
XX [   77.160736] omap_i2c 48060000.i2c: timeout waiting for bus ready
XX [   78.174682] omap_i2c 48060000.i2c: timeout waiting for bus ready
XX [   79.194824] omap_i2c 48060000.i2c: timeout waiting for bus ready
XX [   80.242980] omap_i2c 48060000.i2c: timeout waiting for bus ready

i2cdump works fine with non-DT boot (but the i2c bus number is 3).

Any ideas?

 Tomi


------enig2JQAIGSFAVWNSCEQPBEDN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRscnSAAoJEPo9qoy8lh71dEgP/0t/zznzjzePwdWFb47n37yH
1Nwtk1khNi+1mYtfdDZUpFSMfegLprIQQbXIEWncy9mICZxAUiw2oMEtNUCEFYWW
7nIz/STR/ukMguPpYimi8h44aOgOy8r3Z5HZ+VwKV4slpVcHgqhMD2VB/ejryE3N
k9Sft7azD+IAeSWsAXP+NRtV97Y10V7XfnShh92PKJr2idPAaah57yD8uaIypCaH
FQyjo/2QnX8QoEUnl7B9bVtYf6+E5sIzoiHgw0aGJbh9tXeMhTlkh/k3CfdzkFoU
JKspFAE2a5dazqaD2t3deQE00N11P0WLcSe0jOHvAECuMRlKmUq3LnQD2GLBg2gj
7VuKHMeFmXvDSqiOkfY9TuO/2kQm/b+lVSopGO2bPz4CzL9EM7WPZAupdweSCC+/
jhRUieaWVshJR3wUyPNfuFzgC0Btym1ngJcl14e6FY/8vMWKzV4BYn8xO+OUEycn
z9XgialTQzcdePs/N7Pl6xkQHuXwvAz5SXCQU/gtqiBBQMrrE+qqTQwyS0p5LbCu
tb1g4qCj0/JQ5W+uoiFGLLh+kAbNlbBZepP/Va7pChdgKfkUb2ikK/Hm+tb5PpoT
SuBKakYe9y1Agli9RtponkvO63kp9Ybgl3dDFFq5Rdi0usAe6vFCn62BoZy6dC5e
czbUpEw4akUHP+lWD7lD
=b9gK
-----END PGP SIGNATURE-----

------enig2JQAIGSFAVWNSCEQPBEDN--
