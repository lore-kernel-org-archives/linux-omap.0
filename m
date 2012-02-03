From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Thu, 2 Feb 2012 17:19:28 -0800
Message-ID: <CAMbhsRSBqyTaCBMjJL-izMK=HSVwY6yQQqPyg0enddo2vymyxA@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4F1929E9.7070707@linaro.org>
	<CAMbhsRTbVqV6p0py9NGZrpFPf2yvp-B0dr+o-m7qbdja_-Lfzw@mail.gmail.com>
	<CAKfTPtAsO8z_8AnR8zSGZ9cm_7orDNxB3r09JAFk+2jdezUVmQ@mail.gmail.com>
	<CAMbhsRQYVXTZ2pX4mBrM6=SyGTqn_GY8xsW4rt_e21zerEzctA@mail.gmail.com>
	<CAKfTPtB3Kcy41H9g9u3u81kEHJeypi=GvOfOjcpdztzqN991nA@mail.gmail.com>
	<20120201145934.GA20421@e102568-lin.cambridge.arm.com>
	<CAMbhsRTFzc8aGsSGUs2==4FiqBb7zOit4cO=6U698k+RCE+kqQ@mail.gmail.com>
	<20120201180705.GA20936@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120201180705.GA20936@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 1, 2012 at 10:07 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Feb 01, 2012 at 05:30:15PM +0000, Colin Cross wrote:
>> On Wed, Feb 1, 2012 at 6:59 AM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > On Wed, Feb 01, 2012 at 12:13:26PM +0000, Vincent Guittot wrote:
>> >
>> > [...]
>> >
>> >> >> In your patch, you put in safe state (WFI for most of platform) the
>> >> >> cpus that become idle and these cpus are woken up each time a new =
cpu
>> >> >> of the cluster becomes idle. Then, the cluster state is chosen and=
 the
>> >> >> cpus enter the selected C-state. On ux500, we are using another
>> >> >> behavior for synchronizing =A0the cpus. The cpus are prepared to e=
nter
>> >> >> the c-state that has been chosen by the governor and the last cpu,
>> >> >> that enters idle, chooses the final cluster state (according to cp=
us'
>> >> >> C-state). The main advantage of this solution is that you don't ne=
ed
>> >> >> to wake other cpus to enter the C-state of a cluster. This can be
>> >> >> quite worth full when tasks mainly run on one cpu. Have you also t=
hink
>> >> >> about such behavior when developing the coupled cpuidle driver ? It
>> >> >> could be interesting to add such behavior.
>> >> >
>> >> > Waking up the cpus that are in the safe state is not done just to
>> >> > choose the target state, it's done to allow the cpus to take
>> >> > themselves to the target low power state. =A0On ux500, are you sayi=
ng
>> >> > you take the cpus directly from the safe state to a lower power sta=
te
>> >> > without ever going back to the active state? =A0I once implemented =
Tegra
>> >>
>> >> yes it is
>> >
>> > But if there is a single power rail for the entire cluster, when a CPU
>> > is "prepared" for shutdown this means that you have to save the contex=
t and
>> > clean L1, maybe for nothing since if other CPUs are up and running the
>> > CPU going idle can just enter a simple standby wfi (clock-gated but po=
wer on).
>> >
>> > With Colin's approach, context is saved and L1 cleaned only when it is
>> > almost certain the cluster is powered off (so the CPUs).
>> >
>> > It is a trade-off, I am not saying one approach is better than the
>> > other; we just have to make sure that preparing the CPU for "possible"=
 shutdown
>> > is better than sending IPIs to take CPUs out of wfi and synchronize
>> > them (this happens if and only if CPUs enter coupled C-states).
>> >
>> > As usual this will depend on use cases (and silicon implementations :)=
 )
>> >
>> > It is definitely worth benchmarking them.
>> >
>>
>> I'm less worried about performance, and more worried about race
>> conditions. =A0How do you deal with the following situation:
>> CPU0 goes to WFI, and saves its state
>> CPU1 goes idle, and selects a deep idle state that powers down CPU0
>> CPU1 saves is state, and is about to trigger the power down
>> CPU0 gets an interrupt, restores its state, and modifies state (maybe
>> takes a spinlock during boot)
>> CPU1 cuts the power to CPU0
>>
>> On OMAP4, the race is handled in hardware. =A0When CPU1 tries to cut the
>> power to the blocks shared by CPU0 the hardware will ignore the
>> request if CPU0 is not in WFI. =A0On Tegra2, there is no hardware
>> support and I had to handle it with a spinlock implemented in scratch
>> registers because CPU0 is out of coherency when it starts booting and
>> ldrex/strex don't work. =A0I'm not convinced my implementation is
>> correct, and I'd be curious to see any other implementations.
>
> That's a problem you solved with coupled C-states (ie your example in
> the cover letter), where the primary waits for other CPUs to be reset
> before issuing the power down command, right ? At that point in time
> secondaries cannot wake up (?) and if wfi (ie power down) aborts you just
> take the secondaries out of reset and restart executing simultaneously,
> correct ? It mirrors the suspend behaviour, which is easier to deal with
> than completely random idle paths.

Yes, anything that supports hotplug and suspend should support coupled
cpuidle states fairly easily.  The only thing required that is not
already used by hotplug/suspend is the ability to save and restore
context on cpu1, but most implementations end up doing that already.

> It is true that this should be managed by the PM HW; if HW is not
> capable of managing these situations things get nasty as you highlighted.

Yes - on some platforms, the HW is not designed to handle it.  On
others, it is designed to, but due to HW bugs it cannot be used.

> And it is also true ldrex/strex on cacheable memory might not be availabl=
e in
> those early warm-boot stages. I came up with a locking algorithm on
> strongly ordered memory to deal with that, but I am still not sure it is
> something we really really need.

I did the same, but with device memory.

> I will test coupled C-state code ASAP, and come back with feedback.
>
> Thanks,
> Lorenzo
>
