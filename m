From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] OMAP CPUIDLE: CPU Idle latency measurement
Date: Fri, 27 Aug 2010 14:59:48 -0700
Message-ID: <87occnlnsb.fsf@deeprootsystems.com>
References: <1282946913-26659-1-git-send-email-vishwanath.sripathy@linaro.org>
	<20100827202842.GF2352@matterhorn.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20100827202842.GF2352-HeifvKp/9wrwg6x6O6sdfg@public.gmane.org> (Amit Kucheria's message
	of "Fri, 27 Aug 2010 23:28:42 +0300")
List-Unsubscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 10 Aug 28, vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> From: Vishwanath BS <vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> 
>> This patch has instrumentation code for measuring latencies for
>> various CPUIdle C states for OMAP. Idea here is to capture the
>> timestamp at various phases of CPU Idle and then compute the sw
>> latency for various c states. For OMAP, 32k clock is chosen as
>> reference clock this as is an always on clock. wkup domain memory
>> (scratchpad memory) is used for storing timestamps. One can see the
>> worstcase latencies in below sysfs entries (after enabling CONFIG_CPU_IDLE_PROF
>> in .config). This information can be used to correctly configure cpu idle
>> latencies for various C states after adding HW latencies for each of
>> these sw latencies.
>> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/actual_latency
>> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/sleep_latency
>> /sys/devices/system/cpu/cpu0/cpuidle/state<n>/wkup_latency
>> 
>> THis patch is tested on OMAP ZOOM3 using kevin's pm branch.
>> 
>> Signed-off-by: Vishwanath BS <vishwanath.sripathy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
>> ---
>>  arch/arm/mach-omap2/cpuidle34xx.c |   58 ++++++++++++++++--
>>  arch/arm/mach-omap2/pm.h          |    5 ++
>>  arch/arm/mach-omap2/sleep34xx.S   |  121 +++++++++++++++++++++++++++++++++++++
>>  drivers/cpuidle/Kconfig           |    5 ++
>>  drivers/cpuidle/sysfs.c           |   16 +++++-
>>  include/linux/cpuidle.h           |    3 +
>>  6 files changed, 202 insertions(+), 6 deletions(-)
>
> You should perhaps cc Len Brown and LKML for V2 to get acceptance for the new
> counters in cpuidle

Before a v2, we need to have some discussions about the general
direction of how to best do PM instrumentation.  As I said in my review
of this patch[1], I am not a fan of the current approach.

Kevin

[1] http://marc.info/?l=linux-omap&m=128293652216542&w=2

NOTE: This post may not have made it to linaro-dev since it's moderated,
      an I wasn't subscribed when I posted this, but am now.
