From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
Date: Tue, 10 Jan 2012 07:26:06 -0800
Message-ID: <87hb03tw8h.fsf@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
	<1323773758-6375-5-git-send-email-shubhrajyoti@ti.com>
	<alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com>
	<4EEB086A.2050607@ti.com>
	<CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com>
	<CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:51565 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753093Ab2AJP0K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 10:26:10 -0500
In-Reply-To: <CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com>
	(Shubhrajyoti Datta's message of "Tue, 10 Jan 2012 11:54:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, ben-linux@fluff.org

"Datta, Shubhrajyoti" <shubhrajyoti@ti.com> writes:

> On Tue, Jan 10, 2012 at 11:53 AM, Datta, Shubhrajyoti
> <shubhrajyoti@ti.com> wrote:
>>
>>
>>
>> On Fri, Dec 16, 2011 at 2:29 PM, Shubhrajyoti <shubhrajyoti@ti.com> =
wrote:
>>>
>>> Ben,
>>>
>>> On Friday 16 December 2011 02:10 PM, Paul Walmsley wrote:
>>> > Hi
>>> >
>>> > On Tue, 13 Dec 2011, Shubhrajyoti D wrote:
>>> >
>>> >> - =C2=A0The reset in the driver at init is not needed anymore as=
 the
>>> >> =C2=A0 =C2=A0hwmod framework takes care of reseting it.
>>> >> - =C2=A0Reset is removed from omap_i2c_init, which was called
>>> >> =C2=A0 =C2=A0not only during probe, but also after time out and =
error handling.
>>> >> =C2=A0 =C2=A0device_reset were added in those places to effect t=
he reset.
>>> >> - =C2=A0Earlier the hwmod SYSC settings were over-written in the=
 driver.
>>> >> =C2=A0 =C2=A0Removing the same and letting the hwmod take care o=
f the settings.
>>> >> - =C2=A0Clean up the SYSS_RESETDONE_MASK macro as it is no longe=
r needed.
>>> >> - =C2=A0Clean up the SYSCONFIG SYSC bit definition macros.
>>> >> - =C2=A0Fix the typos in wakeup.
>>> >>
>>> >> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>>> >> ---
>>> >> =C2=A0drivers/i2c/busses/i2c-omap.c | =C2=A0 83 +++++++++++-----=
------------------------
>>> >> =C2=A01 files changed, 23 insertions(+), 60 deletions(-)
>>> > This patch either needs to be acked by Ben with a note that it's =
okay for
>>> > us to merge through the OMAP tree, or needs to be merged by Ben d=
uring the
>>> > 3.4 merge window, after patches 1-3 have reached the mainline tre=
e.
>>> I agree.
>>> Ben do you have any comments .
>>
>>
> If there are no further comments can this be merged also ?

As Benoit mentioned earlier, the addition of new pdata fields will caus=
e
problems with the DT support already queued for v3.3.

This series should be reworked on top of the DT support which Ben has
now queued for v3.3 (my branch: for_3.3/i2c/misc)

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
