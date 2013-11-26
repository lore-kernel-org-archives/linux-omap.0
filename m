From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: APPLY: set infos to dirty on enable
Date: Tue, 26 Nov 2013 12:21:14 +0200
Message-ID: <5294761A.7090904@ti.com>
References: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com> <1384779009-10512-2-git-send-email-tomi.valkeinen@ti.com> <5292A2AA.6090001@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dvmrP4TptnXPW4CHnPVatR1ltGGwxmVVU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51279 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746Ab3KZKVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 05:21:20 -0500
In-Reply-To: <5292A2AA.6090001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--dvmrP4TptnXPW4CHnPVatR1ltGGwxmVVU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-25 03:06, Archit Taneja wrote:
> On Monday 18 November 2013 06:20 PM, Tomi Valkeinen wrote:
>> Currently when DISPC is suspended, the driver stores all DISPC registe=
rs
>> to memory, so that they can be restored on resume. This is a bad way t=
o
>> handle suspend/resume, as it's prone to failures and requires somewhat=

>> large amount of extra space to store the registers.
>>
>> A better approach is to program the DISPC from scratch when resuming.
>> This can be easily accomplished in apply layer by setting the manager
>> and overlay infos to dirty when the manager is to be enabled.
>=20
> I guess this won't work if we wanted to support DSI command mode
> displays. I.e, only shut DSS off and keep the panel up. In that case, w=
e
> would need to mark the flags dirty in dss_mgr_start_update_compat().

Hmm, true, I didn't try with DSI command mode panel. But I think it
should work. The DSI driver should call mgr->enable before update, if
the mgr has been off.

 Tomi



--dvmrP4TptnXPW4CHnPVatR1ltGGwxmVVU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlHYdAAoJEPo9qoy8lh7115AP/3VLzCI7JknAo3zMNEXdQKdX
s4snC31S7sGXL84jkQ9F7mngtS5hxiioO0Zltlg9BmX4+b3VFoBwy9NbVNBeIuxT
TjyyxrDC1fY+F+3WXOM4Zkjwm6N9Mw9cQ88v7WkU+WuB3W0Oc8Ytd9SD2e4UtJ0F
8bJYpO+x7iixq5NZdOCh6hORZn7TRys+Q2hT2iq48B0FV4Fwk5MhiL6QKey5v05n
GSaexKuwZQJ9iErMF8f9fkp90/qqloxN74vp5fywkJfiRvrPZfmA2tA82EH1QO3Y
D4aV+SV62V+CamfNHooS7hE+Wt9vXSlWv/IEB2THoVi3FU141iHZSNt7EcmbMNsG
lZ8bmLUAc9yXSJZAe1ud5nJyR4BUlTgGlPeLnLKe+Xw+Ysr9xYAF0ox71Q6+DX5U
v1O3vAPHtxBSG+tgI/41jaxWMJOm8xcCTGu4KyvpduzFvw8X6qJUX41raiXRvXy/
XID3zfCfvMx4TK302u4ds09AWYFvMX4e5ZiP00r44mk0ix+Pi4NL7jJdOlZ67xGL
SXMZjR5v9eIC37MI17kFndCRXSGk/78Cf+9w35rAXscJMInb2w4NsEkC6NjjEF7a
o2pA1JP10MO6bhclXnBmQuei2RBi7c4gYtUUPuVer/bRQUI3b6r/zXreO+888JsZ
ckWFktxeqdZ8RpYPARlh
=hciR
-----END PGP SIGNATURE-----

--dvmrP4TptnXPW4CHnPVatR1ltGGwxmVVU--
