From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v3 0/3] ARM: dts: omap3-igep: improvements for v3.13
Date: Tue, 08 Oct 2013 17:39:47 +0200
Message-ID: <52542743.2070304@baylibre.com>
References: <1381158745-9557-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:56662 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab3JHPjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 11:39:52 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so4058039eae.23
        for <linux-omap@vger.kernel.org>; Tue, 08 Oct 2013 08:39:51 -0700 (PDT)
In-Reply-To: <1381158745-9557-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org

Hi Javier

On 07/10/2013 17:12, Javier Martinez Canillas wrote:
> Hi Benoit,
>
> This series are some enhancements and cleanups for IGEP boards
> that it would be great if can make it for v3.13.
>
> This is a third version of the patch-set that addresses some issues
> raised by Roger Quadros and is composed of the following patches:
>
> [PATCH v3 1/3] ARM: dts: omap3-igep: Add USB OTG support
> [PATCH v3 2/3] ARM: dts: omap3-igep0020: Add HS USB Host support
> [PATCH v3 3/3] ARM: dts: omap3-igep0020: use standard constant for IRQ
>
> The patches were tested using the new generic PHY framework that are
> currently on usb-next branch and will be part of v3.13

I've just pulled them into my branch.

Thanks,
Benoit
