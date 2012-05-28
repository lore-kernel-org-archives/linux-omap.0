From: Ming Lei <ming.lei@canonical.com>
Subject: Re: Ftrace Timer on OMAP3
Date: Mon, 28 May 2012 16:24:35 +0800
Message-ID: <CACVXFVMg140Tj0cAH8aWD7VROgody7E+mEe0pNyou7hpfJUr9w@mail.gmail.com>
References: <4FBFA2EB.708@uni-dortmund.de>
	<79CD15C6BA57404B839C016229A409A83EA38110@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47021 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab2E1IYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 May 2012 04:24:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SYvFl-0002Qg-Rt
	for linux-omap@vger.kernel.org; Mon, 28 May 2012 08:24:38 +0000
Received: by pbbrp8 with SMTP id rp8so4368101pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 28 May 2012 01:24:35 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA38110@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Thomas Klute <thomas2.klute@uni-dortmund.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Carsten Vogel <carsten.vogel@rub.de>

On Mon, May 28, 2012 at 2:56 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> On Fri, May 25, 2012 at 20:49:07, Thomas Klute wrote:
>> Hi everyone,
>>
>> we're having some trouble getting useful results from Ftrace on OMAP3
>> (Gumstix Overo). As you can see in the example output below, function
>> duration can't be displayed with a precision higher than about 30.5 us,
>> which matches the frequency of the 32 kHz platform timer. For OMAP1,
>> using OMAP_MPU_TIMER instead of CONFIG_OMAP_32K_TIMER should provide
>> better results [1], but I couldn't find anything similar for OMAP3. Just
>> setting CONFIG_OMAP_32K_TIMER=N didn't change the results. Did I miss
>> anything, or isn't there any more precise timer?
>>
>
> I believe you are using mainline kernel here, if yes, you should be enabling
> the dmtimer using commandline argument, "clocksource="gp_timer".

Also you need to pass 'nohlt' to kernel since gp_timer can't be kept
when cpu is idled in deep state.

Thanks,
--
Ming Lei
