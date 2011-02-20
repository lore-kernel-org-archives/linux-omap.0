From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 15/19] omap3+: sr: introduce notifier_control
Date: Sun, 20 Feb 2011 10:20:14 +0530
Message-ID: <4D609D86.8040608@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <1298116918-30744-16-git-send-email-nm@ti.com> <765c3f6e8053293455100f296fb76ae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33957 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753322Ab1BTEuY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 23:50:24 -0500
Received: by ywi6 with SMTP id 6so676955ywi.2
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 20:50:21 -0800 (PST)
In-Reply-To: <765c3f6e8053293455100f296fb76ae5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

Vishwanath Sripathy wrote, on 02/19/2011 07:10 PM:

>> +int sr_notifier_control(struct voltagedomain *voltdm, bool enable)
>> +{
>> +	struct omap_sr *sr = _sr_lookup(voltdm);
>> +	u32 value = 0;
>> +	if (IS_ERR_OR_NULL(sr)) {
>> +		pr_warning("%s: sr corresponding to domain not found\n",
>> +				__func__);
>> +		return -EINVAL;
>> +	}
>> +	if (!sr->autocomp_active)
>> +		return -EINVAL;
> Why you do you return here? Class driver should still be able to place
> it's request even if sr is disabled though it will be effective only after
> sr is enabled.

my intents were as following: which useful event would come without SR 
avs being enabled? what kind of event do you expect with the AVS 
disabled which is useful for class driver, whose clase init alone was 
called and not class enable?

-- 
Regards,
Nishanth Menon
