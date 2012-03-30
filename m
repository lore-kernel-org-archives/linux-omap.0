From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: OMAP4 errata i740
Date: Fri, 30 Mar 2012 11:07:42 +0300
Message-ID: <1333094862.1932.15.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cab10715fa004bc7169a4
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:39058 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759033Ab2C3INP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 04:13:15 -0400
Received: by bkcjg9 with SMTP id jg9so292245bkc.32
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 01:13:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

--0015175cab10715fa004bc7169a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I just found out about OMAP4 errata i740:

DESCRIPTION
A bug has been identified in the interconnect agent handling the connect-di=
sconnect protocol between an
initiator and interconnect. When the disconnect protocol violation occurs, =
there is a dead lock and a
system lockup is observed.

The issue can occur in a corner case when the impacted module has started a=
 transition to standby, for
the L3 initiator on which it is attached, exactly at the time the initiator=
 gets an event for exiting idle state.
Such a situation can occur when the impacted initiator is generating short =
MStandby pulses (pulse
durations less than one L4 clock cycle).

DSS and ISS are the only initiators that are impacted.

WORKAROUND
L3_CLK1 must be kept in NO-IDLE when the DSS clock domain is ON. It can be =
switched back to
HW_AUTO when the DSS clock domain is IDLE.

L3_CLK2 must be kept in NO-IDLE when the ISS clock domain is ON. It can be =
switched back to
HW_AUTO when the ISS clock domain is IDLE.


All OMAP4 versions seem to be affected. I couldn't find a mention about
this in the mainline kernel. Any ideas how and where this should be
fixed?

 Tomi


--0015175cab10715fa004bc7169a4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPdWnOAAoJEPo9qoy8lh71ClEP/juoXB+6gDMljXrh1ldBXgHJ
Dw7byxnnUkiSrn3mls8/7UDwSD3tZM+Auusn7YKMR3bds9TTSIEElB0rb6j0FPXo
QK31v4qUCYf5dHmjaQUiAV3XLLncOhBPqeNLdvo6R8yAel2vGoX/UJ8Xi9ZpHU85
CssLanRoS9kKd4SozL7oAP27oW+am2pvix5xIWhFEQfhvTsP7l+HAOTgHBW1pKVR
8UThXz/Ru1IFVA7DaImoBpaFqmIAx+5In8ywUc0ytWpXfHEZCirieygiNR7wPOQb
4O1d0buQ6NC/VGs9VvbZd4lRBO9dTMxCa4daguCF7Pg5XDLgOffP893glK2LJbBA
5t+Vt0JJXvlG628An5Nj94lZDiXkHI8X4sHt/3GNAT9UvowHX1+kpTufmzWHzGY1
F0wkToDWMBgtNo0JsnTTAeBN1T5hdJDvoCD8HatY/M7R2xs/SHBZuxXzyi52st0G
KVPXttk85Hh7pVcW6rPzsaxrUrlcJcavD9hqSgiL+gtpPufYtqUf4AJRcqKa3HEq
htr7kBxemNADEdwkBfSYCV3mvc/vgbD3xrqSDZrhuBuajPwSWu7UhEc5gMHbh908
4TNtmEAYaAlAMpgRgp/IlDOc7uWjcCVJSX4en4uPPzZf1X7a73wZ6KgHhFPIT8tp
07yQ7UWDv+u8+Cv4Uhxw
=rO6s
-----END PGP SIGNATURE-----

--0015175cab10715fa004bc7169a4--
