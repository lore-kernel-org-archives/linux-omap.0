From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH] [RFC] OMAP4: sDMA: Update the request lines and new
	registers.
Date: Sat, 23 May 2009 18:25:42 +0530
Message-ID: <618f0c910905230555m4d999691ua02d15d9fed708ae@mail.gmail.com>
References: <1242132073-16563-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:17092 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbZEWMzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 08:55:41 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1331986yxj.1
        for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 05:55:42 -0700 (PDT)
In-Reply-To: <1242132073-16563-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, May 12, 2009 at 6:11 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>
> +#define OMAP_DMA4_CDP_REG(n) =A0 =A0 =A0 =A0 =A0 (0x60 * (n) + 0xd0)
> +#define OMAP_DMA4_CNDP_REG(n) =A0 =A0 =A0 =A0 =A0(0x60 * (n) + 0xd4)
> +#define OMAP_DMA4_CCDN_REG(n) =A0 =A0 =A0 =A0 =A0(0x60 * (n) + 0xd8)
> +

It would be consistent with all other definitions to *not* have the
_REG suffix for these registers, don't you think ?

Regards,

Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
