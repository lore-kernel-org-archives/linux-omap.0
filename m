From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH]omap:dmtimer:no null check for kzalloc
Date: Mon, 12 Jul 2010 09:09:49 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032391F630@dbde02.ent.ti.com>
References: <1278886185-12502-1-git-send-email-tarun.kanti@ti.com>
 <1278871365.3212.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57647 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660Ab0GLDj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Jul 2010 23:39:56 -0400
In-Reply-To: <1278871365.3212.18.camel@localhost.localdomain>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "dedekind1@gmail.com" <dedekind1@gmail.com>
Cc: "olbpdev@list.ti.com - OMAP Linux Baseport Development Team (May contain
	non-TIers)" <olbpdev@list.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Artem Bityutskiy [mailto:dedekind1@gmail.com]
> Sent: Sunday, July 11, 2010 11:33 PM
> To: DebBarma, Tarun Kanti
> Cc: olbpdev@list.ti.com - OMAP Linux Baseport Development Team (May
> contain non-TIers); linux-omap@vger.kernel.org
> Subject: Re: [PATCH]omap:dmtimer:no null check for kzalloc
>=20
> On Mon, 2010-07-12 at 03:39 +0530, Tarun Kanti DebBarma wrote:
> > +                       if (!pdata) {
> > +                               pr_err("%s: \
> > +                               No memory for
> omap_dm_timer_plat_info\n",
> > +                               __func__);
> > +                               return -ENOMEM;
> > +                       }
>=20
> do not use concatenation ('\'), this is probably not what you want.
>
Oops! Thanks for pointing this out. I will change.
=20
> --
> Best Regards,
> Artem Bityutskiy (=E1=D2=D4=A3=CD =E2=C9=D4=C0=C3=CB=C9=CA)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
