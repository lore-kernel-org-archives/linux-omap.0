From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] ARM: OMAP3: PM: Add feature to wake from suspend on timer
Date: Fri, 14 Nov 2008 10:16:58 -0800
Message-ID: <200811141016.58328.david-b@pacbell.net>
References: <1226664026-9275-1-git-send-email-ext-timo-pekka.launonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:33858 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750936AbYKNSRA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 13:17:00 -0500
In-Reply-To: <1226664026-9275-1-git-send-email-ext-timo-pekka.launonen@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Timo-Pekka Launonen <ext-timo-pekka.launonen@nokia.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Friday 14 November 2008, Timo-Pekka Launonen wrote:
> If a non-zero value is written to /sys/power/wakeup_timer_seconds,
> A timer wakeup event will wake the system and resume after the
> configured number of seconds.

/sys/class/rtc/rtc0/wakealarm should do the same thing,
except that it takes an absolute time not a relative one.

Do we really need this wakeup_timer interface?

