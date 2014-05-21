From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: use IS_ERR macro for error checking
Date: Wed, 21 May 2014 12:10:05 +0200
Message-ID: <CAPDyKFqPc+ibP+mZgkVDTx-CxrcvaZ2m-y9Vh3JsJ1A+-ugtLQ@mail.gmail.com>
References: <CAPDyKFqJc92kZn_Yj87q3GJWOq+jftm0UPsShAPREqkMKC5S4g@mail.gmail.com>
	<1400160229-2578-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:46763 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaEUKKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 06:10:06 -0400
Received: by mail-qc0-f177.google.com with SMTP id i17so2742712qcy.8
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2014 03:10:05 -0700 (PDT)
In-Reply-To: <1400160229-2578-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>

On 15 May 2014 15:23, Balaji T K <balajitk@ti.com> wrote:
> Debounce clock is optional, use IS_ERR macro instead of NULL pointer check.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Thanks Balaji,

I will include this in the next PR I send to Chris.

Kind regards
Ulf Hansson
