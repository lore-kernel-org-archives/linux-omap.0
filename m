From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B 2/3] tidspbridge: cleanup and remove HW_MMU_TLBFlushAll
Date: Thu, 19 Mar 2009 10:49:00 +0200
Message-ID: <94a0d4530903190149g3b9b7dbav2abb95c953ee9929@mail.gmail.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63946 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbZCSItE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 04:49:04 -0400
Received: by fxm2 with SMTP id 2so392170fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2009 01:49:00 -0700 (PDT)
In-Reply-To: <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

On Wed, Mar 18, 2009 at 3:26 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> From: Felipe Contreras <felipe.contreras@nokia.com>
>
> It doesn't make sense to have layers and layers of constants and defi=
nes
> to turn one bit on.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
> ---

I thought a bit more about this:

> +static inline void tlb_flush_all(const u32 base)
> +{
> + =C2=A0 =C2=A0__raw_writeb(__raw_readb(base + MMU_GFLUSH) | 1, base =
+ MMU_GFLUSH);
> +}
> +

Originally it was the equivalent of __raw_writel(__raw_readl but since
we are dealing only with one bit I chose 'b' instead of 'l'. Is that
correct?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
