From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: getnstimeofday() and suspend
Date: Fri, 15 Aug 2008 13:57:53 +0300
Message-ID: <87r68qmtou.fsf@trdhcp146196.ntc.nokia.com>
References: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com>
	<20080813140016.GE27446@atomide.com>
	<B71CE868F2BC2847B3F23C5A8EE394305AB858@vaebe110.NOE.Nokia.com>
	<B71CE868F2BC2847B3F23C5A8EE394305E574F@vaebe110.NOE.Nokia.com>
	<1218792793.28834.33.camel@localhost>
	<878wuyob5q.fsf@trdhcp146196.ntc.nokia.com>
	<1218795052.28834.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40976 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbYHOK62 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 06:58:28 -0400
In-Reply-To: <1218795052.28834.40.camel@localhost> (Igor Stoppa's message of
	"Fri, 15 Aug 2008 10:10:52 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: igor.stoppa@nokia.com
Cc: "ext Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org

Igor Stoppa <igor.stoppa@nokia.com> writes:

> On Fri, 2008-08-15 at 12:55 +0300, H=C3=B6gander Jouni wrote:
>
>> Using them both would also generate more complexity. What would be t=
he
>> benefit in using them both?
>
> The RTC should be used during suspend since it's supposed to keep tra=
ck
> of time regardless of how long the duration of the suspension is.
>
> The 32kHz alone is not a good generic solution since it overflows aft=
er
> a couple of days.

Yes you are right on that timer overflow. How generic this is, I'm not
sure. This is only for measuring time pwrdms spent in their states on
suspend. How about removing that time from pm debug interfaces? They
are meant for debugging dynamic sleep anyway.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
