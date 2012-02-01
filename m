From: Colin Cross <ccross@android.com>
Subject: Re: [linux-pm] [PATCH 0/3] coupled cpuidle state support
Date: Wed, 1 Feb 2012 09:30:15 -0800
Message-ID: <CAMbhsRTFzc8aGsSGUs2==4FiqBb7zOit4cO=6U698k+RCE+kqQ@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4F1929E9.7070707@linaro.org>
	<CAMbhsRTbVqV6p0py9NGZrpFPf2yvp-B0dr+o-m7qbdja_-Lfzw@mail.gmail.com>
	<CAKfTPtAsO8z_8AnR8zSGZ9cm_7orDNxB3r09JAFk+2jdezUVmQ@mail.gmail.com>
	<CAMbhsRQYVXTZ2pX4mBrM6=SyGTqn_GY8xsW4rt_e21zerEzctA@mail.gmail.com>
	<CAKfTPtB3Kcy41H9g9u3u81kEHJeypi=GvOfOjcpdztzqN991nA@mail.gmail.com>
	<20120201145934.GA20421@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54214 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab2BARaP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 12:30:15 -0500
Received: by ghrr11 with SMTP id r11so695068ghr.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 09:30:15 -0800 (PST)
In-Reply-To: <20120201145934.GA20421@e102568-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Feb 1, 2012 at 6:59 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Feb 01, 2012 at 12:13:26PM +0000, Vincent Guittot wrote:
>
> [...]
>
>> >> In your patch, you put in safe state (WFI for most of platform) t=
he
>> >> cpus that become idle and these cpus are woken up each time a new=
 cpu
>> >> of the cluster becomes idle. Then, the cluster state is chosen an=
d the
>> >> cpus enter the selected C-state. On ux500, we are using another
>> >> behavior for synchronizing =A0the cpus. The cpus are prepared to =
enter
>> >> the c-state that has been chosen by the governor and the last cpu=
,
>> >> that enters idle, chooses the final cluster state (according to c=
pus'
>> >> C-state). The main advantage of this solution is that you don't n=
eed
>> >> to wake other cpus to enter the C-state of a cluster. This can be
>> >> quite worth full when tasks mainly run on one cpu. Have you also =
think
>> >> about such behavior when developing the coupled cpuidle driver ? =
It
>> >> could be interesting to add such behavior.
>> >
>> > Waking up the cpus that are in the safe state is not done just to
>> > choose the target state, it's done to allow the cpus to take
>> > themselves to the target low power state. =A0On ux500, are you say=
ing
>> > you take the cpus directly from the safe state to a lower power st=
ate
>> > without ever going back to the active state? =A0I once implemented=
 Tegra
>>
>> yes it is
>
> But if there is a single power rail for the entire cluster, when a CP=
U
> is "prepared" for shutdown this means that you have to save the conte=
xt and
> clean L1, maybe for nothing since if other CPUs are up and running th=
e
> CPU going idle can just enter a simple standby wfi (clock-gated but p=
ower on).
>
> With Colin's approach, context is saved and L1 cleaned only when it i=
s
> almost certain the cluster is powered off (so the CPUs).
>
> It is a trade-off, I am not saying one approach is better than the
> other; we just have to make sure that preparing the CPU for "possible=
" shutdown
> is better than sending IPIs to take CPUs out of wfi and synchronize
> them (this happens if and only if CPUs enter coupled C-states).
>
> As usual this will depend on use cases (and silicon implementations :=
) )
>
> It is definitely worth benchmarking them.
>

I'm less worried about performance, and more worried about race
conditions.  How do you deal with the following situation:
CPU0 goes to WFI, and saves its state
CPU1 goes idle, and selects a deep idle state that powers down CPU0
CPU1 saves is state, and is about to trigger the power down
CPU0 gets an interrupt, restores its state, and modifies state (maybe
takes a spinlock during boot)
CPU1 cuts the power to CPU0

On OMAP4, the race is handled in hardware.  When CPU1 tries to cut the
power to the blocks shared by CPU0 the hardware will ignore the
request if CPU0 is not in WFI.  On Tegra2, there is no hardware
support and I had to handle it with a spinlock implemented in scratch
registers because CPU0 is out of coherency when it starts booting and
ldrex/strex don't work.  I'm not convinced my implementation is
correct, and I'd be curious to see any other implementations.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
