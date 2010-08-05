From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 3/6] TI816X: Update common OMAP machine specific sources
Date: Thu, 5 Aug 2010 19:30:32 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E5E4F8D@dbde02.ent.ti.com>
References: <1280523112-25081-1-git-send-email-hemantp@ti.com>
 <87wrs541bu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55722 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758599Ab0HEOAj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 10:00:39 -0400
In-Reply-To: <87wrs541bu.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Kevin Hilman wrote:
> Hemant Pedanekar <hemantp@ti.com> writes:
> 
>> This patch updates the common machine spcific source files with support
>> for TI816X. 
>> 
>> Note that the nr_irqs is overridden in INTC driver since the number of
>> IRQs on TI816X are different (128) comapared to other OMAPs (96).
>> 
>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> 
> One minor issue below...
> 
> [...]
> 
>> @@ -899,10 +899,10 @@ void omap2_clkdm_allow_idle(struct clockdomain
>> *clkdm) 
>> 
>>  	/*
>>  	 * XXX This should be removed once TI adds wakeup/sleep
>> -	 * dependency code and data for OMAP4.
>> +	 * dependency code and data for OMAP4, TI816X
>>  	 */
>> -	if (cpu_is_omap44xx()) {
>> -		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
>> +	if (cpu_is_omap44xx() || cpu_is_ti816x()) {
>> +		WARN_ONCE(1, "clockdomain: wakeup/sleep dependency "
>>  			  "support is not yet implemented\n");
>>  	} else {
>>  		if (atomic_read(&clkdm->usecount) > 0)
>> @@ -941,9 +941,9 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
>> 
>>  	/*
>>  	 * XXX This should be removed once TI adds wakeup/sleep
>> -	 * dependency code and data for OMAP4.
>> +	 * dependency code and data for OMAP4, TI816X.
>>  	 */
>> -	if (cpu_is_omap44xx()) {
>> +	if (cpu_is_omap44xx() || cpu_is_ti816x()) {
>>  		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
> 
> Did you want to remove the 'OMAP4' here as you did in the hunk above?
> 
> Kevin

Yes, I will fix that in v2.

Thanks
-
Hemant

