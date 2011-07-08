From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
Date: Fri, 08 Jul 2011 15:49:35 +0400
Message-ID: <4E16EECF.7030102@mvista.com>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de> <1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:64553 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1GHLuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 07:50:46 -0400
Received: by fxd18 with SMTP id 18so1980177fxd.11
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 04:50:45 -0700 (PDT)
In-Reply-To: <1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hello.

On 08-07-2011 14:04, Jan Weitzel wrote:

> Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
> ---
>   arch/arm/mach-omap2/Kconfig  |    5 +++++
>   arch/arm/mach-omap2/Makefile |    4 ++++
>   2 files changed, 9 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 19d5891..c6a2d43 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
[...]
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index b148077..e81b594 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -238,6 +238,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
>   					   hsmmc.o \
>   					   omap_phy_internal.o
>
> +obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o \

    You need to first add board-omap4pcm049.c, and only then wire it to the 
Makefile. You could do both in onme patch though...

WBR, Sergei
