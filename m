From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 01/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
Date: Wed, 2 May 2012 15:48:01 +0530
Message-ID: <CAMQu2gwCstL6eF92_QBDYZaA5xwxD9a+YWRVxdghA5WVkp4PEQ@mail.gmail.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-2-git-send-email-t-kristo@ti.com> <B5906170F1614E41A8A28DE3B8D121433EA6B68E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:41486 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab2EBKSY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 06:18:24 -0400
Received: by obceq6 with SMTP id eq6so1124305obc.37
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 03:18:23 -0700 (PDT)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA6B68E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 2, 2012 at 3:40 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> w=
rote:
> Hi Tero,
>
> On Fri, Apr 20, 2012 at 15:03:34, Kristo, Tero wrote:
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> SAR/ROM code restores only CORE DPLL to its original state
>> post wakeup from OFF mode.
>> The rest of the DPLL's in OMAP4 platform (MPU/IVA/ABE/USB/PER)
>> are saved and restored here during an OFF transition.
>>
>
> Most of the registers being saved and restored in the various
> patches look to be contiguous. So, instead of a long list of these
> contiguous registers how about having a generic API for backup and
> restore of the registers contents based on the memory address range?
>
> Most of the registers which require save and restore are either part
> of PRM, CM or Control. The PRM or CM instance could be passed as the
> base and the save/restore API could work around that.
>
> One downside is that there are some read-only registers in between bu=
t
> I don't see any simple way of avoiding save and restore of those. BTW=
,
> as per the TRM that I have, this patch is also doing save and restore
> of some read-only registers.
>
You should never write to read-only registers since the behavior is
undefined.

[...]
>> +void omap4_dpll_resume_off(void)
>> +{
>> + =A0 =A0 u32 i;
>> + =A0 =A0 struct omap4_dpll_regs *dpll_reg =3D dpll_regs;
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(dpll_regs); i++, dpll_reg++) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->clksel);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->div_m2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->div_m3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->div_m4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->div_m5);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->div_m6);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->div_m7);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->clkdcoldo);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Restore clkmode after the above registe=
rs are restored */
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->clkmode);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_wait_dpll_lock(dpll_reg);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Restore autoidle settings after the dpl=
l is locked */
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_dpll_restore_reg(dpll_reg, &dpll_reg=
->autoidle);
>> + =A0 =A0 }
>> +}
>
> If this function is placed in SRAM and PER PLL restored just after MP=
U
> won't the exit latency be further optimized?
>
How ?
SRAM is sower memory than DDR so I don't see how it
will reduce latency.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
