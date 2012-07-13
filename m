From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] rpmsg bus subsys_initcall initialization ordering
Date: Fri, 13 Jul 2012 21:00:16 +0300
Message-ID: <CAK=WgbaTrjSPqEKKt+bt0uD1x+yNXxRZfJUGZjjMnWGV0aAV3Q@mail.gmail.com>
References: <1341936444-3094-1-git-send-email-fuga@studiofuga.com>
 <CAK=Wgbaf0On3teqOw1myqkS4Dei3Vw2Zn=0xfOv-YiNUjFr0fg@mail.gmail.com>
 <485F7F7C-2D0C-4B14-8A46-D42C9F8ED4E4@studiofuga.com> <CAK=WgbZFHzHLxQfoWW4Cz_PpBCzER75KCd=C3WS-7w_LryKuQA@mail.gmail.com>
 <47AF0F55-39D1-4B7E-BE0E-D2395989322D@studiofuga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34688 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563Ab2GMSAh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 14:00:37 -0400
Received: by vbbff1 with SMTP id ff1so2448930vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jul 2012 11:00:37 -0700 (PDT)
In-Reply-To: <47AF0F55-39D1-4B7E-BE0E-D2395989322D@studiofuga.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Federico Fuga <fuga@studiofuga.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Federico,

On Wed, Jul 11, 2012 at 10:14 AM, Federico Fuga <fuga@studiofuga.com> wrote:
> it triggers a BUG() in drivers/base/driver.c line 169

Thanks for sharing this; it definitely makes sense now.

> The subsys_initcall indeed solve this issue

I agree. I'll take it, but will change the commit log to make it
omaprpc-agnostic.

Thanks,
Ohad.
