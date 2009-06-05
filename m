From: Nishanth Menon <menon.nishanth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH][RFC] OMAP4: I2C Support for OMAP_4430SDP
Date: Thu, 4 Jun 2009 21:28:15 -0500
Message-ID: <782515bb0906041928q385c079ayf3ad37a8a857e9d4@mail.gmail.com>
References: <55272.192.168.10.89.1243607905.squirrel@dbdmail.itg.ti.com>
	 <878wkghqzi.fsf@deeprootsystems.com>
	 <782515bb0905291052h1d70be5em7cfdeeda903c39fc@mail.gmail.com>
	 <561678670906041441y4c592e61h71fd3cf6869bcf46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <561678670906041441y4c592e61h71fd3cf6869bcf46-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jagadeesh Bhaskar Pakaravoor <jagadeeshbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 4, 2009 at 4:41 PM, Jagadeesh Bhaskar Pakaravoor
<jagadeeshbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> why is this 2600? omap3 could do 3.3Mhz.
>>
> There is a silicon issue reported on TWL5030 which says that it can
> not operate at the stipulated highest frequency of 3.3MHz.
>
> The information I got is this:
> "I2C data hold time in HS mode is higher than specification when
> reading I2C registers. This leads to a data setup issue which
> introduces a frequency limitation in HS mode (can not reach 3.4MHz as
> specified in I2C standard). The limitation is for the Control I2C, and
> for SmartReflex I2C when using other products than OMAP34xx with SR.
> HS mode is working OK for SR I2C when using OMAP34xx."
>
Is this bug valid for OMAP4 already :) ? Is'nt it a bit early to post
erratas  :D...
btw, the topic was on OMAP4 I2C.. the point i was driving at is this:
we need options to do:
A) provide speed parameter per bus at a board level (which is implemented now).
or
B) also provide flexibility, when so desired to provide scll and sch
values per bus for the board.

Rationale:
a) using i2c speed is not a scalable technique to handle varied i2c
bus conditions -> what if you have 1 foot wiring to the i2c device?
b) bus capacitance and other factors have to be considered.
c) we need some mechanism to allow a board specific configuration of
i2c scll sclh (fast and hs mode) to be configurable for platform bus
-> note, in a bus with multiple devices, you need to measure the least
common factor -> the default equations may not scale well.
d) At the same time, ability which is in the driver today -
essentially to be able to provide speed as a i2c module parameter
should be scaled accross when we provide flexibility for i2c scll and
sclh value configuration..
e) for boards which are fine with default equations, the current
mechanism of providing speeds as parameter should be retained.

Unless we ensure we do it as part of initial driver, we will fall into
OMAP3 trap of inflexibility.. just my 2 cents

Regards,
Nishanth Menon
