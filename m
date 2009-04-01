From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch rebased to 2.6.29... for real this time
Date: Wed, 01 Apr 2009 11:46:31 -0700
Message-ID: <87bprgjjp4.fsf@deeprootsystems.com>
References: <87k56dp5zc.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC5F02C1@dbde02.ent.ti.com>
	<87ljqllzz9.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC5F069A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:58527 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933671AbZDASqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 14:46:35 -0400
Received: by wf-out-1314.google.com with SMTP id 29so183556wff.4
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2009 11:46:34 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC5F069A@dbde02.ent.ti.com> (Sanjeev Premi's message of "Wed\, 1 Apr 2009 12\:48\:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

"Premi, Sanjeev" <premi@ti.com> writes:

[...]

>> Sounds to me like CPUfreq is changing frequencies during bootup.  Did
>> you select ondemand as the default CPUfreq governor?
>
> [sp] Yes. This is what I feel too. Only I was not clear why the process
> gets stuck at WFI. Haven't been able to debug further. So far...
>
>> If so, can you try with performance as the default governor.
>
> [sp] It was performance governor only.
>
>> If you're already using performance, then u-boot is setting a slower
>> speed and CPUfreq may decide to change it during boot.
>
> [sp] That is the case.
>

Can you try setting the default governor to userspace so that no DVFS
changes will happen during boot?

Kevin
