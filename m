From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: Build error while adding debug LL support for new board
Date: Thu, 20 Oct 2011 17:09:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930328B2D71D@dbde02.ent.ti.com>
References: <1318856432-20219-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50024 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab1JTLjV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Oct 2011 07:39:21 -0400
In-Reply-To: <1318856432-20219-1-git-send-email-afzal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Russell,

n Mon, Oct 17, 2011 at 18:30:32, Mohammed, Afzal wrote:
> Hi, Russell,
> 
> While adding low level debug support for new board in OMAP2+ family, we
> came across following error,
> 
> arch/arm/kernel/debug.S: Assembler messages:
> arch/arm/kernel/debug.S:138: Error: invalid constant (428) after fixup
> 
> Following patch fixes it, I am not sure whether this is the right fix,
> please let us know your comments.

ping

Regards
Afzal

> From: Afzal Mohammed <afzal@ti.com>
> Date: Fri, 14 Oct 2011 12:56:16 +0530
> Subject: [PATCH] ARM: Fix error upon adding LL debug
> 
> Upon adding new board LL debug support, if the resultant code
> addition would not cause PC relative offset of "hexbuf" from
> "adr r2, hexbuf" (+2) instruction to be representable in a
> shifted 8-bit value (hence indirectly putting higher aligment
> requirement on larger offsets), following error occurs,
> 
> arch/arm/kernel/debug.S: Assembler messages:
> arch/arm/kernel/debug.S:138: Error: invalid constant (428) after fixup
> 
> Fix it by bringing "hexbuf" closer so that "adr"
> can have the offset.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/kernel/debug.S |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
> index bcd66e0..0f852d0 100644
> --- a/arch/arm/kernel/debug.S
> +++ b/arch/arm/kernel/debug.S
> @@ -151,6 +151,8 @@ printhex:   adr     r2, hexbuf
>                 b       printascii
>  ENDPROC(printhex2)
> 
> +hexbuf:                .space 16
> +
>                 .ltorg
> 
>  ENTRY(printascii)
> @@ -175,5 +177,3 @@ ENTRY(printch)
>                 mov     r0, #0
>                 b       1b
>  ENDPROC(printch)
> -
> -hexbuf:                .space 16
> --
> 1.6.2.4
> 
> 
> 

