From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Mon, 2 May 2011 09:58:25 +0300
Message-ID: <20110502095825.05515db9.jhnikula@gmail.com>
References: <1304317733-9639-1-git-send-email-kalle.jokiniemi@nokia.com>
	<1304317733-9639-2-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36160 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab1EBG63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 02:58:29 -0400
Received: by ewy4 with SMTP id 4so1657907ewy.19
        for <linux-omap@vger.kernel.org>; Sun, 01 May 2011 23:58:28 -0700 (PDT)
In-Reply-To: <1304317733-9639-2-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org

On Mon,  2 May 2011 09:28:53 +0300
Kalle Jokiniemi <kalle.jokiniemi@nokia.com> wrote:

> The vaux2 (VCSI) regulator is left on by the bootloader
> in rx-51. Since there the product has shipped and there
> won't be any bootloader updates to fix this issue, we
> need to define all the regulators and declare full
> constraints for the regulator FW. This will allow the
> regulator FW to disable unused regulators.
> 
> Also this helps in adding more fine grain regulator
> support for rx-51 in the future.
> 
> Thanks for Mark Brown for pointing out the correct
> solution.
> 
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Reviewed-by: Jarkko Nikula <jhnikula@gmail.com>
