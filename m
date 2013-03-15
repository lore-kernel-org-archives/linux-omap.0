From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 8/8] cpufreq: omap: remove omap-cpufreq
Date: Fri, 15 Mar 2013 10:21:18 +0530
Message-ID: <CAOh2x=kCWHL-e9wZxgE97BuNpj0uu67t6SwqghBkyZKL5hugDg@mail.gmail.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
	<1363294695-658-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33908 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab3COEvX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Mar 2013 00:51:23 -0400
In-Reply-To: <1363294695-658-9-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, Mar 15, 2013 at 2:28 AM, Nishanth Menon <nm@ti.com> wrote:
> We can now use cpufreq-cpu0 driver using DT entries.
> remove the redundant omap-cpufreq driver from the tree.
> Remove MAINTAINERS file entry for the same as well.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: "Beno=EEt Cousson" <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: cpufreq@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  MAINTAINERS                    |    1 -
>  drivers/cpufreq/Kconfig.arm    |    6 -
>  drivers/cpufreq/Makefile       |    1 -
>  drivers/cpufreq/omap-cpufreq.c |  291 ------------------------------=
----------
>  4 files changed, 299 deletions(-)
>  delete mode 100644 drivers/cpufreq/omap-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
