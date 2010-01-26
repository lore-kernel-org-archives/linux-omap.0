From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RESEND][PATCH] DSPBRIDGE: cache operation against kernel address
	instead of user's
Date: Tue, 26 Jan 2010 13:52:52 +0200
Message-ID: <94a0d4531001260352x38d35cf6g1b0713c951c25618@mail.gmail.com>
References: <1264220772-11097-1-git-send-email-omar.ramirez@ti.com>
	 <4B5E4BB8.5090108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f173.google.com ([209.85.223.173]:56682 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab0AZLwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 06:52:53 -0500
Received: by iwn3 with SMTP id 3so288314iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Jan 2010 03:52:52 -0800 (PST)
In-Reply-To: <4B5E4BB8.5090108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On Tue, Jan 26, 2010 at 3:56 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>
> Based on the discussion:
> =C2=A0http://www.spinics.net/lists/arm-kernel/msg72810.html
>
> HACK: export "follow_page()" for dspbridge cache operation

This is clearly a hack, so what's the plan to fix this in a proper way?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
