From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 08/10] ARM: OMAP5/DRA7: PM: cpuidle MPU CSWR support
Date: Wed, 17 Sep 2014 17:22:50 -0700
Message-ID: <541A25DA.8030101@linaro.org>
References: <1408716154-26101-1-git-send-email-nm@ti.com> <1408716154-26101-9-git-send-email-nm@ti.com>,<5419D7BD.30003@linaro.org> <448912EABC71F84BBCADFD3C67C4BE52CAC748@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <448912EABC71F84BBCADFD3C67C4BE52CAC748@DBDE04.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "J, KEERTHY" <j-keerthy@ti.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On 09/17/2014 04:20 PM, Shilimkar, Santosh wrote:
> Sorry for the format. Emailing from webmail.
> ________________________________________

[ ... ]

>> +static int omap_enter_idle_smp(struct cpuidle_device *dev,
>> +                            struct cpuidle_driver *drv,
>> +                            int index)
>> +{
>> +     struct idle_statedata *cx =3D state_ptr + index;
>> +     unsigned long flag;
>> +
>> +     raw_spin_lock_irqsave(&mpu_lock, flag);
>
> Why do you need this spin_lock_irqsave ? Aren't the local irqs alread=
y
> disabled ?
>
> [Santosh] Actually at one point of time before the idle consolidation=
 the local
> irq disable was inside the idle drivers. Now with that moved to core =
layer,
> I think plain spin_lock/unlock() should work.

ok.

>> +     cx->mpu_state_vote++;
>> +     if (cx->mpu_state_vote =3D=3D num_online_cpus()) {
>> +             pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
>> +             omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
>> +     }
>> +     raw_spin_unlock_irqrestore(&mpu_lock, flag);
>> +
>> +     omap4_enter_lowpower(dev->cpu, cx->cpu_state);
>> +
>> +     raw_spin_lock_irqsave(&mpu_lock, flag);
>> +     if (cx->mpu_state_vote =3D=3D num_online_cpus())
>> +             omap_set_pwrdm_state(mpu_pd, PWRDM_POWER_ON);
>> +     cx->mpu_state_vote--;
>> +     raw_spin_unlock_irqrestore(&mpu_lock, flag);
>
> I am not sure that will work. What happens if a cpu exits idle and th=
en
> re-enter idle immediately ?
>
> [Santosh] It works and that case is already taken care. CPU exist the=
 idle and then votes
> out for cluster state and if it reenters with the right targeted stat=
e, the cluster state would
> be picked.

It isn't possible to have one cpu disabling the coherency, while the=20
other one is looking for a lock ? Or eg. cpu0 is on WFI then cpu1 is th=
e=20
last entering idle. While cpu1 is entering 'lowpower', cpu0 exits the=20
wfi check the state vote and set the power domain on. In the meantime=20
cpu1 disables the coherency and cpu0 decrease the vote and release the=20
lock. Could be possible there is a very small racy window here ?

> Could you try a long run of this little program:
>
> https://git.linaro.org/power/pm-qa.git/blob/HEAD:/cpuidle/cpuidle_kil=
ler.c
>
> [Santosh] I am sure there will not be any issue with the long run tes=
t case here.
> Lets see if Nishant sees anything otherwise

Ok. Make sure the cpu is effectively entering your C2 state with the=20
sleep duration in the test program.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
