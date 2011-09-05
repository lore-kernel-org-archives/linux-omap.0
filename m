From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 22/25] OMAP4: PM: Add power domain statistics support
Date: Mon, 05 Sep 2011 14:08:12 +0400
Message-ID: <4E649F8C.4090800@ru.mvista.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-23-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55197 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab1IEKI5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 06:08:57 -0400
Received: by wwf5 with SMTP id 5so5001403wwf.1
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 03:08:56 -0700 (PDT)
In-Reply-To: <1315144466-9395-23-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

Hello.

On 04-09-2011 17:54, Santosh Shilimkar wrote:

> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/omap-mpuss-lowpower.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index 4dd9d0f..0bc7610 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
[...]
> @@ -270,6 +272,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>   	scu_pwrst_prepare(cpu, power_state);
>   	l2x0_pwrst_prepare(cpu, save_state);
>
> +

    Stray newline?

>   	/*
>   	 * Call low level function  with targeted CPU id
>   	 * and its low power state.

WBR, Sergei
