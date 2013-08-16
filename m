From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM:dts: Add devicetree for gta04 board.
Date: Fri, 16 Aug 2013 12:40:55 +0200
Message-ID: <520E01B7.3010804@baylibre.com>
References: <1376599385-1697-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:45016 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab3HPKk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Aug 2013 06:40:59 -0400
Received: by mail-we0-f181.google.com with SMTP id q57so690183wes.40
        for <linux-omap@vger.kernel.org>; Fri, 16 Aug 2013 03:40:58 -0700 (PDT)
In-Reply-To: <1376599385-1697-1-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, linux@arm.linux.org.uk, tony@atomide.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Marek,

On 15/08/2013 22:43, Marek Belisko wrote:
> This adds devicetree for gta04 (Openmoko next generation board) with necessary
> support for mmc, usb, leds and button.
>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>
> This is resurrection of patch sent in March https://lkml.org/lkml/2013/1/24/419
> when I got no reply from maintainer. Patch is updated and based on linux-next (20130807)

Thanks for the update. I added a missing space in the subject and fixed 
an indentation issue for the uart2 node.

Applied in my for_3.12/dts branch.

Regards,
Benoit

