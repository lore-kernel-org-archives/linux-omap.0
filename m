From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap changes
Date: Thu, 12 Jan 2012 20:26:34 +0100
Message-ID: <CAMQu2gx-629ukSTgd=ngQiAeEnBT1+H1racDC_tu_RO7mZjdfg@mail.gmail.com>
References: <20120112184256.GA2287@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:45526 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752926Ab2ALT06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 14:26:58 -0500
Received: by qap15 with SMTP id 15so331215qap.20
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 11:26:57 -0800 (PST)
In-Reply-To: <20120112184256.GA2287@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Jan 12, 2012 at 7:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
> (Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linux
> into devel-stable) merged generic ioremap changes.
>
> Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
> (ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
> added a workaround for omap4.
>
> In order for the errata to work, we now need the following
> patch or else we'll get:
>
> kernel BUG at mm/vmalloc.c:1134!
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
Thanks Tony.

Looks good to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
