From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH 7/8] 34XX: PM: Workaround to disable mmc
Date: Tue, 17 Jun 2008 18:51:43 +0530
Message-ID: <033d01c8d07d$17ffab20$38f6180a@ent.ti.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com><1213687871-30038-1-git-send-email-jouni.hogander@nokia.com><663b4c9bb83ca6e0f9e490db7bfdccce@felipebalbi.com> <87d4mg460j.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:52441 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757224AbYFQNWE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2008 09:22:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?=22H=C3=B6gander=22_Jouni?= <jouni.hogander@nokia.com>, ext Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org


----- Original Message -----=20
=46rom: ""H=C3=B6gander" Jouni" <jouni.hogander@nokia.com>
To: "ext Felipe Balbi" <me@felipebalbi.com>
Cc: <linux-omap@vger.kernel.org>
Sent: Tuesday, June 17, 2008 5:39 PM
Subject: Re: [PATCH 7/8] 34XX: PM: Workaround to disable mmc


> "ext Felipe Balbi" <me@felipebalbi.com> writes:
>
>> On Tue, 17 Jun 2008 10:31:11 +0300, Jouni Hogander
>> <jouni.hogander@nokia.com> wrote:
>>> Current hsmmc is not pm friendly. Disable it because it prevents om=
ap3
>>> retention
>>
>> Disabling will just hide the bug. Better making it modular
>> and let mmc guys dig on it.
>
> Ok, I can change it, if this set needs to be sent again. I think
> disabling mmc increases visibility of its PM problems. I mean missing
> mmc driver is more visible than missing PM in this case.
>
>>
>> What do you need to make it more pm friendly?
>
> Not to prevent omap retention.
When are you expecting the omap to go into retention? Is it in the susp=
end=20
path?

Regards,
Madhu
>
>>
>> --=20
>> Best Regards,
>>
>> Felipe Balbi
>> http://felipebalbi.com
>> me@felipebalbi.com
>>
>>
>>
>
> --=20
> Jouni H=C3=B6gander
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
