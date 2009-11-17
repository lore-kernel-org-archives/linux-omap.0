From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: Doubts around SoC audio on omap3
Date: Tue, 17 Nov 2009 11:13:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8EA7@dbde02.ent.ti.com>
References: <70c9a9110911160935o7b8e4993tf8bcc1c1ec615786@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54732 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbZKQFnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 00:43:06 -0500
In-Reply-To: <70c9a9110911160935o7b8e4993tf8bcc1c1ec615786@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Enric_Balletb=F2_i_Serra?= <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Enric Balletb=F2 i Serra
> Sent: Monday, November 16, 2009 11:06 PM
> To: linux-omap@vger.kernel.org
> Subject: Doubts around SoC audio on omap3
>=20
> Hi all,
>=20
> I would like to add support for SoC audio on the IGEP v2 board but I
> have some doubts about how to do. As I have seen in the source code,
> the SoC driver for IGEP should be the same as omap3evm, overo and
> cm-t35.
>=20
> So, is better to use the solution adopted by the board CM-T35 or add =
a
> specific file for the board IGEP like omap3evm board ?
>=20
> Is there any difference between the omap3evm driver and the overo dri=
ver ?
Including alsa-devel list too...

There could be changes in the machine drivers for different
OMAP3 based platforms like omap3evm and overo. It depends on exactly wh=
at is
present (I/Ps, O/Ps) on you EVM and how do you want to configure it, an=
d in
that case, it makes sense to create a new machine specific file for you=
r board.
>=20
> Thanks in advance,
>=20
> Enric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
