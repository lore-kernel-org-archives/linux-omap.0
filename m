From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: problem with twl4030 GPIO irqs
Date: Fri, 16 Dec 2011 18:54:55 +0200
Message-ID: <CANOLnOOxBT=AS=C3sNKecYdCHmpFBZ1-Tr+YkOrp7jzq9BMgCg@mail.gmail.com>
References: <CANOLnON1-vg45KWZ7Rp+jL1n-jwBiTA2Qmkr_z1XnDKQ0XBPJw@mail.gmail.com>
	<20111216115032.4c4dfbb5@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64675 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1LPQy5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 11:54:57 -0500
Received: by eekc4 with SMTP id c4so3403160eek.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 08:54:55 -0800 (PST)
In-Reply-To: <20111216115032.4c4dfbb5@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

On Fri, Dec 16, 2011 at 2:50 AM, NeilBrown <neilb@suse.de> wrote:
> Try this.
>
> I wrote it for a slightly different reason, but I think it applies he=
re.
>
> NeilBrown
>
> From f7f05b87364d0316f1f6ddad0d7387b25f5d21b9 Mon Sep 17 00:00:00 200=
1
> From: NeilBrown <neilb@suse.de>
> Date: Fri, 2 Dec 2011 15:35:16 +1100
> Subject: [PATCH] omap_hsmmc - use threaded irq handler for card-detec=
t.

That works, thanks!

Tested-by: Grazvydas Ignotas <notasas@gmail.com>


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
