From: "Pihet-XID, Jean" <j-pihet@ti.com>
Subject: Re: [PATCH 2/3] perf: add OMAP support for the new power events
Date: Tue, 4 Jan 2011 11:58:40 +0100
Message-ID: <AANLkTikjfH1q_74ON8EO=hY+aVuGAu4b22QuvJo-x-ow@mail.gmail.com>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com>
	<1294136263-24020-3-git-send-email-j-pihet@ti.com>
	<20110104104203.GB2447@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <20110104104203.GB2447@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: jean.pihet@newoldbits.com, linux-kernel@vger.kernel.org, trenn@suse.de, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, rjw@sisk.pl
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 4, 2011 at 11:42 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The patch adds the new power management trace points for
>> the OMAP architecture.
>>
>> The trace points are for:
>> - default idle handler. Since the cpuidle framework is
>> =A0 instrumented in the generic way there is no need to
>> =A0 add trace points in the OMAP specific cpuidle handler;
>> - cpufreq (DVFS),
>> - clocks changes (enable, disable, set_rate),
>> - change of power domains next power states.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 =A07 +++++++
>> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A03 +++
>> =A0arch/arm/plat-omap/clock.c =A0 =A0 =A0 =A0| =A0 13 ++++++++++---
>> =A03 files changed, 20 insertions(+), 3 deletions(-)
>
> I suspect the gents and mailing lists listed by:
>
> =A0scripts/get_maintainer.pl -f arch/arm/plat-omap/clock.c
> =A0scripts/get_maintainer.pl -f arch/arm/mach-omap2/pm34xx.c
>
> Would want to be Cc:-ed as well.
Sorry about that. The patches 1 & 2 have been re-sent with additional C=
c's.

> That will also get the right Acked-by's. (if you
> want these commits to go upstream via the perf tree)
Yes the idea is to get those upstream via the tip tree, since it now
contains the perf API clean-up patches from Thomas.

>
> Thanks,
>
> =A0 =A0 =A0 =A0Ingo
>

Thanks,
Jean
