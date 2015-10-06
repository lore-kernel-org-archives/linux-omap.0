From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: cpufreq-dt error: failed to init cpufreq table: -61
Date: Tue, 6 Oct 2015 16:03:55 +0200
Message-ID: <CAAfyv35mMiuLCCnJFjodNcx-iyOsz56-BPU7fkSc=AL1Xw5nJw@mail.gmail.com>
References: <CAAfyv370DFbz9v8URqcipQt-AQ-6du19hf8di2fPeVfTdBzXww@mail.gmail.com>
	<87fv1o3xmo.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <87fv1o3xmo.fsf@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Tue, Oct 6, 2015 at 4:00 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> Hi,
>
> Belisko Marek <marek.belisko@gmail.com> writes:
>> Hi Tony,
>>
>> I'm using custom am33xx board where mpu voltage can be changed through
>> gpio regulator on 4.1 (latest stable) kernel. I defined gpio-regulator
>> node and also operating-points to DT. Gpio regulator seems to be
>> working fine but during probing cpufreq-dt I get error:
>> failed to init cpufreq table: -61
>>
>> I did small investigation and seem that dev_pm_opp_init_cpufreq_table
>> fails at first condition dev_pm_opp_get_opp_count <= 0 and this is
>> because opp_list is empty. So it seems that any opp for am33xx aren't
>> defined if I'm getting it right. I did look to mach-omap2/opp3xxx_data
>> but there is nothing am33xx specific. It is known problem or exist
>> some patches around to fix that? Many thanks.
>
> OPP initialization is not in mainline yet, there are some out-of-tree
> patches which TI has been working on. If you want to use them, have a
> look at TI's vendor kernel at [1]
Thanks for link. One thing which is still not puzzled before I use 3.9
kernel and it was working fine
it's stops working when bumped to 4.1.
>
> [1] http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-lsk-linux-4.1.y/arch/arm/mach-omap2/opp33xx_data.c
>
> --
> balbi

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
