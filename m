From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: getnstimeofday() and suspend
Date: Fri, 15 Aug 2008 12:55:13 +0300
Message-ID: <878wuyob5q.fsf@trdhcp146196.ntc.nokia.com>
References: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com>
	<20080813140016.GE27446@atomide.com>
	<B71CE868F2BC2847B3F23C5A8EE394305AB858@vaebe110.NOE.Nokia.com>
	<B71CE868F2BC2847B3F23C5A8EE394305E574F@vaebe110.NOE.Nokia.com>
	<1218792793.28834.33.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32806 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbYHOJz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 05:55:28 -0400
In-Reply-To: <1218792793.28834.33.camel@localhost> (ext Igor Stoppa's message
	of "Fri, 15 Aug 2008 09:33:13 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: igor.stoppa@nokia.com
Cc: "ext Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org

"ext Igor Stoppa" <igor.stoppa@nokia.com> writes:

> On Fri, 2008-08-15 at 12:32 +0300, ext Tero.Kristo@nokia.com wrote:
>
>> This behavior of the getnstimeofday() is breaking pm-debug and the
>> serial console wakeup hack if we use suspend. Enabling RTC module se=
ems
>> to fix some of the issues in some cases, but we are going to lose ti=
mer
>> accuracy (RTC accuracy is only 1 second.)
>
> What about using the RTC for getting the base time and the 32kHz for =
the
> extended granularity?
>
> So one would use the RTC as ususal and then calculate the (less than =
1s)
> offset.

Are you talking about rtc resume generally here? If you are talking
about pm debug and serial console hack here, using 32kHz timer only,
would work as a solution even when there is no rtc driver loaded.

Using them both would also generate more complexity. What would be the
benefit in using them both?

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
