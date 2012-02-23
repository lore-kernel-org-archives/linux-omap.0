From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/6] arm: omap4: suspend: Program all domains to RET
Date: Thu, 23 Feb 2012 19:15:08 +0530
Message-ID: <CAMQu2gwdKXgjr=s7o8Wx_tM6_RKan3VoqPdnVULm8JvDTjJj2w@mail.gmail.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com> <1330003320-17400-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46495 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752135Ab2BWNp3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 08:45:29 -0500
Received: by qafi31 with SMTP id i31so1885126qaf.18
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 05:45:28 -0800 (PST)
In-Reply-To: <1330003320-17400-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
> From: Rajendra Nayak <rnayak@ti.com>
>
> Remove the FIXME's in the suspend sequence since
> we now intend to support system level RET support.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

$subject
arm: omap4: suspend: Program all domains to RET
s/arm/ARM
s/omap4/OMAP4
s/RET/retention

o.w looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
