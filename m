From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with frequency
Date: Tue, 21 Feb 2012 16:06:12 -0800
Message-ID: <87vcmz3f63.fsf@ti.com>
References: <1329420043-32656-1-git-send-email-khilman@ti.com>
	<1329420043-32656-2-git-send-email-khilman@ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A931782571@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34974 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753122Ab2BVAGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 19:06:04 -0500
Received: by mail-pz0-f45.google.com with SMTP id p14so9186152dad.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 16:06:03 -0800 (PST)
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A931782571@DBDE01.ent.ti.com>
	(Afzal Mohammed's message of "Fri, 17 Feb 2012 07:35:55 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>

"Mohammed, Afzal" <afzal@ti.com> writes:

> Hi Kevin,
>
> On Fri, Feb 17, 2012 at 00:50:43, Hilman, Kevin wrote:
>> +	/* scaling up?  scale voltage before frequency */
>> +	if (mpu_reg && (freqs.new > freqs.old))
>> +		regulator_set_voltage(mpu_reg, volt, volt);
>
> Probably voltage ranges has to be specified, otherwise
> if I understand correctly,  if exact voltage 'volt'
> is a value that cannot be set by voltage regulator,
> it may not work properly.

In this case, volt comes from the OPP table, and was requested using a
rounding call into the OPP table, so the resolution problem is handled
there.  If 'volt' cannot be set by the regulator, then the OPP tables
are also broken.

Also, in your patch, you only add some offset.  If you want to be
approximate, shouldn't you have plus and minus?

IMO, we should let the OPP table handle that, and not the CPUfreq driver.

>>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>> -	freqs.new = omap_getspeed(policy->cpu);
>>  
>> +	/* scaling down?  scale voltage after frequency */
>> +	if (mpu_reg && (freqs.new < freqs.old))
>> +		regulator_set_voltage(mpu_reg, volt, volt);
>> +
>> +	freqs.new = omap_getspeed(policy->cpu);
>
> It would be better to handle error cases too,
> we have a patch for doing DVFS for AM335X as follows

I agree, my version is not very robust in the face of errors from the
regulator framework.

Hoever, I'm not crazy about the extra notifications in your proposed
patch.  I think it's cleaner to always pre and post notify.  If there's
a failure, the post notify will have the same freq as the pre-notify,
but that's not a big problem.

I'll send an updated patch that follows this approach instead:

- pre notify

- scale volage up
  - if fail, goto done

- scale freq

- scale voltage down
  - if fail
    - scale freq back
    - goto done

- SMP jiffies magic

done:
- post notify


Kevin
