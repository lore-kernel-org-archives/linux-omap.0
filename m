From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: reboot command fails with low frequency
Date: Thu, 5 Mar 2015 14:29:09 +0200
Message-ID: <CAJ2oMhKOXaKJfsC1E4Fs47Ura2FMrWsBt0UAHjZH2VHywZz7PA@mail.gmail.com>
References: <CAJ2oMhLDbA_BVsZPnbNq460mYbUw6Z7QpB=YmSCjX65NL1BaFg@mail.gmail.com>
	<CAOf5uwkWvd_gH08t-AacU8Jp4gFmr4X42bMv4eT43Uhaaa5GMQ@mail.gmail.com>
	<CAJ2oMh+HC7wuZ6+F7jXe9hGe68=WWsu5=H1h0OZanEUs6HqxzQ@mail.gmail.com>
	<CAOf5uwmyOZOTMBGnQU38-D=Emo6Rdrd8fDW9Hk+_r4RG4=+nrA@mail.gmail.com>
	<CAJ2oMhJk9_Hdov4ue-8WWNbEaDh862GhbYWwBtaUZTdbbFkWbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:44966 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329AbbCEM3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 07:29:11 -0500
In-Reply-To: <CAJ2oMhJk9_Hdov4ue-8WWNbEaDh862GhbYWwBtaUZTdbbFkWbQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org

I think I can also do some workaround if I set the frequency to the
highest level just before doing reset. The thing is that I mustn't use
sysfs in my system. Is there some way to set frequency without using
sysfs ?
