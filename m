From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 7/8] 34XX: PM: Workaround to disable mmc
Date: Wed, 18 Jun 2008 10:00:33 +0300
Message-ID: <87zlpjjkha.fsf@trdhcp146196.ntc.nokia.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
	<1213687871-30038-1-git-send-email-jouni.hogander@nokia.com>
	<663b4c9bb83ca6e0f9e490db7bfdccce@felipebalbi.com>
	<87d4mg460j.fsf@trdhcp146196.ntc.nokia.com>
	<033d01c8d07d$17ffab20$38f6180a@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26415 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbYFRHAw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2008 03:00:52 -0400
In-Reply-To: <033d01c8d07d$17ffab20$38f6180a@ent.ti.com> (ext Madhusudhan
	Chikkature's message of "Tue, 17 Jun 2008 18:51:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org

"ext Madhusudhan Chikkature" <madhu.cr@ti.com> writes:

> ----- Original Message -----=20
> From: ""H=C3=B6gander" Jouni" <jouni.hogander@nokia.com>
> To: "ext Felipe Balbi" <me@felipebalbi.com>
> Cc: <linux-omap@vger.kernel.org>
> Sent: Tuesday, June 17, 2008 5:39 PM
> Subject: Re: [PATCH 7/8] 34XX: PM: Workaround to disable mmc
>
>
>> "ext Felipe Balbi" <me@felipebalbi.com> writes:
>>
>>> On Tue, 17 Jun 2008 10:31:11 +0300, Jouni Hogander
>>> <jouni.hogander@nokia.com> wrote:
>>>> Current hsmmc is not pm friendly. Disable it because it prevents o=
map3
>>>> retention
>>>
>>> Disabling will just hide the bug. Better making it modular
>>> and let mmc guys dig on it.
>>
>> Ok, I can change it, if this set needs to be sent again. I think
>> disabling mmc increases visibility of its PM problems. I mean missin=
g
>> mmc driver is more visible than missing PM in this case.
>>
>>>
>>> What do you need to make it more pm friendly?
>>
>> Not to prevent omap retention.
> When are you expecting the omap to go into retention? Is it in the
> suspend path?

I expect it to enter retention when suspending yes. It should also
enter retention dynamically. I mean when mpu enters wfi in pm_idle loop=
=2E

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
