From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: omap osk and mistral touchscreen-ads7846
Date: Thu, 22 May 2008 02:39:58 -0500
Message-ID: <7acf7ffc09ea15b37d2c492796e33add@felipebalbi.com>
References: <a1d91fa0805211540n11fc237dhed8deb988f8cbde4@mail.gmail.com> <c656a4d20805212316jdf9eb72ma62059f8cfc49e82@mail.gmail.com> <a1d91fa0805220023i35666796k14773fbd1224d8c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43055 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbYEVHkB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 03:40:01 -0400
In-Reply-To: <a1d91fa0805220023i35666796k14773fbd1224d8c0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: arun c <arunedarath@mistralsolutions.com>, linux-omap@vger.kernel.org



On Thu, 22 May 2008 12:53:11 +0530, "mohammed shareef"
<mdshareef@gmail.com> wrote:
> hi arun/all,
> 
> when i do cat for interrupts i get:
> 
> # cat /proc/interrupts
>            CPU0
>  19:          0         MPU  DMA
>  20:          0         MPU  DMA
>  21:          0         MPU  DMA
>  22:          0         MPU  DMA
>  23:          0         MPU  DMA
>  24:          0         MPU  DMA
>  25:       9834         MPU  LCD DMA
>  31:          3         MPU  lcdc
>  33:          1         MPU  omap-keypad
>  36:        313         MPU  i2c_omap
>  46:        148         MPU  serial
>  54:      19893         MPU  32KHz timer
>  78:          0         MPU  peripheral wakeup
>  85:          0         MPU  DMA
>  86:          0         MPU  DMA
>  87:          0         MPU  DMA
>  88:          0         MPU  DMA
>  89:          0         MPU  DMA
>  90:          0         MPU  DMA
>  91:          0         MPU  DMA
>  92:          0         MPU  DMA
>  93:          0         MPU  DMA
>  94:          0         MPU  DMA
> 160:       1409        GPIO  eth0
> 164:         24        GPIO  spi2.0

Here's your interrupt line (if I'm not wrong).
This touchscreen is connected via spi. If you go to
arch/arm/mach-omap1/board-osk.c you'll see a
spi_board_info.

Just to be sure issue:

watch 'cat /proc/interrupts'

and keep touching the touchscreen. spi2.0 value should increase.


-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

