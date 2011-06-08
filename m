From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 10/10] OMAP2+: PM: init_voltages: handle
 non compliant bootloaders
Date: Tue, 7 Jun 2011 21:09:27 -0500
Message-ID: <BANLkTikHSygt9HW5dcB_J5DeoC3F0LFrHw@mail.gmail.com>
References: <BANLkTimDen6QWhmxkQ9WhCRoLoNGyeYNH7iyoCpJG-cQHSa3Sw@mail.gmail.com>
 <BANLkTimgn4PdHSEhViu5m4nABtfe-e4Qag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:56528 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978Ab1FHCJs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jun 2011 22:09:48 -0400
Received: by mail-ww0-f50.google.com with SMTP id 33so37572wwc.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 19:09:47 -0700 (PDT)
In-Reply-To: <BANLkTimgn4PdHSEhViu5m4nABtfe-e4Qag@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: l-o <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

On Tue, Jun 7, 2011 at 20:41, Menon, Nishanth <nm@ti.com> wrote:
> On Tue, Jun 7, 2011 at 20:12, Colin Cross <ccross@google.com> wrote:
>>> Bootloaders should in theory setup a frequency which is enabled in
>>> OPP table. However, there can be mismatches, and we should try
>>> both going lower in addition to the going higher to find
>>> a match if bootloader boots up at a OPP than the kernel thinks it
>>> should be allowed. We also sequence the frequency and voltage setti=
ngs
>>> properly.
>>>
>>> Reported-by: Colin Cross <ccross@google.com>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>> PS: Apologies on the spam.. for some reason 10/10 never appeared in
>>> http://marc.info/?l=3Dlinux-omap&r=3D2&b=3D201106&w=3D2 - grumble g=
rumble :(
>>>
>>> =A0arch/arm/mach-omap2/pm.c | =A0 55 ++++++++++++++++++++++++++++++=
++++++---------
>>> =A01 files changed, 44 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>>> index 7355347..ce7554b 100644
>>> --- a/arch/arm/mach-omap2/pm.c
>>> +++ b/arch/arm/mach-omap2/pm.c
>>> @@ -174,7 +174,9 @@ static int __init omap2_set_init_voltage(char *=
vdd_name, ch ar *clk_name,
>>> =A0 =A0 =A0 struct voltagedomain *voltdm;
>>> =A0 =A0 =A0 struct clk *clk;
>>> =A0 =A0 =A0 struct opp *opp;
>>> - =A0 =A0 unsigned long freq, bootup_volt;
>>> + =A0 =A0 unsigned long freq_cur, freq_valid, bootup_volt;
>>> + =A0 =A0 int raise_freq_idx, i;
>>> + =A0 =A0 int ret =3D -EINVAL;
>>>
>>> =A0 =A0 =A0 if (!vdd_name || !clk_name || !dev) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Invalid parameters=
!\n", __func__);
>>> @@ -195,16 +197,20 @@ static int __init omap2_set_init_voltage(char=
 *vdd_name, char *clk_name,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
>>> =A0 =A0 =A0 }
>>>
>>> - =A0 =A0 freq =3D clk->rate;
>>> - =A0 =A0 clk_put(clk);
>>> + =A0 =A0 freq_cur =3D clk->rate;
>>> + =A0 =A0 freq_valid =3D freq_cur;
>>>
>>> =A0 =A0 =A0 rcu_read_lock();
>>> - =A0 =A0 opp =3D opp_find_freq_ceil(dev, &freq);
>>> + =A0 =A0 opp =3D opp_find_freq_ceil(dev, &freq_valid);
>>> =A0 =A0 =A0 if (IS_ERR(opp)) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
>>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unable to find boot =
up OPP for vdd_%s\n",
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd_name);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 opp =3D opp_find_freq_floor(dev, &freq_va=
lid);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(opp)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: no boot OPP m=
atch for %ld on vdd_%s\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__,=
 freq_cur, vdd_name);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_ck;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 bootup_volt =3D opp_get_voltage(opp);
>>> @@ -212,11 +218,38 @@ static int __init omap2_set_init_voltage(char=
 *vdd_name, char *clk_name,
>>> =A0 =A0 =A0 if (!bootup_volt) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unable to find vol=
tage corresponding"
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "to the bootup OPP for =
vdd_%s\n", __func__, vdd_name);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 goto exit_ck;
>>> =A0 =A0 =A0 }
>>>
>>> - =A0 =A0 voltdm_scale(voltdm, bootup_volt);
>>> - =A0 =A0 return 0;
>>> + =A0 =A0 /*
>>> + =A0 =A0 =A0* Frequency and Voltage have to be sequenced: if we mo=
ve from
>>> + =A0 =A0 =A0* a lower frequency to higher frequency, raise voltage=
, followed by
>>> + =A0 =A0 =A0* frequency, and vice versa. we assume that the voltag=
e at boot
>>> + =A0 =A0 =A0* is the required voltage for the frequency it was set=
 for.
>>> + =A0 =A0 =A0*/
>>> + =A0 =A0 raise_freq_idx =3D freq_cur < freq_valid;
>>> + =A0 =A0 for (i =3D 0; i < 2; i++) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D raise_freq_idx)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_set_rate(clk,=
 freq_valid);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D voltdm_scale(volt=
dm, bootup_volt);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to set=
 %s-%s(f=3D%ld v=3D%ld)on vdd%s\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (i =3D=3D=
 raise_freq_idx) ? "clk" : "voltage",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (i =3D=3D=
 raise_freq_idx) ? clk_name : vdd_name,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq_vali=
d, bootup_volt, vdd_name);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_ck;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 }
>>
>> This is way too complicated. =A0Writing out what you mean is much mo=
re
>> readable, and not many more LOC:
> hmm.. fine with me..
>
>>
>> if (freq_cur < freq_valid) {
>> =A0 =A0 =A0 =A0ret =3D voltdm_scale(voltdm, bootup_volt);
>> =A0 =A0 =A0 =A0if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: unable to set voltage-%s(=
f=3D%ld v=3D%ld)on vdd%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd_name, freq_valid,=
 bootup_volt, vdd_name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_ck;
>> =A0 =A0 =A0 =A0}
>> }
>>
> optionally -
> if (freq_cur =3D=3D freq_valid) {
oops.. typo - intended:
if (freq_cur !=3D freq_valid) {
Since the get_rate already says that we are in proper freq, why do
set_rate again?

> =A0 > ret =3D clk_set_rate(clk, freq_valid);
> =A0 > if (ret) {
> =A0 > =A0 =A0 =A0 =A0pr_err("%s: unable to set clk-%s(f=3D%ld v=3D%ld=
)on vdd%s\n",
> =A0 > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_name, freq_valid, bootup_vol=
t, vdd_name);
> =A0 > =A0 =A0 =A0 =A0goto exit_ck;
> =A0 > }
> }
>>
>> if (freq_cur > freq_valid) {
> =A0since we dont really know how the bootloader might have set the
> voltage, (twl4030 allows i2c1 programming, others plugged on I2C_SR
> can either use forcedupdate/vc bypass, we should do a force setting o=
f
> voltage..
> if (freq_cur >=3D freq_valid) ?
>
>> =A0 =A0 =A0 =A0ret =3D voltdm_scale(voltdm, bootup_volt);
>> =A0 =A0 =A0 =A0if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: unable to set voltage-%s(=
f=3D%ld v=3D%ld)on vdd%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd_name, freq_valid,=
 bootup_volt, vdd_name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_ck;
>> =A0 =A0 =A0 =A0}
>> }
>>
>>> +
>>> + =A0 =A0 ret =3D 0;
>>> +exit_ck:
>>> + =A0 =A0 clk_put(clk);
>>> +
>>> + =A0 =A0 if (!ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>>
>>> =A0exit:
>>> =A0 =A0 =A0 printk(KERN_ERR "%s: Unable to put vdd_%s to its init v=
oltage\n\n",
>>> --
>>> 1.7.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>
>
>
> Regards,
> Nishanth Menon
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
