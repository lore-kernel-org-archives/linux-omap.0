From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCHv9 01/43] clk: Add support for regmap register read/write
Date: Sat, 02 Nov 2013 14:26:53 +0100
Message-ID: <62888417.HVneXSeQuy@flatron>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:40155 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab3KBN0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Nov 2013 09:26:52 -0400
In-Reply-To: <1382716658-6964-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org, devicetree@vger.kernel.org

Hi Tero,

On Friday 25 of October 2013 18:56:55 Tero Kristo wrote:
> Previously, only direct register read/write was supported. Now a
> per-clock regmap can be provided for same purpose, which allows the
> clock drivers to access clock registers behind e.g. I2C bus.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/clk/clk-divider.c    |    6 +++---
>  drivers/clk/clk-gate.c       |    6 +++---
>  drivers/clk/clk-mux.c        |    6 +++---
>  include/linux/clk-provider.h |   23 +++++++++++++++++++----
>  4 files changed, 28 insertions(+), 13 deletions(-)

The idea itself sounds not bad, but patch description fails to specify 
what is the need for this. I mean, if you know that this will have some 
actual users, it is nice to specify them.

Also IMHO the variant with clk_reg_ops (but with regmap used) would look a 
bit better in terms of readability and extensibility, but I'm leaving this 
completely to Mike's decision.

(OR maybe you could migrate this fully to regmap, which can do MMIO 
accesses as well, without the need of having separate code paths for both 
in clock code?)

Best regards,
Tomasz

