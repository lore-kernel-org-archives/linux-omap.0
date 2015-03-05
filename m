From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: reboot command fails with low frequency
Date: Thu, 5 Mar 2015 11:29:21 +0200
Message-ID: <CAJ2oMh+HC7wuZ6+F7jXe9hGe68=WWsu5=H1h0OZanEUs6HqxzQ@mail.gmail.com>
References: <CAJ2oMhLDbA_BVsZPnbNq460mYbUw6Z7QpB=YmSCjX65NL1BaFg@mail.gmail.com>
	<CAOf5uwkWvd_gH08t-AacU8Jp4gFmr4X42bMv4eT43Uhaaa5GMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:45008 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbbCEJ3X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 04:29:23 -0500
In-Reply-To: <CAOf5uwkWvd_gH08t-AacU8Jp4gFmr4X42bMv4eT43Uhaaa5GMQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org

>> We observer that with highest available frequency (600000) reboot
>> command is OK, but when frequency is changed to lower value, the
>> reboot command fails.
>> Has anyone observed such behaviour ?
>
> I remember some commit for this problem. What version of the linux are
> you running?

I use Linux version 2.6.37 #36 PREEMPT Thu Mar 5 10:56:04 IST 2015
armv7l GNU/Linux

Do you know how I can find this fix ?

Thanks!
Ran
