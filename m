From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [RFC][PATCHv3 1/2] SFH7741: proximity sensor driver support
Date: Thu, 13 May 2010 13:34:49 +0530 (IST)
Message-ID: <58209.10.24.255.17.1273737889.squirrel@dbdmail.itg.ti.com>
References: <0680EC522D0CC943BC586913CF3768C003B320A007@dbde02.ent.ti.com>
    <4BEAF03A.2070308@cam.ac.uk>
    <20100512182913.GC29366@core.coreip.homeip.net>
    <1273694895.15717.4.camel@lovely>
    <09ea01caf267$fe48d620$LocalHost@wipblrx0099946>
    <20100513075041.GB30110@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100513075041.GB30110@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Jonathan Cameron <jic23@cam.ac.uk>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> On Thu, May 13, 2010 at 12:16:16PM +0530, Hemanth V wrote:
>> ----- Original Message ----- From: "Christoph Fritz"
>> <chf.fritz@googlemail.com>
>> To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
>> Cc: "Jonathan Cameron" <jic23@cam.ac.uk>; "Datta, Shubhrajyoti"
>> <shubhrajyoti@ti.com>; <linux-input@vger.kernel.org>;
>> <linux-omap@vger.kernel.org>
>> Sent: Thursday, May 13, 2010 1:38 AM
>> Subject: Re: [RFC][PATCHv3 1/2] SFH7741: proximity sensor driver support
>>
>>
>> >On Wed, 2010-05-12 at 11:29 -0700, Dmitry Torokhov wrote:
>> >>On Wed, May 12, 2010 at 07:15:22PM +0100, Jonathan Cameron wrote:
>> >>> Hi,
>> >>>
>> >>> I was wondering if you could provide a bit more detail on what this
>> >>> driver is actually doing?  My appologies if I have missed a
>> >>> previous explanation.  If so, please add a Documentation file
>> >>> to explain what is going on.
>> >>>
>> >>> The driver you have here does virtually nothing itself.  It takes
>> >>> both its source of interrupt and read function from platform
>> >>> data. Given the value is always 0 or 1, I'm guessing you are
>> >>> simply reading a gpio pin. That makes this effectively a button
>> >>> and doesn't require any specific code.  The fact it is a
>> >>> proximity sensor isn't relevant to anything other than perhaps
>> >>> the name.
>> >>
>> >>Excellent point. Maybe it should simply use gpio_keys driver with
>> >>SW_FRONT_PROXIMITY code.
>> >>
>> >
>> >I had a look into the datasheet, this SFH 7741 has one Schmitt trigger
>> >output: So yes, it's a "key" even without chatter.
>> >
>> Output being configured as GPIO  is specific to OMAP4 board, SFH7741
>> doesnot really
>> mandate this. The idea behind this driver is to provide a generic
>> interface and
>> hooks for platform specific configuration.
>>
>
> Realistically, what are the options though? The only sane solution is to
> hook it to a GPIO pin, isn't it?
>

One option I could think of is that output could be configured directly as
an interrupt line, rather than a gpio based interrupt. Yes, probably
gpio would be the most used option, but it would be good to make the driver
generic





