From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] OMAP: Fix Memory leak
Date: Thu, 20 May 2010 20:28:46 +0530
Message-ID: <AANLkTilf5yoBQK3MNubxtVTr1G8wgLRY0hjAbXheBbIA@mail.gmail.com>
References: <1274365792-24938-1-git-send-email-manjugk@ti.com>
	<1274365792-24938-4-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42117 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab0ETO7I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 10:59:08 -0400
Received: by pwi5 with SMTP id 5so2123061pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 07:59:07 -0700 (PDT)
In-Reply-To: <1274365792-24938-4-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Satish <x0124230@ti.com>, Tony Lindgren <tony@atomide.com>

On Thu, May 20, 2010 at 7:59 PM, Manjunatha GK <manjugk@ti.com> wrote:
> From: Satish <x0124230@ti.com>
>
> The memory allocated for sgt structure is not freed on error
> when sg_alloc_table is called in sg_alloc_table().

Typo mistake: correct "sg_alloc_table" to "sgtable_alloc" for second time.

-- 
Regards,
Vimal Singh
