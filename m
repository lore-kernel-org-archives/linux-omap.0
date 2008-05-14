From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/3] N810: Don't export camera orientation
Date: Thu, 15 May 2008 01:58:23 +0300
Message-ID: <20080514225823.GF1582@kedavra.cpe.vivax.com.br>
References: <12106946631016-git-send-email-sakari.ailus@nokia.com> <1210694663310-git-send-email-sakari.ailus@nokia.com> <20147cff763adbdb887ad31373040efc@felipebalbi.com> <482AD555.40905@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33314 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbYENW5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 18:57:33 -0400
Content-Disposition: inline
In-Reply-To: <482AD555.40905@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org

On Wed, May 14, 2008 at 03:04:37PM +0300, Sakari Ailus wrote:
> ext Felipe Balbi wrote:
>
> Hello Felipe, and thanks for reviewing the patch! :)
>
>> On Tue, 13 May 2008 19:04:22 +0300, Sakari Ailus <sakari.ailus@nokia.com>
>> wrote:
>>> @@ -298,12 +340,21 @@ static int tcm825x_ifparm(struct v4l2_ifparm *p)
>>>  	return 0;
>>>  }
>>>
>>> +static int tcm825x_is_upside_down(void)
>>> +{
>>> +	if (machine_is_nokia_n810())
>>> +		return 1;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  const struct tcm825x_platform_data n800_tcm825x_platform_data = {
>>> -	.is_okay      = tcm825x_is_okay,
>>> -	.power_set    = tcm825x_power_set,
>>> -	.default_regs = tcm825x_default_regs,
>>> -	.needs_reset  = tcm825x_needs_reset,
>>> -	.ifparm	      = tcm825x_ifparm,
>>> +	.is_okay	= tcm825x_is_okay,
>>> +	.power_set	= tcm825x_power_set,
>>> +	.default_regs	= tcm825x_default_regs,
>>> +	.needs_reset	= tcm825x_needs_reset,
>>> +	.ifparm		= tcm825x_ifparm,
>>> +	.is_upside_down	= tcm825x_is_upside_down,
>>
>> ok, now i got your point but this could be:
>> .is_upside_down = machine_is_nokia_n810() ? 1 : 0,
>
> This doesn't work because machine_is_nokia_n810() is not constant.
>
> Anyway, tcm825x_is_upside_down can be made more simple as it could just  
> return machine_is_nokia_n810().
>
> I'll send new patches.

Didn't quite get, machine_is_nokia_n810() will always be true when
running in n810. Could you clarify a bit :-p

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
