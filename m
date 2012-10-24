From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Wed, 24 Oct 2012 11:01:02 +0200
Message-ID: <5087AE4E.7000104@compulab.co.il>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com> <87r4oqc833.fsf@deeprootsystems.com> <87objt8305.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:37566 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933529Ab2JXJBI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:01:08 -0400
In-Reply-To: <87objt8305.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/23/12 20:19, Kevin Hilman wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
>> +Igor
>>
>> Paul Walmsley <paul@pwsan.com> writes:
>>
>>> Here are some basic OMAP test results for Linux v3.7-rc2.
>>> Logs and other details at:
>>>
>>>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/
>>
>> [...]
>>
>>> * 37xx EVM: CORE not entering dynamic off-idle
>>>   - Cause unknown; dynamic retention-idle seems to work; system suspend to 
>>>     off works
>>
>> I got a start on this one, and discovered (using CM_IDLEST1_CORE) that
>> SPI1 was not idle when going off.  A quick hack disabling the
>> touchscreen showed that after that, core was hitting idle just fine.
>>
>> I ran out of time today debugging this, but it's definitely realted to
>> the GPIO debounce setting for the touchscreen.  Changing it to zero[1]
>> makes CORE hit retention again in idle.
> 
> OK, found the root cause of this in the GPIO driver.  Patch submitted:
> 
>     http://marc.info/?l=linux-omap&m=135101577925972&w=2

Ok that one looks good.

> 
> however...
> 
>> Igor, I'm hoping you might know what's going on here since we already
>> had some problems with this ads7846 init stuff and you're more familiar
>> with this debounce init.
> 
> ... board files that are setting debounce values for ads7846 will no
> longer work.  
> 
> Currently, omap_ads7846_init() in common-board-devices.c does this:
> 
>    gpio_request_one()
>    gpio_set_debounce()
>    gpio_free()                    
> 
> because of a bug in the GPIO driver, the debounce settings were sticky
> and lingered even after the gpio_free().  That bug has been fixed by the
> above patch, which means the above gpio_set_debounce() is completely
> pointless because it's followed immediately by a gpio_free().
> 
> IMO, the whole GPIO init for the ads7846 needs a rethink as it's
> currently partially done by common-board-devices.c and done (again) in
> the ads7846 driver.  If the gpio_free() isn't done in
> common-board-devices, then the ads7846 driver will currently fail to
> probe/load becasue it can't request a GPIO line.
> 
> Having found and fixed the PM regression, I'll leave the ads7846 cleanup to
> somone else.

Ok, understood, I'll look into this one soon.


-- 
Regards,
Igor.
