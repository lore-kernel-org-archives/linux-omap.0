From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
Date: Fri, 30 Apr 2010 18:21:11 +0300
Message-ID: <x2y94a0d4531004300821v920d3240p5215a967c6c48759@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602CB04896F@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:43416 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757823Ab0D3RAL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 13:00:11 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so260149bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 10:00:10 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CB04896F@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On Fri, Apr 9, 2010 at 3:15 AM, Guzman Lugo, Fernando <x0095840@ti.com> wrote:
> From db3d76a2e89a1c227322a2732ddf7ebf5cd4b4cf Mon Sep 17 00:00:00 2001
> From: Ernesto Ramos <ernesto@ti.com>
> Date: Wed, 24 Mar 2010 11:12:05 -0600
> Subject: [PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
>
> These changes allow for DSP task information to be printed
> by the MPU dspbridge when DSP MMU fault ocurrs.
>
> Signed-off-by: Cris Jansson <cjansson@ti.com>
> [change to open source coding style]
> Signed-off-by: Ernesto Ramos <ernesto@ti.com>

This patch seems to be doing a lot of things. Couldn't it have been split?

Also, from the commit message it seems to implement a new feature,
however, I heard it's supposed to fix memory corruption too. Is that
true? If that's the case the code that fixes that would have to be
separate.

I understand this patch was already pushed to dspbridge branch, but I
think such important changes should be properly recorded in the
history.

Cheers.

-- 
Felipe Contreras
