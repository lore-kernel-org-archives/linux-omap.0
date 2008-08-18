From: Artem Bityutskiy <dedekind@infradead.org>
Subject: Re: [PATCH] [MTD] OneNAND OMAP3: add delay for GPIO
Date: Mon, 18 Aug 2008 15:36:43 +0300
Message-ID: <1219063003.18027.5.camel@sauron>
References: <48A4103C.9090603@nokia.com>
	 <20080818123319.GD17827@atomide.com>
Reply-To: dedekind@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22430 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbYHRMht convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 08:37:49 -0400
In-Reply-To: <20080818123319.GD17827@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>, linux-omap@vger.kernel.org, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>


On Mon, 2008-08-18 at 15:33 +0300, Tony Lindgren wrote:
> * Adrian Hunter <ext-adrian.hunter@nokia.com> [080814 14:21]:
> > On OMAP3, the driver was occasionally not seeing the GPIO
> > interrupt.  Adding a small delay of one register read
> > eliminates the problem.
>=20
> Pushing to linux-omap tree.

Note, dwmw2 pushed this to mtd tree already:

http://git.infradead.org/mtd-2.6.git?a=3Dcommit;h=3D782b7a367d81da005d9=
3b28cb00f9ae086773c24

--=20
Best regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
