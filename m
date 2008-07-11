From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP3: CPUIDLE & PM: check_bm fix.
Date: Fri, 11 Jul 2008 15:48:23 +0300
Message-ID: <87y748pox4.fsf@trdhcp146196.ntc.nokia.com>
References: <1215519440-10234-1-git-send-email-jouni.hogander@nokia.com>
	<1215584973-14982-1-git-send-email-jouni.hogander@nokia.com>
	<000b01c8e18f$31708610$68bf18ac@ent.ti.com>
	<87tzezwnl1.fsf@trdhcp146196.ntc.nokia.com>
	<000c01c8e193$9f1f4d50$68bf18ac@ent.ti.com>
	<87tzeztpz3.fsf@trdhcp146196.ntc.nokia.com>
	<001901c8e19f$32f66f80$68bf18ac@ent.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162035BD675D5@dlee02.ent.ti.com>
	<87iqves1xm.fsf@trdhcp146196.ntc.nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162035BDBF028@dlee02.ent.ti.com>
	<87vdzdsxwi.fsf@trdhcp146196.ntc.nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162035BDBF07D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46981 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758657AbYGKMss convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jul 2008 08:48:48 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BDBF07D@dlee02.ent.ti.com>
	(ext Woodruff's message of "Thu, 10 Jul 2008 08:00:24 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> > The current check will: On activity raise a cpuidle bus master
>> > activity failure for some number of seconds.  This allows normal
>> > typing for extended periods.  It does this by marking UART functio=
n
>> > IRQs with a time stamp and it checks internal state to make sure
>> > RX/TX engine is not busy or has queued data waiting.
>>
>> Isn't this exactly what is done in "Added sleep support to UART" pat=
ch
>> in workaround patch set?
>
> See last mail.  It probably is.  I assumed that was derived from our =
code which has been available for a long time before.  I didn't actuall=
y look at it very closely with that assumption.
>
>> > This activity assertion will gate the usage of C states where its =
=46-
>> CLOCK is cut.  At the same time its natural wake up events are enabl=
ed
>> (along with the above hack as the tx events are not currenly hooked
>> into the wakeup logic).
>> >
>> > When OFF/RET mode is selected IO pad is enabled for the port wakeu=
p.
>>
>> I have seen this in CDP reference code. Is there some specific reaso=
n
>> why this is enabled dynamically in code?
>
> Not that I am aware.
>
> Do you think there is a need to toggle it?  Today only the global
> IOPAD enable is toggled (which is necessary for pad state latching).

No, I might have seen this global IOPAD enable. This is valuable
information. Currently in linux-omap setting IOPAD enable bit is done
on initialization. We haven't noticed any problems this far, but this
feature haven't been used too much. So probably we have been just
lucky?

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
