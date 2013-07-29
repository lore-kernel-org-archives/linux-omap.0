From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/4] pinctrl: Add support for additional dynamic states
Date: Mon, 29 Jul 2013 16:01:59 -0600
Message-ID: <51F6E657.2060802@wwwdotorg.org>
References: <20130716090310.5541.36777.stgit@localhost> <20130716090536.5541.36289.stgit@localhost> <51E70953.1000601@wwwdotorg.org> <20130718072034.GO7656@atomide.com> <51E8401E.8040705@wwwdotorg.org> <20130719072927.GY7656@atomide.com> <51E98AEC.5000802@wwwdotorg.org> <20130729090524.GY7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130729090524.GY7656@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/29/2013 03:05 AM, Tony Lindgren wrote:
> * Stephen Warren <swarren@wwwdotorg.org> [130719 11:59]:
>> On 07/19/2013 01:29 AM, Tony Lindgren wrote:
>>>
>>> I'd vote for keeping the existing behaviour with pinctrl_select_state()
>>> when no active state is defined.
>>
>> Yes, I think that will work, since the active state cannot exist before
>> this new scheme is in place.
> 
> Right.
>  
>> But, this needs to be very clearly spell out in the DT binding
>> documentation: If you have states default/idle/sleep, they're complete
>> alternatives, whereas if you have states default/active/idle/sleep, the
>> latter 3 are alternatives that build on top of the first. I foresee mass
>> confusion, but perhaps I'm being pessimistic.
> 
> I'm hoping we can automate the runtime PM handling with default/active/idle
> completely from the consumer driver point of view. And then when that's
> working, we can probably deprecate any runtime PM related handling using
> pinctr_select_state() and print warnings. And we can also improve the
> documentation so no new users will use the default/idle/sleep for runtime
> PM unless they really want to.

I was thinking more about people writing the device trees that define
these states; they need to explicitly make the choice re: overlapping
states or independent states. We should not plan to obsolete any current
usage of overlapping states since that will mean an incompatible change
to the DT ABI (deprecate yes so that no more usage is added, but the
kernel should still support the old way).
