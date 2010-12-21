From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: UBIFS not mounting on linux-omap 2.6.36
Date: Tue, 21 Dec 2010 19:36:22 +0200
Message-ID: <1292952982.13362.21.camel@koala>
References: <201012201118.01766.manningc2@actrix.gen.nz>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:39560 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab0LURg0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 12:36:26 -0500
Received: by fxm18 with SMTP id 18so4587589fxm.2
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 09:36:25 -0800 (PST)
In-Reply-To: <201012201118.01766.manningc2@actrix.gen.nz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, 2010-12-20 at 11:18 +1300, Charles Manning wrote:
> Hi All
>=20
> I am trying to nail down an omap3 ubifs  performance regression, but =
cannot=20
> get Steve Sakoman's 2.6.35 or 2.6.36 kernels
> http://www.sakoman.com/cgi-bin/gitweb.cgi?p=3Dlinux-omap-2.6.git
>  to mount ubifs although the same procedure works with older kernels =
and works=20
> with the linux-omap 2.6.37 master.

Well, the only hint I can give is some kind of bisecting, but probably
you do not need such hint :-)

--=20
Best Regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
