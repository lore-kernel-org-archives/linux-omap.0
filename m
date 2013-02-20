From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from the driver
Date: Wed, 20 Feb 2013 07:24:56 -0800
Message-ID: <87sj4rqa7r.fsf@linaro.org>
References: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:33974 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934060Ab3BTPY7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 10:24:59 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so2917250pbc.11
        for <linux-omap@vger.kernel.org>; Wed, 20 Feb 2013 07:24:59 -0800 (PST)
In-Reply-To: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Wed, 20 Feb 2013 15:30:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
> so remove the hackery from the driver.
>
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Rajendra nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> ---
>  drivers/tty/serial/omap-serial.c |   23 -----------------------
>  1 file changed, 23 deletions(-)

This patch should also remove the hooks from
<linux/platform_data/serial-omap.h>

Kevin
