From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: slap corruption
Date: Tue, 19 May 2009 14:27:18 +0300 (EEST)
Message-ID: <20090519.142718.191383581.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E60292F45E00@dlee06.ent.ti.com>
	<94a0d4530905190247v3475fcc2g23ed9b6eb09a2fcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39050 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbZESL1g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 07:27:36 -0400
In-Reply-To: <94a0d4530905190247v3475fcc2g23ed9b6eb09a2fcd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: x0095840@ti.com, h-kanigeri2@ti.com, grgupta@ti.com, nm@ti.com, omar.ramirez@ti.com, p-kargirwar@ti.com, linux-omap@vger.kernel.org

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: slap corruption
Date: Tue, 19 May 2009 11:47:11 +0200

> On Tue, May 19, 2009 at 4:56 AM, Guzman Lugo, Fernando <x0095840@ti.c=
om> wrote:
> >
> >
> >
> > Hi everyone,
> >
> > We have been looking into the Slab Corruption error and we have fou=
nd the problem occurs after an application has been terminated abnormal=
ly, e.g. Using CTL-C or Segmentation Fault or kill.
> >
> > The issue is observed not only for DMM test cases but for others te=
st cases that don't use DMM.
> >
> > The problem is reported by 'slab.c' when a slab object which is ina=
ctive, it supposed to be filled with POISON_FREE (6b) and has some 00 w=
ithin the object, this seems to be corrupted.
> >
> > Slab corruption: size-64 start=3Dc6bc71e0, len=3D64
> > <3>Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> > Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> > <3>Last user: [<bf063464>]Last user: [<bf063464>](MEM_Free+0x9c/0xe=
0 [bridgedriv
> > er])(MEM_Free+0x9c/0xe0 [bridgedriver])
> >
> > <3>010:010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6=
b 6b 6b 6b 6b
> > =A06b 00 00 00 00 00 00 00 00
> >
> >
> > it seems it is not being freed correctly, because instead of being =
filled only with 6b it has 00 maybe other process is overwriting it.
> >
> > Does anyone have any idea of what can be happening?
>=20
> Looping Hiroshi who is working on a similar issue... perhaps the same=
?

Thanks;) Maybe the same one, I guess.

>=20
> --=20
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
