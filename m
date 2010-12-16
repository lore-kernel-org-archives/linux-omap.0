From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5 v3] OMAP3630: PM: Erratum i583: disable coreoff if
 < ES1.2
Date: Wed, 15 Dec 2010 18:05:27 -0600
Message-ID: <4D0957C7.4010907@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>	<1291395818-8639-6-git-send-email-nm@ti.com>	<2cdf7d3d033ee2c88b6f2d4cfa37d9db@mail.gmail.com>	<4D0622FE.2070801@ti.com>	<d5e397dafb68b41ec5d7af591a18b044@mail.gmail.com>	<4D062806.6090201@ti.com>	<b7c3a82268b65ae1d9d09f377d9039f1@mail.gmail.com>	<4D062F81.407@ti.com>	<96505dfaee73d6785e153ccf5c2856d3@mail.gmail.com>	<6f507e24d6ae188e265913e85e815f82@mail.gmail.com>	<4D063344.2010001@ti.com>	<37de3932d97af8e1882a08dd37242a17@mail.gmail.com>	<4D063599.9080905@ti.com> <87ei9l10mk.fsf@deeprootsystems.com>	<4D0933C6.1060404@ti.com> <87wrnaions.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:60103 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755778Ab0LPAFb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 19:05:31 -0500
Received: by gxk20 with SMTP id 20so1577441gxk.6
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 16:05:31 -0800 (PST)
In-Reply-To: <87wrnaions.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>, Tony Lindgren <tony@atomide.com>

Kevin Hilman had written, on 12/15/2010 05:47 PM, the following:

>> I agree that this additional check in sram_idle should be removed, but
>> as long as I handle it in omap3_pm_off_mode_enable where the next
>> states are configured, is'nt that enough or am I missing something?
> 
> Setting the next states only sets the default states, but CPUidle
> changes them.
> 
> Looking closer at omap3_pm_off_mode_enable() though, it already calls
> into CPUidle and disables the valid bit for any states that have
> *either* MPU or core off.    You'll probably just need to extend this
> approach to disable only CORE off state(s).
Thx. it is clear now. let me see how to clean this up.

-- 
Regards,
Nishanth Menon
