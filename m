From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/4] usb: musb: am35x: use SIMPLE_DEV_PM_OPS
Date: Fri, 27 Sep 2013 20:47:10 +0200
Message-ID: <5245D2AE.6030400@gmail.com>
References: <1379850421-7966-1-git-send-email-zonque@gmail.com> <20130923212009.GK309@radagast> <524137C4.1000104@gmail.com> <20130925134811.GH10746@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:38013 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab3I0SrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Sep 2013 14:47:15 -0400
In-Reply-To: <20130925134811.GH10746@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-ubs@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org

On 25.09.2013 15:48, Felipe Balbi wrote:
> On Tue, Sep 24, 2013 at 08:57:08AM +0200, Daniel Mack wrote:
>> On 23.09.2013 23:20, Felipe Balbi wrote:
>>> On Sun, Sep 22, 2013 at 01:46:58PM +0200, Daniel Mack wrote:
>>
>>>> -static struct dev_pm_ops am35x_pm_ops = {
>>>> -	.suspend	= am35x_suspend,
>>>> -	.resume		= am35x_resume,
>>>> -};
>>>> +static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);
>>>
>>> you could as well remove the DEV_PM_OPS trickery. Ditto for all other
>>> patches
>>
>> Yes, I noticed that too. That's why I sent out a v2 of the series :)
> 
> Awesome :-) Thanks dude

So are you happy with this v2?
It's just a cosmetic cleanup after all ...


Thanks,
Daniel

