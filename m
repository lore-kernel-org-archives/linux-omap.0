From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 1/1] ARM: OMAP3: PM: Add feature to wake from suspend on timer
Date: Mon, 17 Nov 2008 10:11:32 +0200
Message-ID: <87vdumn557.fsf@trdhcp146196.ntc.nokia.com>
References: <1226664026-9275-1-git-send-email-ext-timo-pekka.launonen@nokia.com>
	<200811141016.58328.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28875 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbYKQILo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2008 03:11:44 -0500
In-Reply-To: <200811141016.58328.david-b@pacbell.net> (ext David Brownell's
	message of "Fri, 14 Nov 2008 10:16:58 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Timo-Pekka Launonen <ext-timo-pekka.launonen@nokia.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

"ext David Brownell" <david-b@pacbell.net> writes:

> On Friday 14 November 2008, Timo-Pekka Launonen wrote:
>> If a non-zero value is written to /sys/power/wakeup_timer_seconds,
>> A timer wakeup event will wake the system and resume after the
>> configured number of seconds.
>
> /sys/class/rtc/rtc0/wakealarm should do the same thing,
> except that it takes an absolute time not a relative one.

This needs an rtc to work. This far we haven't had working
implementation for SDP.

>
> Do we really need this wakeup_timer interface?

We are using this wakeup_timer in our omap3 PM testing (See "Power
management tester" mail by Timo-Pekka Launonen in l-o list) and there
the basic idea is to start with minimalistic kernel. Test drivers
module by module (also rtc) and see how they affect the system
(e.g. OMAP3 current consumption).

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
