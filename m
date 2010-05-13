From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [RFC][PATCHv3 1/2] SFH7741: proximity sensor driver support
Date: Thu, 13 May 2010 12:16:16 +0530
Message-ID: <09ea01caf267$fe48d620$LocalHost@wipblrx0099946>
References: <0680EC522D0CC943BC586913CF3768C003B320A007@dbde02.ent.ti.com> <4BEAF03A.2070308@cam.ac.uk> <20100512182913.GC29366@core.coreip.homeip.net> <1273694895.15717.4.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Christoph Fritz" <chf.fritz@googlemail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Jonathan Cameron" <jic23@cam.ac.uk>; "Datta, Shubhrajyoti" 
<shubhrajyoti@ti.com>; <linux-input@vger.kernel.org>; 
<linux-omap@vger.kernel.org>
Sent: Thursday, May 13, 2010 1:38 AM
Subject: Re: [RFC][PATCHv3 1/2] SFH7741: proximity sensor driver support


> On Wed, 2010-05-12 at 11:29 -0700, Dmitry Torokhov wrote:
>> On Wed, May 12, 2010 at 07:15:22PM +0100, Jonathan Cameron wrote:
>> > Hi,
>> >
>> > I was wondering if you could provide a bit more detail on what this
>> > driver is actually doing?  My appologies if I have missed a
>> > previous explanation.  If so, please add a Documentation file
>> > to explain what is going on.
>> >
>> > The driver you have here does virtually nothing itself.  It takes
>> > both its source of interrupt and read function from platform
>> > data. Given the value is always 0 or 1, I'm guessing you are
>> > simply reading a gpio pin. That makes this effectively a button
>> > and doesn't require any specific code.  The fact it is a
>> > proximity sensor isn't relevant to anything other than perhaps
>> > the name.
>>
>> Excellent point. Maybe it should simply use gpio_keys driver with
>> SW_FRONT_PROXIMITY code.
>>
>
> I had a look into the datasheet, this SFH 7741 has one Schmitt trigger
> output: So yes, it's a "key" even without chatter.
>
Output being configured as GPIO  is specific to OMAP4 board, SFH7741 doesnot 
really
mandate this. The idea behind this driver is to provide a generic interface 
and
hooks for platform specific configuration.

Will using gpio_keys make this very specific to platform configuration.

Thanks
Hemanth

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

