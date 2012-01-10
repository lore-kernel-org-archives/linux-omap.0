From: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
Date: Tue, 10 Jan 2012 11:54:13 +0530
Message-ID: <CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
	<1323773758-6375-5-git-send-email-shubhrajyoti@ti.com>
	<alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com>
	<4EEB086A.2050607@ti.com>
	<CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 10, 2012 at 11:53 AM, Datta, Shubhrajyoti
<shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
>
>
>
> On Fri, Dec 16, 2011 at 2:29 PM, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> w=
rote:
>>
>> Ben,
>>
>> On Friday 16 December 2011 02:10 PM, Paul Walmsley wrote:
>> > Hi
>> >
>> > On Tue, 13 Dec 2011, Shubhrajyoti D wrote:
>> >
>> >> - =A0The reset in the driver at init is not needed anymore as the
>> >> =A0 =A0hwmod framework takes care of reseting it.
>> >> - =A0Reset is removed from omap_i2c_init, which was called
>> >> =A0 =A0not only during probe, but also after time out and error h=
andling.
>> >> =A0 =A0device_reset were added in those places to effect the rese=
t.
>> >> - =A0Earlier the hwmod SYSC settings were over-written in the dri=
ver.
>> >> =A0 =A0Removing the same and letting the hwmod take care of the s=
ettings.
>> >> - =A0Clean up the SYSS_RESETDONE_MASK macro as it is no longer ne=
eded.
>> >> - =A0Clean up the SYSCONFIG SYSC bit definition macros.
>> >> - =A0Fix the typos in wakeup.
>> >>
>> >> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> >> ---
>> >> =A0drivers/i2c/busses/i2c-omap.c | =A0 83 +++++++++++------------=
-----------------
>> >> =A01 files changed, 23 insertions(+), 60 deletions(-)
>> > This patch either needs to be acked by Ben with a note that it's o=
kay for
>> > us to merge through the OMAP tree, or needs to be merged by Ben du=
ring the
>> > 3.4 merge window, after patches 1-3 have reached the mainline tree=
=2E
>> I agree.
>> Ben do you have any comments .
>
>
If there are no further comments can this be merged also ?
Thanks.
>
>>
>> >
>> > - Paul
>>
>
