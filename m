From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 1/5] OMAP:board-omap3evm: Change TWL related gpio API's to gpio*_cansleep
Date: Fri, 28 Jan 2011 13:26:19 +0530
Message-ID: <AANLkTinc2zfjfc5y6pURF-JEiwhK3FV29E+eS0Q-_GmJ@mail.gmail.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com> <1295977061-11086-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56299 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753551Ab1A1H5A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 02:57:00 -0500
Received: by mail-gx0-f182.google.com with SMTP id 8so1028721gxk.27
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 23:56:59 -0800 (PST)
In-Reply-To: <1295977061-11086-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 25, 2011 at 23:07, Vaibhav Hiremath <hvaibhav@ti.com> wrote=
:
> Since TWL GPIO's can go into sleep, and using normal
> gpio_get/set_value() API will lead to kernel dump (WARN_ON()).
> So replacing standard gpio_get/set_value() to
> gpio_get/set_value_cansleep().
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Reviewed-by: Charulatha V <charu@ti.com>

> ---
> =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 12 ++++++------
> =A01 files changed, 6 insertions(+), 6 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
