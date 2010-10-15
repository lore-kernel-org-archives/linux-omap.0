From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] omap: rx51: mark reserved memory earlier
Date: Fri, 15 Oct 2010 15:49:49 +0300
Message-ID: <AANLkTinYUSqvPA1sGte0hE0jax4upRhaqJmE2w1L=d0g@mail.gmail.com>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	<1287146784-5517-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63966 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab0JONPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Oct 2010 09:15:01 -0400
Received: by bwz15 with SMTP id 15so893451bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Oct 2010 06:14:58 -0700 (PDT)
In-Reply-To: <1287146784-5517-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, mike@compulab.co.il, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

On Fri, Oct 15, 2010 at 3:46 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So that omap_vram_set_sdram_vram() is called before
> omap_vram_reserve_sdram_memblock().

I actually didn't test this (my battery died).

But the previous one works with CONFIG_OMAP2_VRAM_SIZE=6.

-- 
Felipe Contreras
