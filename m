From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/10] cpufreq: OMAP: Add SMP support for OMAP4+
Date: Thu, 29 Aug 2013 19:09:43 +0530
Message-ID: <CAKohpokqz0cQNS12hZS-YOCd8KSOtCy9_TbGdqFzCYz8NyeamQ@mail.gmail.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
	<1316725648-26710-3-git-send-email-khilman@ti.com>
	<CAOh2x=k11EivJoy5-PMXnE5JGDc=DcJKhae7qoh6tNc4L63VnA@mail.gmail.com>
	<521F4E88.1000709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:46524 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab3H2Njo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 09:39:44 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so441325oag.0
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 06:39:44 -0700 (PDT)
In-Reply-To: <521F4E88.1000709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Dave Jones <davej@redhat.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rajendra Nayak <rnayak@ti.com>

On 29 August 2013 19:07, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> On Thursday 29 August 2013 06:02 AM, Viresh Kumar wrote:

>> cpumask_setall(policy->cpus);
>>
> Thats should work I guess. Infact I changed this i downstream kernel
> a while back but forgot to send a patch. Just see if for some reason
> above can break UP machine since this driver is used on UP machines
> as well. Other than that, it should be fine

Atleast I can't see why it will break on UP machines as that should set
masks to individual CPUs then...

Okay I will fix that in my longest patchset ever... 230+ patches already :)
