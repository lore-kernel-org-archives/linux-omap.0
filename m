From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2] omap: rx51: Platform support for lp5523 led chip
Date: Thu, 31 Mar 2011 16:50:49 +0300
Message-ID: <20110331165049.f3b83956.jhnikula@gmail.com>
References: <alpine.DEB.1.10.1103311524420.2634@esdhcp041196.research.nokia.com>
	<1301578692-29286-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38929 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757624Ab1CaNux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Mar 2011 09:50:53 -0400
Received: by fxm17 with SMTP id 17so1858862fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 06:50:52 -0700 (PDT)
In-Reply-To: <1301578692-29286-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org, mathias.nyman@nokia.com, linux-arm-kernel@lists.infradead.org

On Thu, 31 Mar 2011 16:38:12 +0300
Ameya Palande <ameya.palande@nokia.com> wrote:

> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   74 ++++++++++++++++++++++++++
>  1 files changed, 74 insertions(+), 0 deletions(-)
> 
Nice keyboard and rgb led blinking:

while true; do ls /sys/class/leds/lp5523\:channel?/brightness |xargs -I
{} bash -c 'echo $((RANDOM % 255)) > {}'; done

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
