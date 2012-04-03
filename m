From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap4: hsmmc: check for null pointer
Date: Tue, 3 Apr 2012 19:23:28 +0530
Message-ID: <CAMQu2gxR1nKsYsEh3qSOouLHjp+fh+faDGVU6ybPr4TyOY=cwQ@mail.gmail.com>
References: <1333460858-9324-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41304 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752508Ab2DCNxu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Apr 2012 09:53:50 -0400
Received: by qcsg15 with SMTP id g15so2487588qcs.41
        for <linux-omap@vger.kernel.org>; Tue, 03 Apr 2012 06:53:48 -0700 (PDT)
In-Reply-To: <1333460858-9324-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Apr 3, 2012 at 7:17 PM, Balaji T K <balajitk@ti.com> wrote:
> platform_device pdev can be NULL if CONFIG_MMC_OMAP_HS is not set.
> Add check for NULL pointer
>
> Fixes the following boot crash seen with omap4sdp and omap4panda
> when MMC is disabled.
>
> Unable to handle kernel NULL pointer dereference at virtual address 0=
000008c
> pgd =3D c0004000
> [0000008c] *pgd=3D00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0 =A0 =A0Not tainted =A0(3.4.0-rc1-05971-ga4dfa82 #4)
> PC is at omap_4430sdp_init+0x184/0x410
> LR is at device_add+0x1a0/0x664
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks for the fix Balaji.
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
