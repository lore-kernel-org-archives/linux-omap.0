From: David Brownell <david-b@pacbell.net>
Subject: Re: getnstimeofday() and suspend
Date: Wed, 13 Aug 2008 10:31:34 -0700
Message-ID: <20080813173134.962D5362362@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:41498 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752616AbYHMRbc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Aug 2008 13:31:32 -0400
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com, linux-omap@vger.kernel.org

> I noticed an interesting feature in the getnstimeofday() function when
> used with suspend. System clock is effectively reset to the value it was
> just before suspend.	...
>
> I.e., the calendar clock was only advanced 2 seconds. The time you spend
> in suspend does not matter, the end result is the same, it will reset
> the time to the value it was before suspend.
>
> Is this behavior intended?

This is why you should configure an RTC to handle RTC_HCTOSYS duties.
Like updating the system time from the RTC after resume ...

- Dave
