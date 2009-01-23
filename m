From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: new PM branch available
Date: Fri, 23 Jan 2009 09:20:29 -0800
Message-ID: <87skna6isi.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F51109B5@dbde02.ent.ti.com>
	<E5387292-875B-4ACA-A008-3F1F11B6562B@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:64126 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbZAWRUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 12:20:35 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2194604ywe.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2009 09:20:33 -0800 (PST)
In-Reply-To: <E5387292-875B-4ACA-A008-3F1F11B6562B@student.utwente.nl> (Koen Kooi's message of "Fri\, 23 Jan 2009 13\:10\:48 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Koen Kooi <k.kooi@student.utwente.nl> writes:

> Op 23 jan 2009, om 13:00 heeft Nayak, Rajendra het volgende geschreve=
n:
>
>>
>>
>>> -----Original Message-----
>>> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]
>>> Sent: Friday, January 23, 2009 4:52 PM
>>> To: Nayak, Rajendra
>>> Cc: Kevin Hilman; linux-omap@vger.kernel.org
>>> Subject: Re: new PM branch available
>>>
>>> "ext Nayak, Rajendra" <rnayak@ti.com> writes:
>>>
>>>>> I did some testing today on my 3.0GP 3430SDP. This is with
>>> the omap_3430sdp_min_defconfig.
>>>>>
>>>>> 1) Idle.
>>>>> echo -n 1 > /sys/power/clocks_off_while_idle
>>>>> echo -n 1 > /sys/power/enable_off
>>>>> Could not hit RET. something seems to be still active. Not
>>> sure if it could be something
>>>>> to do with this error that's thrown while bootup
>>>>>
>>>>> <6>Disabling unused clock "dpll5_ck"
>>>>> Disabling unused clock "dpll5_ck"
>>>>> <3>clock: dpll5_ck failed transition to 'locked'
>>>>> clock: dpll5_ck failed transition to 'locked'
>>>>>
>>>>> This is the same results I see on my SDP.
>>>>>
>>>>> Looking at the registers, I am pretty sure it is the D2D
>>> clockdomain
>>>>> that still has activity, but due to very poor Stacked-mode
>>> docs and no
>>>>> responses to the D2D questions asked to TI I have not been able t=
o
>>>>> figure this one out.
>>>>>
>>>>> Help debugging this would be greatly appreciated.
>>>>
>>>> I looked some more into this today and saw that the hang is
>>> indeed caused
>>>> due to some kind of debug console going dead. The system
>>> was still looping in the
>>>> idle thread. I could even do a telnet remotely to my board and tak=
e
>>>> some debug dumps..
>>>
>>> This might help you:
>>
>> Yup, this does help. There's no hang now either in idle or in suspen=
d.
>> Not sure why this was affecting only the SDP while the pm branch see=
ms
>> to function without this for beagle and other omap3 platforms?
>
> I get 'hangs' on the beagle as well with the PM branch. They mostly
> seem to happen when I boot a fresh rootfs and the packagemanager runs
> a lot of postinst scripts without any form of user interaction.
>

Koen,

What are your /sys/power/clocks_off_while_idle and ../sleep_while_idle
set to?

Do you see the hangs when both of these are zero?

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
