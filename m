From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] DSPBRIDGE: DSP recovery feature
Date: Mon, 29 Mar 2010 02:29:11 +0300
Message-ID: <94a0d4531003281629xe17d16dtcebba669c0a59f47@mail.gmail.com>
References: <AcrMYJFr1p3cmVYdQomG2hf1Av9JXw==>
	 <496565EC904933469F292DDA3F1663E602CADC3396@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:60404 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab0C1Xfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Mar 2010 19:35:31 -0400
Received: by ewy22 with SMTP id 22so1663131ewy.37
        for <linux-omap@vger.kernel.org>; Sun, 28 Mar 2010 16:35:30 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CADC3396@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

On Fri, Mar 26, 2010 at 12:17 AM, Guzman Lugo, Fernando <x0095840@ti.com> wrote:
>
> Patch updated with new O_NONBLOCK option in bridge_open function.
>
>
> From aa1b238e4bd30eb52a96a7000998cd7d32e37050 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Thu, 25 Mar 2010 15:23:38 -0600
> Subject: [PATCH] DSPBRIDGE: DSP recovery feature
>
> This patch implements a workqueue in charge of reseting
> DSP in case of fatal error.

Tested-by: Felipe Contreras <felipe.contreras@nokia.com>

-- 
Felipe Contreras
