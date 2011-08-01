From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: ISP
Date: Mon, 1 Aug 2011 13:55:13 +0200
Message-ID: <201108011355.13993.laurent.pinchart@ideasonboard.com>
References: <CAOO8FEcnGxf-2xKbpVrN2e4CfgPZ0VgSOoO+dJthNa+8ZaYKPA@mail.gmail.com> <CAORxB+CeQcgR-9eEvUokS2k7snKNp48EciKCNWs=eGKfeZMGzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:52348 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab1HALzG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 07:55:06 -0400
In-Reply-To: <CAORxB+CeQcgR-9eEvUokS2k7snKNp48EciKCNWs=eGKfeZMGzA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?q?=E5=8D=9E=E7=A3=8A?= <mykofzone@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wednesday 27 July 2011 04:02:01 =E5=8D=9E=E7=A3=8A wrote:
> 2011/7/26 Veda N <veda74@gmail.com>:
> > Hello,
> > For developing camera sensors drivers which kernel source
> > and isp drivers sources have been tested and i need to use.
> > And from where i can get them.
> >=20
> > this is for omap3
>=20
> http://code.google.com/p/rowboat/wiki/Source
> there's omap3cam master driver and ISP driver in rowboat kernel.

Please don't. That's really old deprecated code. You should use the OMA=
P3 ISP=20
driver found in mainline.

--=20
Regards,

Laurent Pinchart
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
