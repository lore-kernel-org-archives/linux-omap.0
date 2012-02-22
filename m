From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with frequency
Date: Wed, 22 Feb 2012 10:42:06 -0800
Message-ID: <87ehtm1zi9.fsf@ti.com>
References: <1329420043-32656-1-git-send-email-khilman@ti.com>
	<1329420043-32656-2-git-send-email-khilman@ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A931782571@DBDE01.ent.ti.com>
	<87vcmz3f63.fsf@ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A931784AE0@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36388 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752255Ab2BVSl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 13:41:57 -0500
Received: by mail-pw0-f52.google.com with SMTP id rp12so1622997pbb.25
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 10:41:55 -0800 (PST)
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A931784AE0@DBDE01.ent.ti.com>
	(Afzal Mohammed's message of "Wed, 22 Feb 2012 06:14:57 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>

"Mohammed, Afzal" <afzal@ti.com> writes:

> Hi Kevin,
>
> On Wed, Feb 22, 2012 at 05:36:12, Hilman, Kevin wrote:
>> In this case, volt comes from the OPP table, and was requested using a
>> rounding call into the OPP table, so the resolution problem is handled
>> there.  If 'volt' cannot be set by the regulator, then the OPP tables
>> are also broken.
>> 
>> Also, in your patch, you only add some offset.  If you want to be
>> approximate, shouldn't you have plus and minus?
>> 
>> IMO, we should let the OPP table handle that, and not the CPUfreq driver.
>
> I have a different opinion.
>
> Consider following case,
>
> Voltage to set for OPPX is 1262.5mV and regulator has steps of 10mV,
> and suppose regulator steps are .., 1260mV, 1270mV etc. Regulator
> framework will not be able to set voltage for OPPX (certainly if
> set_voltage_sel is used) if no range specified.
>
> But instead if range of 1262.5 - (1262.5 + 10 - 1) is provided,
> regulator can certainly set voltage for 1270mV (a nearest value)
>
> Resolution in my patch was not meant to be resolution per se, it was meant
> so that a voltage step can always be found for the regulator (assuming
> worst resolution is 12.5mV), and for regulator to get a step, resolution
> had to be used.

I agree, if the OPP table doesn't represent actual voltages, then some
sort of range needs to be used.

> Ideal solution may be to use a variable to have a default resolution
> of worst regulator and update it to that of regulator used (perhaps
> making use of something like module parameters)
>
> If regulator for a particular SoC is changed, exact OPP voltage may
> not be settable, but a near value should be sufficient, this can't be
> achieved if range is not specified. That happens exactly for AM335X,
> voltage for one of OPP is 1.26V, but as regulator cannot set the
> value, it is being set at 1.2625V and if no range is specified,
> it will not work.
>
> And in my patch plus - minus was not used as regulator framework will
> try to set voltage for the least voltage which sometimes corresponds
> to exact OPP required value.

sometimes?

Using your example above, what if the closest value was 1.259V?
Wouldn't you then need +/- range?

> For cpufreq omap driver to work with various regulators, it would be
> better to specify ranges.

I am fine with that, and am open for proposals.  Feel free to send a
patch on top of my v2.

>> I agree, my version is not very robust in the face of errors from the
>> regulator framework.
>> 
>> Hoever, I'm not crazy about the extra notifications in your proposed
>> patch.  I think it's cleaner to always pre and post notify.  If there's
>> a failure, the post notify will have the same freq as the pre-notify,
>> but that's not a big problem.
>
>
> Yes, agree that error handling path is bulky. 
>
> A problem that can happen is that drivers who has registered cpufreq
> notifier will think that frequency has changed, that may cause problem
> in addition to delay time getting altered.
>
> But whether these are worth handling with a penalty of bulky error
> handling, probably you know better.

Please have a look at my v2.

The drivers will get pre and post notifiers, with the caveat that upon
DVFS failure, the freq in the post notifier might be the same as the one
in the pre notifier, indicating that no change was made.

Kevin
