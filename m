From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH V3 2/2] cpufreq: OMAP: instantiate omap-cpufreq as a platform_driver
Date: Fri, 05 Apr 2013 14:34:22 -0700
Message-ID: <871uaoll0h.fsf@linaro.org>
References: <1364507576-19345-1-git-send-email-nm@ti.com>
	<1364507576-19345-3-git-send-email-nm@ti.com>
	<CAOh2x=mdzfyMoGuavrMFgkDgMt=ihxdxa_HG1T8ehfSa1W7j7Q@mail.gmail.com>
	<20130405170707.GA7361@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130405170707.GA7361@kahuna> (Nishanth Menon's message of "Fri,
	5 Apr 2013 12:07:07 -0500")
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-omap@vger.kernel.org, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> On 08:29-20130329, Viresh Kumar wrote:
>> On Fri, Mar 29, 2013 at 3:22 AM, Nishanth Menon <nm@ti.com> wrote:
>> > As multi-platform build is being adopted by more and more ARM plat=
forms,
>> > initcall function should be used very carefully.  For example, whe=
n
>> > CONFIG_ARM_OMAP2PLUS_CPUFREQ is built in the kernel, omap_cpufreq_=
init()
>> > will be called on all the platforms to initialize omap-cpufreq dri=
ver.
>> >
>> > Further, on OMAP, we now use Soc generic cpufreq-cpu0 driver using=
 device
>> > tree entries.  To allow cpufreq-cpu0 and omap-cpufreq drivers to c=
o-exist
>> > for OMAP in a single image, we need to ensure the following:
>> > 1. With device tree boot, we use cpufreq-cpu0
>> > 2. With non device tree boot, we use omap-cpufreq
>> >
>> > In the case of (1), we will have cpu OPPs and regulator registered
>> > as part of the device tree nodes, to ensure that omap-cpufreq
>> > and cpufreq-cpu0 don't conflict in managing the frequency of the
>> > same CPU, we should not permit omap-cpufreq to be probed.
>> >
>> > In the case of (2), we will not have the cpufreq-cpu0 device, henc=
e
>> > only omap-cpufreq will be active.
>> >
>> > To eliminate this undesired these effects, we change omap-cpufreq
>> > driver to have it instantiated as a platform_driver and register
>> > "omap-cpufreq" device only when booted without device tree nodes o=
n
>> > OMAP platforms.
>> >
>> > This allows the following:
>> > a) Will only run on platforms that create the platform_device
>> >    "omap-cpufreq".
>> > b) Since the platform_device is registered only when device tree n=
odes
>> >    are *not* populated, omap-cpufreq driver does not conflict with
>> >    the usage of cpufreq-cpu0 driver which is used on OMAP platform=
s when
>> >    device tree nodes are present.
>> >
>> > Inspired by commit 5553f9e26f6f49a93ba732fd222eac6973a4cf35
>> > (cpufreq: instantiate cpufreq-cpu0 as a platform_driver)
>> >
>> > Cc: Kevin Hilman <khilman@linaro.org>
>> > Cc: Rajendra Nayak <rnayak@ti.com>
>> > Cc: Paul Walmsley <paul@pwsan.com>
>> > Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
>> > Cc: Jon Hunter <jon-hunter@ti.com>
>> > Cc: Keerthy <j-keerthy@ti.com>
>> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > Cc: Shawn Guo <shawn.guo@linaro.org>
>> > [robherring2@gmail.com: reported conflict of omap-cpufreq vs other
>> > driver in an non-device tree supported boot]
>> > Reported-by: Rob Herring <robherring2@gmail.com>
>> > Signed-off-by: Nishanth Menon <nm@ti.com>
>> > ---
>> > Changes in V3:
>> >         - converted to platform_driver to
>> >                 address https://patchwork.kernel.org/patch/2303491=
/ as well
>> >         - modified CC list.
>> > V2: https://patchwork.kernel.org/patch/2303491/
>> > V1: https://patchwork.kernel.org/patch/2273681/
>> >
>> >  arch/arm/mach-omap2/pm.c       |    9 +++++++++
>> >  drivers/cpufreq/omap-cpufreq.c |   19 ++++++++++++++-----
>> >  2 files changed, 23 insertions(+), 5 deletions(-)
>>=20
>> For cpufreq core:
>>=20
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Since this patch could be merged independently to help multi-platform
> builds, While the omap community discusses:
> http://marc.info/?t=3D136450773400004&r=3D1&w=3D2
> http://marc.info/?t=3D136370325600009&r=3D1&w=3D2&n=3D7
>
> To enable cpufreq-cpu0 driver in DT mode, I wonder if we could queue =
this up
> for 3.10.

Yes, I've queued this one for v3.10.  Working on getting some pull
requests out to Tony today.

Kevin
