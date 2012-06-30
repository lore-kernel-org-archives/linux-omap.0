From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v4 4/4] memory: emif: add device tree support to emif driver
Date: Sat, 30 Jun 2012 10:12:21 +0530
Message-ID: <CAMQu2gy0MmP4JLW4P1FreJqMMEBYSTjkLHJb8WX=aXLA6hxtZg@mail.gmail.com>
References: <1340977407-7594-1-git-send-email-santosh.shilimkar@ti.com>
 <1340977407-7594-5-git-send-email-santosh.shilimkar@ti.com>
 <CAMQu2gz6jdcR4hQPPbmyO8vrkdmppHeCkZmV3_9w27LOzKrUuA@mail.gmail.com> <20120630042356.GC1816@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:42006 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858Ab2F3Emn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Jun 2012 00:42:43 -0400
Received: by qcmv28 with SMTP id v28so2541215qcm.39
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 21:42:41 -0700 (PDT)
In-Reply-To: <20120630042356.GC1816@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>, tony@atomide.com

On Sat, Jun 30, 2012 at 9:53 AM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> On Sat, Jun 30, 2012 at 09:38:41AM +0530, Shilimkar, Santosh wrote:
>> (+ Greg, By mistake the your name got dropped cc from list)
>>
>> On Fri, Jun 29, 2012 at 7:13 PM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>> > From: Aneesh V <aneesh@ti.com>
>> >
>> > Device tree support for the EMIF driver.
>> >
>> > Reviewed-by: Benoit Cousson <b-cousson@ti.com>
>> > Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
>> > Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
>> > Signed-off-by: Aneesh V <aneesh@ti.com>
>> > [santosh.shilimkar@ti.com: Rebased against 3.5-rc]
>> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > ---
>> > =A0drivers/memory/emif.c | =A0291 ++++++++++++++++++++++++++++++++=
++++++++++++++++-
>> > =A01 file changed, 290 insertions(+), 1 deletion(-)
>
> Wouldn't this just be better off as a separate file that only gets bu=
ild
> if CONFIG_OF is set, as I'm sure that other systems are going to want
> access to these "read the device tree values" functions, right?
>
Probably yes. At least separate the LPDDR2 memory
generic parameter DT read code. There are parameters like phy
type which is specific to OMAP controllers so that still need to kept
inside EMIF driver. So there in driver, few lines of code will be there
under CONFIG_OF.

I can extract those functions which can be commonly used and put them
in another file under drivers/memory/

Is that fine with you ?

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
