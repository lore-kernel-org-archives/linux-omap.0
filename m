From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: [PATCH 0/5] OMAP: RX51: Add LCD Panel Support for N900
Date: Wed, 07 Apr 2010 10:45:23 +0200
Message-ID: <87iq83zm58.fsf@small.ssi.corp>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
	<87pr2datft.fsf@small.ssi.corp> <4BBB03F2.5050706@nokia.com>
	<87iq84cnzg.fsf@small.ssi.corp>
	<1270618692.2447.39.camel@tubuntu.research.nokia.com>
	<87r5mrzpe4.fsf@small.ssi.corp> <4BBC3691.3030505@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from copper.chdir.org ([88.191.97.87]:59381 "EHLO copper.chdir.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab0DGIpB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Apr 2010 04:45:01 -0400
In-Reply-To: <4BBC3691.3030505@nokia.com> (Roger Quadros's message of "Wed, 07
	Apr 2010 10:38:57 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Roger,

Roger Quadros <roger.quadros@nokia.com> writes:

>> I also suspected a HW watchdog but 25 seconds did not sound like it. I
>> built a kernel without HW watchdog: same result.
>>
>> Any idea regarding how I could debug that?
>>
> You can try disabling the hw watchdogs via flasher.
>
> sudo flasher --set-rd-flags=no-omap-wd,no-ext-wd,no-lifeguard-reset
>
> This should prevent any watchdog resets.

It does the job! Thanks for the tip. Now that I have a working console,
I will try and make some progress.

Cheers,

a+
