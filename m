From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 1/1] net: cpts: fix for build break after ARM SoC integration
Date: Tue, 27 Nov 2012 16:55:19 +0530
Message-ID: <50B4A31F.5040504@ti.com>
References: <1354012034-31686-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1354012034-31686-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com, richardcochran@gmail.com
List-Id: linux-omap@vger.kernel.org

On 11/27/2012 3:57 PM, Mugunthan V N wrote:
>    CC      drivers/net/ethernet/ti/cpts.o
> drivers/net/ethernet/ti/cpts.c:30:24: fatal error: plat/clock.h: No such file or directory
> compilation terminated.
> make[4]: *** [drivers/net/ethernet/ti/cpts.o] Error 1
> make[3]: *** [drivers/net/ethernet/ti] Error 2
> make[2]: *** [drivers/net/ethernet] Error 2
> make[1]: *** [drivers/net] Error 2
>
> fix for build break as the header file is removed from plat-omap as part of
> the below patch
>
> commit a135eaae524acba1509a3b19c97fae556e4da7cd
> Author: Paul Walmsley <paul@pwsan.com>
> Date:   Thu Sep 27 10:33:34 2012 -0600
>
>      ARM: OMAP: remove plat/clock.h
>
>      Remove arch/arm/plat-omap/include/plat/clock.h by merging it into
>      arch/arm/mach-omap1/clock.h and arch/arm/mach-omap2/clock.h.
>      The goal here is to facilitate ARM single image kernels by removing
>      includes via the "plat/" symlink.
The header removal patch can be found in linux-next git repo.

Regards
Mugunthan V N
