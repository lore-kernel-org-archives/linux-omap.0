From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v1 3/3] ARM: dts: am335x-bone: add support for beaglebone
 LCD4 cape
Date: Tue, 24 Jun 2014 12:03:37 -0300
Message-ID: <20140624150336.GA10041@arch.cereza>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:61643 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbaFXPEX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 11:04:23 -0400
Received: by mail-yh0-f47.google.com with SMTP id v1so257549yhn.6
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2014 08:04:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403612666-31197-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>

Hello Pekon,

On 24 Jun 05:54 PM, Pekon Gupta wrote:
> This patch adds support for LCD4 cape as advertised on
>   http://elinux.org/CircuitCo:BeagleBone_LCD4
> 
> This cape has:
> * 480x272 TFT-LCD panel
>  - LCD panel datasheet and timing information are sourced from [1]
>  - LCD backlight is connected to 'EHRPWM1A' on cape board, but its used for
>    enabling backlight power-supply. So 'gpio-backlight' driver is used instead
>    of 'pwm-backlight' driver (Kconfig: BACKLIGHT_GPIO=y).
> 

I'm confused about this, can you clarify why you are not using pwm-backlight?

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
