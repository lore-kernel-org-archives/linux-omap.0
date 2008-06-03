From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: Booting 2.6.25 on the OMAP5912OSK
Date: Tue, 03 Jun 2008 09:54:14 -0500
Message-ID: <48455B16.3000506@css-design.us>
References: <4842D6FB.2050508@balister.org> <94533b41efbc9aa07c7893a0a7de3080@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:45506 "EHLO
	elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495AbYFCOzP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 10:55:15 -0400
In-Reply-To: <94533b41efbc9aa07c7893a0a7de3080@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Philip Balister <philip@balister.org>, linux-omap@vger.kernel.org

I too am seeing this same problem.  Do you know when this was introduced 
(kernel version)?  I am looking to update the kernel to address some 
flashing issues, and this is the only issue that remains for me.  I am 
thinking to revert back to the I2C of the version that should fix this 
issue.

Thanks!

Felipe Balbi wrote:
> Hi,
>
> On Sun, 01 Jun 2008 13:06:03 -0400, Philip Balister <philip@balister.org>
> wrote:
>   
>> i2c_omap i2c_omap.1: Transmit overflow
>> tps65010: power off button
>>     
>
> Sounds like a bug in our i2c-omap.c
>
> Tony do you know about any issues with i2c-omap.c after
> highspeed i2c was introduced ?
>
> This could be a regression, I remember seeing this on
> some tests I was doing with twl4030 but they seemed
> to vanish. Looks like I missed something. I'll try
> to reproduce my bug with twl4030 and after that dig a
> bit on i2c driver and i2c omap trms (ugh).
>
> Anyways, if you could enable all debugging in i2c and
> get more info when it happens, that would be great ;-)
>
>   
