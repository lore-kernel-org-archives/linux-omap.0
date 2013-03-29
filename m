From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/2] cpufreq: OMAP: instantiate omap-cpufreq as a platform_driver
Date: Fri, 29 Mar 2013 08:29:35 +0530
Message-ID: <CAOh2x=mdzfyMoGuavrMFgkDgMt=ihxdxa_HG1T8ehfSa1W7j7Q@mail.gmail.com>
References: <1364507576-19345-1-git-send-email-nm@ti.com>
	<1364507576-19345-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1364507576-19345-3-git-send-email-nm@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 29, 2013 at 3:22 AM, Nishanth Menon <nm@ti.com> wrote:
> As multi-platform build is being adopted by more and more ARM platfor=
ms,
> initcall function should be used very carefully.  For example, when
> CONFIG_ARM_OMAP2PLUS_CPUFREQ is built in the kernel, omap_cpufreq_ini=
t()
> will be called on all the platforms to initialize omap-cpufreq driver=
=2E
>
> Further, on OMAP, we now use Soc generic cpufreq-cpu0 driver using de=
vice
> tree entries.  To allow cpufreq-cpu0 and omap-cpufreq drivers to co-e=
xist
> for OMAP in a single image, we need to ensure the following:
> 1. With device tree boot, we use cpufreq-cpu0
> 2. With non device tree boot, we use omap-cpufreq
>
> In the case of (1), we will have cpu OPPs and regulator registered
> as part of the device tree nodes, to ensure that omap-cpufreq
> and cpufreq-cpu0 don't conflict in managing the frequency of the
> same CPU, we should not permit omap-cpufreq to be probed.
>
> In the case of (2), we will not have the cpufreq-cpu0 device, hence
> only omap-cpufreq will be active.
>
> To eliminate this undesired these effects, we change omap-cpufreq
> driver to have it instantiated as a platform_driver and register
> "omap-cpufreq" device only when booted without device tree nodes on
> OMAP platforms.
>
> This allows the following:
> a) Will only run on platforms that create the platform_device
>    "omap-cpufreq".
> b) Since the platform_device is registered only when device tree node=
s
>    are *not* populated, omap-cpufreq driver does not conflict with
>    the usage of cpufreq-cpu0 driver which is used on OMAP platforms w=
hen
>    device tree nodes are present.
>
> Inspired by commit 5553f9e26f6f49a93ba732fd222eac6973a4cf35
> (cpufreq: instantiate cpufreq-cpu0 as a platform_driver)
>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: "Beno=EEt Cousson" <b-cousson@ti.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> [robherring2@gmail.com: reported conflict of omap-cpufreq vs other
> driver in an non-device tree supported boot]
> Reported-by: Rob Herring <robherring2@gmail.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in V3:
>         - converted to platform_driver to
>                 address https://patchwork.kernel.org/patch/2303491/ a=
s well
>         - modified CC list.
> V2: https://patchwork.kernel.org/patch/2303491/
> V1: https://patchwork.kernel.org/patch/2273681/
>
>  arch/arm/mach-omap2/pm.c       |    9 +++++++++
>  drivers/cpufreq/omap-cpufreq.c |   19 ++++++++++++++-----
>  2 files changed, 23 insertions(+), 5 deletions(-)

=46or cpufreq core:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
