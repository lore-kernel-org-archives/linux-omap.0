From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the mcp794xx alarm
 after programming time
Date: Wed, 22 Apr 2015 13:30:53 +0200
Message-ID: <20150422113053.GI8539@piout.net>
References: <1429577494-15087-1-git-send-email-nm@ti.com>
 <20150421234139.GF8539@piout.net>
 <5536E433.90103@ti.com>
 <20150422010925.GH8539@piout.net>
 <55370073.3060809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51476 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932239AbbDVLa4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2015 07:30:56 -0400
Content-Disposition: inline
In-Reply-To: <55370073.3060809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com

On 21/04/2015 at 20:59:15 -0500, Nishanth Menon wrote :
> >> Why is that so? when set alarm is requested for time X, you want
> >> interrupt at time X, not an interrupt for previous configured RTC
> >> alarm time!
> >>
> > 
> > You expect at least an interrupt.
> 
> And you will get an interrupt if the event occurs before the i2c burst
> starts. Once the i2cburst does start, you are committing to the new time.
> 

You mean that even if ALM0EN is set after ALM0IF was set to 1, it will
trigger the interrupt? I had a look at the MFP output block diagram
would let me think that this is the case. I was thinking otherwise
before. If that is so, then indeed, your patch is OK.

My concern was about the time between ds1307->write_block_data() and
i2c_smbus_write_byte_data() which actually calls cond_sched().

I fully agree that your patch doesn't change the behaviour for the other
cases you presented and further clean up is to be done in a separate set
of patches.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
