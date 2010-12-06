From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] tsc2005 driver support on rx51
Date: Mon, 6 Dec 2010 11:35:35 -0800
Message-ID: <20101206193535.GO8345@atomide.com>
References: <1290700177-26602-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17928 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab0LFTft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 14:35:49 -0500
Content-Disposition: inline
In-Reply-To: <1290700177-26602-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org

* Srikar <ext-srikar.1.bhavanarayana@nokia.com> [101125 07:40]:
> To support  tsc2005 driver on rx51,added tsc2005
> intialization data ,functions to enable/disable
> tsc2005 and loading driver on rx51.

>  #include <linux/input/matrix_keypad.h>
>  #include <linux/spi/spi.h>
>  #include <linux/wl12xx.h>
> +#include <linux/spi/tsc2005.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/clk.h>

This does not exist in mainline yet, please send this patch
along with the tsc2005 driver via the input list. For this one:

Acked-by: Tony Lindgren <tony@atomide.com>
