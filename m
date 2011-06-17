From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 09/10] OMAP2+: PM: secure OPP access
 using rcu locks
Date: Thu, 16 Jun 2011 19:39:09 -0500
Message-ID: <BANLkTikmRV98Y=A9iatVPRL62S5bB1uOzA@mail.gmail.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com> <1307412972-25854-10-git-send-email-nm@ti.com>
 <87d3idh5bq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:43070 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756701Ab1FQAjb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 20:39:31 -0400
Received: by wyf22 with SMTP id 22so795809wyf.9
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 17:39:29 -0700 (PDT)
In-Reply-To: <87d3idh5bq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, Jun 16, 2011 at 15:47, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> OPP functions as described in Documentation/power/opp.txt
>> should be accessed under rcu_locks.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> This looks like a fix needed in mainline.
>
> Please send as a standalone patch against mainline and Cc
> linux-arm-kernel.
ok will do.

Regards,
Nishanth Menon

>
> Thanks,
>
> Kevin
>
>> ---
>> =A0arch/arm/mach-omap2/pm.c | =A0 =A03 +++
>> =A01 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index d085f29..7355347 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -198,14 +198,17 @@ static int __init omap2_set_init_voltage(char =
*vdd_name, char *clk_name,
>> =A0 =A0 =A0 freq =3D clk->rate;
>> =A0 =A0 =A0 clk_put(clk);
>>
>> + =A0 =A0 rcu_read_lock();
>> =A0 =A0 =A0 opp =3D opp_find_freq_ceil(dev, &freq);
>> =A0 =A0 =A0 if (IS_ERR(opp)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unable to find boot=
 up OPP for vdd_%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd_name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 bootup_volt =3D opp_get_voltage(opp);
>> + =A0 =A0 rcu_read_unlock();
>> =A0 =A0 =A0 if (!bootup_volt) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unable to find volt=
age corresponding"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "to the bootup OPP for v=
dd_%s\n", __func__, vdd_name);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
