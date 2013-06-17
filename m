From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 0/2] Remove unused voltagedomain data for AM33xx
Date: Mon, 17 Jun 2013 09:22:14 -0400
Message-ID: <51BF0D86.7090703@ti.com>
References: <1371474983-29296-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56695 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533Ab3FQNXj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 09:23:39 -0400
In-Reply-To: <1371474983-29296-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: khilman@linaro.org, paul@pwsan.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 17 June 2013 09:16 AM, Rajendra Nayak wrote:
> Hi,
> 
> The powerdomain framework currently expects to always have a voltagedomain
> associated with a given powerdomain. We already have AM33xx which
> has no Voltage Controller/Voltage Processor as part of PRCM.
> There are more SoCs' to follow starting with AM437x and DRA7xx
> which do not have VC/VP. All these SoCs', hence do not support any
> form of auto-scaling of voltages, that was possible on earlier OMAPs'
> using the VFSM to trigger an i2c communication to the PMIC automatically
> on hitting a low power state.
> 
> Instead of adding dummy voltage domain data files, like was done for the
> AM33xx case, make the powerdomain framework aware of the fact that some
> SoCs' might not really have support for auto-scaling of voltages in hw.
> 
> Patches are based of 3.10-rc6 and are boot tested on am335x bone.
> 
> Rajendra Nayak (2):
>   ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm
>     associated to a pwrdm
>   ARM: AM33xx: Remove the unused voltagedomain data
> 
>  arch/arm/mach-omap2/Makefile                  |    1 -
>  arch/arm/mach-omap2/io.c                      |    1 -
>  arch/arm/mach-omap2/powerdomain.c             |    5 +++
>  arch/arm/mach-omap2/powerdomain.h             |    2 ++
>  arch/arm/mach-omap2/prm33xx.c                 |    7 ++++
>  arch/arm/mach-omap2/voltage.h                 |    1 -
>  arch/arm/mach-omap2/voltagedomains33xx_data.c |   43 -------------------------
>  7 files changed, 14 insertions(+), 46 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c
> 
Nice !!

FWIW, Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
