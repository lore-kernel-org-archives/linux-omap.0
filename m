From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/10] ARM: OMAP5/DRA7: PM: cpuidle MPU CSWR support
Date: Thu, 18 Sep 2014 00:42:48 +0000
Message-ID: <448912EABC71F84BBCADFD3C67C4BE52CAC8B9@DBDE04.ent.ti.com>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
 <1408716154-26101-9-git-send-email-nm@ti.com>,<5419D7BD.30003@linaro.org>
 <448912EABC71F84BBCADFD3C67C4BE52CAC748@DBDE04.ent.ti.com>,<541A25DA.8030101@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <541A25DA.8030101@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "J, KEERTHY" <j-keerthy@ti.com>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org


________________________________________
=46rom: Daniel Lezcano [daniel.lezcano@linaro.org]
Sent: Wednesday, September 17, 2014 8:22 PM
To: Shilimkar, Santosh; Menon, Nishanth; Tony Lindgren; Kristo, Tero; P=
aul Walmsley
Cc: Kevin Hilman; linux-arm-kernel@lists.infradead.org; linux-omap@vger=
=2Ekernel.org; linux-kernel@vger.kernel.org; J, KEERTHY; Beno=EEt Couss=
on
Subject: Re: [PATCH 08/10] ARM: OMAP5/DRA7: PM: cpuidle MPU CSWR suppor=
t

On 09/17/2014 04:20 PM, Shilimkar, Santosh wrote:
> Sorry for the format. Emailing from webmail.
> ________________________________________

[ ... ]


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

It isn't possible to have one cpu disabling the coherency, while the
other one is looking for a lock ? Or eg. cpu0 is on WFI then cpu1 is th=
e
last entering idle. While cpu1 is entering 'lowpower', cpu0 exits the
wfi check the state vote and set the power domain on. In the meantime
cpu1 disables the coherency and cpu0 decrease the vote and release the
lock. Could be possible there is a very small racy window here ?

[Santosh] The coherency isn't disable by CPU. Thats actually taken care=
 by
hardware. CPU takes it own power domain down and takes itself out of
coherency. The Coherency is always ON as long as there is a CPU ON
and SMP bit on that CPU is enabled.

The scenario, you mentioned can never happen on this hardware thanks
to the inbuilt smart hardware.

If you have more questions, lets discuss. I am around here at connect. =
;-)

Regards,
Santosh--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
