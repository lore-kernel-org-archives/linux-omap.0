From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Date: Mon, 12 Nov 2012 15:39:45 +0200
Message-ID: <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41679 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2KLNjq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 08:39:46 -0500
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

Hi,

On Mon, Nov 12, 2012 at 12:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> This series changes omapfb to use standard dma_alloc funcs instead of=
 omap
> specific vram allocator. This let's us remove the omap vram allocator=
, making
> omapfb platform independent.
>
> However, note that using standard dma funcs causes the following down=
sides:
>
> ...
>
> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
> changed the ioctl to return 64M for all the values, which, I hope, th=
e
> applications will interpret as "there's enough vram".

Do at least OMAPFB_QUERY_MEM/OMAPFB_SETUP_MEM still work?

> 4) "vram" kernel parameter to define how much ram to reserve for vide=
o use no
> longer works. The user needs to enable CMA and use "cma" parameter.

That's a significant change, you should update Documentation/ .
What about omapfb.vram, is it still there?
Perhaps we also need to select/depend on CMA?


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
