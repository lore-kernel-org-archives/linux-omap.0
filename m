From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 0/6] regulator: palmas: cleanup and fixes
Date: Wed, 2 Jul 2014 10:45:39 +0530
Message-ID: <53B3957B.40006@ti.com>
References: <1404143859-8160-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404143859-8160-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 30 June 2014 09:27 PM, Nishanth Menon wrote:
> Hi,
> 	Original thread (v1): http://marc.info/?t=140380766500004&r=1&w=2
> This series is based on: git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
> branch: topic/palmas (4c0c9ca Merge remote-tracking branch 'regulator/fix/palmas' into regulator-palmas)
>
> This series does a few cleanups to help ensure we dont make typo mistakes and finally provides a fix as attempted by (v1).
>
> Basic cpufreq tests performed on OMAP5uEVM, DRA7-evm, DRA72-evm all of which are palmas variants.
>
> The patches are also available here: https://github.com/nmenon/linux-2.6-playground/commits/broonie-topic-palmas-fixes
> 		
For the series:

  Acked-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>       
> Nishanth Menon (6):
>    regulator: palmas: Squelch sparse warnings
>    regulator: palmas: Rename reg_info to palmas_reg_info
>    regulator: palmas: Simplify code by using pointer to palmas_reg_info
>    regulator: palmas: Rename palmas_regs_info to
>      palmas_generic_regs_info
>    regulator: palmas: Simplify code by not indexing regulator_desc
>      unnecessarily
>    regulator: palmas: Fix SMPS enable/disable/is_enable for tps65917
>
>   drivers/regulator/palmas-regulator.c |  344 ++++++++++++++++------------------
>   include/linux/mfd/palmas.h           |    4 +-
>   2 files changed, 166 insertions(+), 182 deletions(-)
>
