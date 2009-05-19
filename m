From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: slap corruption
Date: Tue, 19 May 2009 12:47:11 +0300
Message-ID: <94a0d4530905190247v3475fcc2g23ed9b6eb09a2fcd@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60292F45E00@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:7026 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbZESJrL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 05:47:11 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1356178fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 02:47:11 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E60292F45E00@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Kargirwar, Pankaj" <p-kargirwar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Tue, May 19, 2009 at 4:56 AM, Guzman Lugo, Fernando <x0095840@ti.com=
> wrote:
>
>
>
> Hi everyone,
>
> We have been looking into the Slab Corruption error and we have found=
 the problem occurs after an application has been terminated abnormally=
, e.g. Using CTL-C or Segmentation Fault or kill.
>
> The issue is observed not only for DMM test cases but for others test=
 cases that don't use DMM.
>
> The problem is reported by 'slab.c' when a slab object which is inact=
ive, it supposed to be filled with POISON_FREE (6b) and has some 00 wit=
hin the object, this seems to be corrupted.
>
> Slab corruption: size-64 start=3Dc6bc71e0, len=3D64
> <3>Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> <3>Last user: [<bf063464>]Last user: [<bf063464>](MEM_Free+0x9c/0xe0 =
[bridgedriv
> er])(MEM_Free+0x9c/0xe0 [bridgedriver])
>
> <3>010:010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b =
6b 6b 6b 6b
> =C2=A06b 00 00 00 00 00 00 00 00
>
>
> it seems it is not being freed correctly, because instead of being fi=
lled only with 6b it has 00 maybe other process is overwriting it.
>
> Does anyone have any idea of what can be happening?

Looping Hiroshi who is working on a similar issue... perhaps the same?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
