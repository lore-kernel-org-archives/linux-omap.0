From: Tony Lindgren <tony@atomide.com>
Subject: Re: Booting 2.6.25 on the OMAP5912OSK
Date: Tue, 3 Jun 2008 09:49:27 -0700
Message-ID: <20080603164926.GC6992@atomide.com>
References: <4842D6FB.2050508@balister.org> <94533b41efbc9aa07c7893a0a7de3080@felipebalbi.com> <48455B16.3000506@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55245 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbYFCQtd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 12:49:33 -0400
Content-Disposition: inline
In-Reply-To: <48455B16.3000506@css-design.us>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Poulsen <spoulsen@css-design.us>
Cc: Felipe Balbi <me@felipebalbi.com>, Philip Balister <philip@balister.org>, linux-omap@vger.kernel.org

* Steve Poulsen <spoulsen@css-design.us> [080603 07:55]:
> I too am seeing this same problem.  Do you know when this was introduced  
> (kernel version)?  I am looking to update the kernel to address some  
> flashing issues, and this is the only issue that remains for me.  I am  
> thinking to revert back to the I2C of the version that should fix this  
> issue.
>
> Thanks!
>
> Felipe Balbi wrote:
>> Hi,
>>
>> On Sun, 01 Jun 2008 13:06:03 -0400, Philip Balister <philip@balister.org>
>> wrote:
>>   
>>> i2c_omap i2c_omap.1: Transmit overflow
>>> tps65010: power off button
>>>     
>>
>> Sounds like a bug in our i2c-omap.c
>>
>> Tony do you know about any issues with i2c-omap.c after
>> highspeed i2c was introduced ?
>>
>> This could be a regression, I remember seeing this on
>> some tests I was doing with twl4030 but they seemed
>> to vanish. Looks like I missed something. I'll try
>> to reproduce my bug with twl4030 and after that dig a
>> bit on i2c driver and i2c omap trms (ugh).
>>
>> Anyways, if you could enable all debugging in i2c and
>> get more info when it happens, that would be great ;-)

Hmm, yeah sounds like something is broken.. Anybody want to try to
narrow it down with git-bisect?

Tony
