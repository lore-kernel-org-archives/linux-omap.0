From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 05/19] OMAP3+: voltage: use IS_ERR_OR_NULL
Date: Mon, 07 Mar 2011 08:26:08 +0530
Message-ID: <4D744948.8000808@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com> <1299338962-5602-6-git-send-email-nm@ti.com> <AANLkTi=q_ASfvLbZv=D8p3XvuMX8ek3hcEHU5wtfkm7J@mail.gmail.com> <4D72F532.3020909@ti.com> <20110306081840.GB2400@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58482 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753934Ab1CGC4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Mar 2011 21:56:17 -0500
Received: by mail-yx0-f173.google.com with SMTP id 8so1638037yxk.32
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 18:56:16 -0800 (PST)
In-Reply-To: <20110306081840.GB2400@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: David Cohen <dacohen@gmail.com>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Russell King - ARM Linux wrote, on 03/06/2011 01:48 PM:
> On Sun, Mar 06, 2011 at 08:15:06AM +0530, Nishanth Menon wrote:
>> my_dumb_func(){
>> 	struct voltagedomain *vdata = NULL;
>> 	if (cpu_is_omap3630()_) {
>> 		vdata = omap_voltage_domain_lookup("mpu")
>> 	}
>> 	/* forgot to add other cpu types or a else case */
>> 	/* do other things */
>> 	me_volt=omap_voltage_get_nom_volt(vdata);
>> 	/* do things with me_volt */
>> }
>>
>> Sorry, but i think the check, even if seems superfluous is sane IMHO.
>> even if the above code worked on 3630, it'd fail on o4/3430 without the
>> check, it can even crash. and given that we've all seen our fair share
>> of developers who develop for one platform without consideration that
>> the rest of the world uses others as well... I do feel cases like above
>> example might infact be a reality.
>
> But normal practice is to check the return value from functions before
> it's used.  So:
>
>   my_dumb_func(){
> 	struct voltagedomain *vdata = NULL;
> 	if (cpu_is_omap3630()) {
> 		vdata = omap_voltage_domain_lookup("mpu")
> 	}
> 	/* forgot to add other cpu types or a else case */
>
> +	if (!vdata)
> +		return some error;
>
> 	/* do other things */
> 	me_volt=omap_voltage_get_nom_volt(vdata);
> 	/* do things with me_volt */
>   }
>
> is the right way to deal with this.  Pushing the primary error checking
> down into sub-functions is stupid - where does it stop?  Do you check
> me_volt for errors?  Do you get functions which use me_volt to check for
> errors from that too?
>
> It's a silly idea.  Put the primary error checking in the function which
> gets the return value.  Don't bury it in sub-functions.

I agree with you on this - sub functions esp static ones should able to 
trust the parameters passed to it by callers. for the moment, I suggest 
we drop this patch from this series - it has no functional impact to the 
overall goal which I was attempting to achieve. Cleanups of the voltage, 
smartreflex layers are an ongoing activity currently and should be 
takenup as part of it.

-- 
Regards,
Nishanth Menon
