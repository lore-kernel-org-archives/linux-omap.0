From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2] reboot: Backup orderly_poweroff
Date: Thu, 14 Jan 2016 14:48:36 +0530
Message-ID: <569767EC.2010704@ti.com>
References: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
 <20160114090520.GA4351@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160114090520.GA4351@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org, edubezval@gmail.com, grygorii.strashko@ti.com, nm@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, joel@jms.id.au, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, dyoung@redhat.com, josh@joshtriplett.org, mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-omap@vger.kernel.org

Hi Ingo,

On Thursday 14 January 2016 02:35 PM, Ingo Molnar wrote:
>
> * Keerthy <j-keerthy@ti.com> wrote:
>
>> orderly_poweroff is triggered when a graceful shutdown
>> of system is desired. This may be used in many critical states of the
>> kernel such as when subsystems detects conditions such as critical
>> temperature conditions. However, in certain conditions in system
>> boot up sequences like those in the middle of driver probes being
>> initiated, userspace will be unable to power off the system in a clean
>> manner and leaves the system in a critical state. In cases like these,
>> the /sbin/poweroff will return success (having forked off to attempt
>> powering off the system. However, the system overall will fail to
>> completely poweroff (since other modules will be probed) and the system
>> is still functional with no userspace (since that would have shut itself
>> off).
>>
>> However, there is no clean way of detecting such failure of userspace
>> powering off the system. In such scenarios, it is necessary for a backup
>> workqueue to be able to force a shutdown of the system when orderly
>> shutdown is not successful after a configurable time period.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Suggested-by: Eduardo Valentin <edubezval@gmail.com>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> ---
>> Links to previous discussion can be found here:
>>
>> http://www.spinics.net/lists/linux-omap/msg124925.html
>>
>> Boot tested on DRA7.
>>
>> changes in v2:
>>
>> 	* Changed #ifdef to #if CONFIG_SHUTDOWN_BACKUP_DELAY_MS
>>
>>   arch/Kconfig    |  7 +++++++
>>   kernel/reboot.c | 23 ++++++++++++++++++-----
>>   2 files changed, 25 insertions(+), 5 deletions(-)
>>
>> Index: linux/arch/Kconfig
>> ===================================================================
>> --- linux.orig/arch/Kconfig	2016-01-11 15:26:07.732173131 +0530
>> +++ linux/arch/Kconfig	2016-01-11 15:26:07.728173205 +0530
>> @@ -37,6 +37,18 @@
>>   	def_bool y
>>   	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !PPC64
>>
>> +config SHUTDOWN_BACKUP_DELAY_MS
>> +	int "Backup shutdown delay in milli-seconds"
>> +	default 0
>> +	help
>> +	  The number of milliseconds to delay before backup workqueue
>> +	  executes attempting to poweroff the system after the
>> +	  orderly_poweroff function has failed to complete.
>> +
>> +	  If set to 0, the backup workqueue is not active. The value
>> +	  should be conservatively configured based on userspace latencies
>> +	  expected for a given system.
>
> I don't really understand this. In what circumstances can a reboot fail?
>
> I think that is what should be fixed: a reboot should never fail, instead of
> introducing some sort of fragile timeout based method.

Here is the complete description of the scenario which was reported by 
Nishanth who encountered the issue. The link has bootlogs and 
description of the exact case which led to this patch.

http://www.spinics.net/lists/linux-omap/msg124923.html

Regards,
Keerthy
>
> Thanks,
>
> 	Ingo
>
