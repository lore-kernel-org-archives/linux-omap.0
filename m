From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: Re:[PATCH] OMAP: Remove IRQ hardcoding from serial.c
Date: Fri, 15 May 2009 16:00:56 +0530 (IST)
Message-ID: <47729.192.168.10.88.1242383456.squirrel@dbdmail.itg.ti.com>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
    <20090507204653.GD5593@atomide.com>
    <EAF47CD23C76F840A9E7FCE10091EFAB02B4688409@dbde02.ent.ti.com>
    <20090508151755.GI5593@atomide.com>
    <EAF47CD23C76F840A9E7FCE10091EFAB02B48440F9@dbde02.ent.ti.com>
    <d6a0f7aa0905150325u51104b24t945a7841074bb913@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44173 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757872AbZEOKbF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 May 2009 06:31:05 -0400
In-Reply-To: <d6a0f7aa0905150325u51104b24t945a7841074bb913@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shilimkar@dbdmail.itg.ti.com, Santosh <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Santosh,

Where you will be defining INT_24XX_UART1_IRQ, INT_24XX_UART1_IRQ and
INT_24XX_UART3_IRQ ?

Is it in include/asm-arm/arch-omap/serial.h?
-- 
Regards,
Govindraj.R

> ---------- Forwarded message ----------
> From: Shilimkar, Santosh <santosh.shilimkar@ti.com>
> Date: Wed, May 13, 2009 at 8:23 PM
> Subject: [PATCH] OMAP: Remove IRQ hardcoding from serial.c
> To: Tony Lindgren <tony@atomide.com>
> Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
>
>
> Tony,
> Any comments on this patch.
> http://patchwork.kernel.org/patch/19161/
>
> Regards
> Santosh
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


