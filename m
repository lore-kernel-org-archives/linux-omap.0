From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] DSPBRIDGE: use dm timer framework for gpt timers
Date: Wed, 28 Apr 2010 10:46:26 +0300
Message-ID: <t2j94a0d4531004280046g49d9a0f9j60a6147b86a1854f@mail.gmail.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-4-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-5-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-6-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-7-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-8-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-9-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-10-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-11-git-send-email-omar.ramirez@ti.com>
	 <1272418167-12630-12-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53163 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab0D1Hq2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 03:46:28 -0400
Received: by bwz19 with SMTP id 19so252523bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 00:46:26 -0700 (PDT)
In-Reply-To: <1272418167-12630-12-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

On Wed, Apr 28, 2010 at 4:29 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> This patch switches to use DM timer framework instead of
> a custom one for GPT timers, currently dsp can make use of
> gpt 5, 6, 7 or 8.

I heard someone that was using gpt 8 for something else. Is it
possible to configure dsp-bridge to not use it?

-- 
Felipe Contreras
