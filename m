From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC 00/14] Add DT support to OMAPDSS
Date: Wed, 27 Mar 2013 12:39:16 +0200
Message-ID: <5152CC54.9020101@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
 <5152BEB7.4060804@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5184450441306829919=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5152BEB7.4060804-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Andy Gross <andy.gross-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============5184450441306829919==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1C999AE7AF7A0EDE31D01CE8"

--------------enig1C999AE7AF7A0EDE31D01CE8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-27 11:41, Benoit Cousson wrote:
> + mturquette and Rajendra
>=20
> On 03/27/2013 09:45 AM, Tomi Valkeinen wrote:
>=20
> ...
>=20
>> * ti,dsi-module-id
>>
>> There's a ti,dsi-module-id property in the dsi node. The reason for th=
is
>> module-id property is that we have muxes in the dss_core that route cl=
ocks
>> to/from a particular DSI module. So we need some way to index the DSI =
modules.
>> Another option would be to have a list of DSI modules (phandles) in th=
e
>> dss_core. Both options feel a bit wrong to me, but I went for the modu=
le-id
>> approach as that is already used when not using DT.
>=20
> That's not a very nice representation. Ideally you should expose 1 cloc=
k
> node per DSI node, and enabling one will select the proper mux for you.=


Afaik, we need the DSI module id for the following things:

1) DSI pad configuration (OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY).

2) Setting clk mux in dss_core to select input clock for DSI protocol
engine. The choice is between DSS_CLK from PRCM, or clock from a DSI
PLL. DSI1 module can only use DSI1 PLL clock, and DSI2 module can only
use DSI2 PLL clock.

3) Setting clk mux in dss_core to select input clock for LCD/DISPC. The
choice is between DSS_CLK from PRCM, or a clock from DSI PLL. DISPC can
use either DSI1 or DSI2 PLL, LCD1 can use DSI1 PLL clock, LCD2 can use
DSI2 PLL clock.

4) Selecting the video output from DISPC which is routed to the DSI
module. LCD1 output can go to DSI1, LCD2 output can go to DSI1 or DSI2.

All the above of course change between OMAP versions.

So managing all the above was easiest with a plain module-id assigned to
the DSI device.

I guess 1) could be somehow managed by having separate nodes in the dts
for the DSIPHY control, and a link from the DSI module to that DSIPHY nod=
e.

4) could possibly be managed by having each DSS output node having a
list of possible inputs from the DISPC. And, I guess, a link somehow to
a mux node in the dss_core. Or something...

All in all, I don't have any clear idea how these should be handled.

 Tomi



--------------enig1C999AE7AF7A0EDE31D01CE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUsxUAAoJEPo9qoy8lh71kUsQAKBjal0Bb3CVYzWbi5QyFlUh
HvnBSvCr0ByDSwzVbCPsbUAGfSqcJgxEn0/LbcRcvxUx6ysnzjS3arq1eoo0ckBt
MO3kQhZ8yFIm+ASkLZvoigcZC6a+pvx/wMt5Crp9esysyn/Ls0l4UFklzgUHf4WC
TzFg01Lr4gsOCTOipLxx4h5jy3cHYME8d2iBUS9TzUtVhxFY9rbXTcokviuC3RSG
x+ht0ImyVEhaN7VgdvlEK57VIhpyAy/UkJY/TjCD/CrvqvXCZe0aFSrnrbXVw4It
A/MFeo0ILeLq+noj73s31E1LqZ4q55zttPfyzMuOOfgsUJHvG2JZs0CP54IuRLTT
Vcwcu0QZRubIn1ZBYOfLk5HBvqaC7TkepasMdO8nbKApsCUG964mxbgV4QC1nv2C
TGKNlke0/r4rm64bOub2cECK+B57iK1XuYd8VynNHMTYxtHZjGXq0PztkFDeK7S4
0K++QfgqrwQ1rxr/ScFZMxWwARAuv/QO2JR4ZfZz9XEmMkuqY62xgQbFHwGLhrS1
BlKAyvfr3M8WM8de/De4BVQgI9FQ0Ekrw01C4ipjUu+o0H0ZJJUdX7iihNlnf7o/
ojZYppGAAarPbJEObkj3iZigYSUOH+DgjtvqxLr2GQPGyOBmQwV4i6BUWHQsC+Kb
J3eFktP6t0mi8st+c7NU
=oc/b
-----END PGP SIGNATURE-----

--------------enig1C999AE7AF7A0EDE31D01CE8--

--===============5184450441306829919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5184450441306829919==--
