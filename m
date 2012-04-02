From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] omap1: mux: add missing include
Date: Mon, 02 Apr 2012 09:47:00 +0300
Message-ID: <4F794B64.5010107@bitmer.com>
References: <1333294241-17510-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:59045 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab2DBGrt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 02:47:49 -0400
In-Reply-To: <1333294241-17510-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/01/2012 06:30 PM, Aaro Koskinen wrote:
> Fix the following build breakage in v3.4-rc1:
> 
> arch/arm/mach-omap1/mux.c:89:1: error: 'FUNC_MUX_CTRL_9' undeclared here (not in a function)
> arch/arm/mach-omap1/mux.c:89:1: error: 'PULL_DWN_CTRL_2' undeclared here (not in a function)
> arch/arm/mach-omap1/mux.c:93:1: error: 'FUNC_MUX_CTRL_C' undeclared here (not in a function)
> 
> etc.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/mach-omap1/mux.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
(happens with omap1_defconfig if CONFIG_OMAP_MUX=y)

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
