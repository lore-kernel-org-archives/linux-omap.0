From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
Date: Wed, 13 Aug 2008 16:12:09 +0300
Message-ID: <87wsil2h5i.fsf@trdhcp146196.ntc.nokia.com>
References: <00ad01c8fd09$6bcdc6c0$LocalHost@wipultra1382>
	<87k5el5rqd.fsf@trdhcp146196.ntc.nokia.com>
	<13B9B4C6EF24D648824FF11BE896716203620A5686@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35412 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbYHMNMn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 09:12:43 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203620A5686@dlee02.ent.ti.com>
	(ext Woodruff's message of "Wed, 13 Aug 2008 07:35:30 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Richard,

"ext Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> >> Doing this would make serial console to work faster.
>> >
>> > Yes, I removed these in my patches and put in the changes suggeste=
d by
>> Richard
>> > in 8250.c
>>
>> I doubt that your changes to 8250.c will be applied. I have understo=
od
>> that omap specific changes are not accepted to generic 8250
>> driver. Anyway these changes doesn't help too much. Serial console i=
s
>> annoyingly slow if sleep while idle is enabled.
>
> Rajendra is it slow in your current builds on this tree with fixes
> in place?  Sluggish serial has NOT been an issue for us in other
> trees for a long time.  Perhaps something is missing.

Why this is not problem in your trees is probably because you have
similiar hack in place. At least in your CDP tree you have 6 second
timeout after activity in serial console. While this timeout is on
only mpu is allowed to enter sleep state. After this timeout C state
selection continues normally. I agree that this is slightly better,
but still not providing realistic PM for testing. PER and CORE sleep
transitions are still prevented.

I think we must remember that serial console is a debug interface. If
doing some PM testing, it is not too big task to wait for 5 seconds
before starting the test/measurement.

>
> In general keeping code out of the C0 path is good.  What ever method=
 makes console serial usable and gets out of the way fastest to get bet=
ter power measurements in typical test environment is good.
>
> Is the comment on the smart idle / no idle aspect or the whole path?

My comment was on the changes made to 8250 driver (smart idle / no idle=
).

>
> It probably is easier to put changes in our local cpu_idle-C0 functio=
n as compared to a shared 8250 driver.  But if it means adding extra co=
de on a hot system path it is less appealing.
>
> If it's working here, we can ask what opinions are on ARM-Linux
> list. Today there are other UART instance specific work arounds in
> that code.

Ok, it would be great to get such code to 8250 driver.

>
> Regards,
> Richard W.
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
