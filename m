From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: [PATCH 0/5] OMAP: RX51: Add LCD Panel Support for N900
Date: Wed, 07 Apr 2010 09:35:15 +0200
Message-ID: <87r5mrzpe4.fsf@small.ssi.corp>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
	<87pr2datft.fsf@small.ssi.corp> <4BBB03F2.5050706@nokia.com>
	<87iq84cnzg.fsf@small.ssi.corp>
	<1270618692.2447.39.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from copper.chdir.org ([88.191.97.87]:45294 "EHLO copper.chdir.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932474Ab0DGHex (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Apr 2010 03:34:53 -0400
In-Reply-To: <1270618692.2447.39.camel@tubuntu.research.nokia.com> (Tomi
	Valkeinen's message of "Wed, 07 Apr 2010 08:38:12 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Tomi,

Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:

> On Tue, 2010-04-06 at 22:41 +0200, ext Arnaud Ebalard wrote:
>
>> 
>> For the records, just in case someone wants to do the same, I had to
>> use: 
>> 
>>    /sbin/getty 115200 tty0 -n -l /bin/sh
>> 
>> I also had to set CONFIG_KEYBOARD_TWL4030 to get the keyboard
>> working. Any reason for that option not be enabled by default in
>> rx51_defconfig?
>> 
>> Additionally, after something like 25 seconds, the screen goes black and
>> the device stops. Any clue? Can be panel realted?
>
> I'm guessing here, but it could be the HW watchdog kicking in if by
> "device stops" you mean that serial etc also stops. Although it should
> reboot, not stop...

Well, it's a stock N900, not a development board so I don't have a
serial; only the screen and the led in the left corner below the
screen. By "device stops" I mean that the screen and the led (which was
previously on) get dark and stay as is.

I also suspected a HW watchdog but 25 seconds did not sound like it. I
built a kernel without HW watchdog: same result.

Any idea regarding how I could debug that?

Cheers,

a+
