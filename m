From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: N810 suspend
Date: Thu, 18 Dec 2008 14:51:20 +0200
Message-ID: <94a0d4530812180451t7f9da6a7y9fe9ccc2c7ab49a4@mail.gmail.com>
References: <20081215210823.GD5334@swansys>
	 <20081215211430.GJ10664@atomide.com>
	 <20081216092531.c440dc26.jarkko.nikula@nokia.com>
	 <20081216162951.GP19551@atomide.com> <20081216165632.GF25056@swansys>
	 <20081216172237.GR19551@atomide.com>
	 <20081217140911.b30d7194.jarkko.nikula@nokia.com>
	 <20081218090147.c6e5c4a0.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:32479 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbYLRMvW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 07:51:22 -0500
Received: by fg-out-1718.google.com with SMTP id 19so166808fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 18 Dec 2008 04:51:20 -0800 (PST)
In-Reply-To: <20081218090147.c6e5c4a0.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Linux-OMAP List <linux-omap@vger.kernel.org>

On Thu, Dec 18, 2008 at 9:01 AM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Wed, 17 Dec 2008 14:09:11 +0200
> "ext Jarkko Nikula" <jarkko.nikula@nokia.com> wrote:
>
>> On Tue, 16 Dec 2008 09:22:38 -0800
>> "ext Tony Lindgren" <tony@atomide.com> wrote:
>>
>> > > > Oh, I just tested that sleep-while-idle worked when fb was blanked. I
>> > > > had a script that forced the LCD off via /sys, sorry don't remember
>> > > > the path now. Will be also heading to catch a plane in few hours, may
>> > > > not be able to check it right now.
>> > >
>> > > 'echo 3 > /sys/class/graphics/fb0/blank' turns off the LCD, if that is what you
>> > > mean.
>> >
>> > Thanks, that's what I did.
>> >
>> And it worked with N800. Battery current dropped below 10 mA after
>> unplugging the USB cable so OMAP was going into retention.
>>
> FYI:
>
> xorg.conf's Option "SuspendTime" seems to equal to blanking command 3
> (VESA_POWERDOWN). Look drivers/video/omap/omapfb_main.c: omapfb_blank.

Yes, but it should be FB_BLANK_POWERDOWN (4), shouldn't it?

-- 
Felipe Contreras
