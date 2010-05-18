From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2] OMAP3: PM: Workaround for DPLL3 Lock issue
Date: Tue, 18 May 2010 09:36:35 -0700
Message-ID: <87hbm5qi98.fsf@deeprootsystems.com>
References: <1273745535-27139-1-git-send-email-shweta.gulati@ti.com>
	<87hbmajrgh.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608703051ADC7D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52207 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434Ab0ERQgi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 12:36:38 -0400
Received: by pva18 with SMTP id 18so524786pva.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 09:36:37 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703051ADC7D@dbde02.ent.ti.com> (Vishwanath Sripathy's message of "Tue\, 18 May 2010 21\:10\:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "Gulati, Shweta" <shweta.gulati@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Sripathy, Vishwanath" <vishwanath.bs@ti.com> writes:

>> All that being said, why is the voltage level being programmed here?
>> 
>> It seems to me that all of this errata handling should be
>> self-contained in the voltage layer.
>
> I am not sure if entire errata can be contained in voltage
> layer. This is because we are performing DVFS operation in CPU Idle
> path which involves both Frequency and Voltage scaling. So currently
> this has been done in resource34xx.c where DVFS is implemented.

What I mean is that there seems to be no good reason to be calling
these from pm34xx.c, they should be called where voltage scaling is
done.

Kevin

