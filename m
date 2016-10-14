From: Ravikumar <a0131654@ti.com>
Subject: Re: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Fri, 14 Oct 2016 13:33:23 +0530
Message-ID: <0bcfaa15-331d-2838-1dbd-58d1790a3916@ti.com>
References: <20160525141119.14486-1-rk@ti.com>
 <20160525141119.14486-2-rk@ti.com> <20160825171430.GM2856@katana>
 <CAALWOA-XP+mfTcVPc1LZZofAaCK-KtKhFKKKHu2PyHWFrfir3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAALWOA-XP+mfTcVPc1LZZofAaCK-KtKhFKKKHu2PyHWFrfir3A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Ravikumar Kattekola <rk@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Saturday 27 August 2016 07:29 PM, Matthijs van Duin wrote:
> Greetings, unfortunate souls trying to use the omap-i2c peripheral in
> slave mode! :-)
That would be me :(  and greetings to you too :)
> I recently posted some stuff about exactly that topic on TI's E2E
> forum, you may want to read this warning:
> http://e2e.ti.com/support/arm/sitara_arm/f/791/p/514961/1955843#1955843
> and post contains suggestions on using slave mode and details on the
> peripheral actually behaves:
> http://e2e.ti.com/support/arm/sitara_arm/f/791/p/514961/1959417#1959417

Thanks for doing extensive testing on the OMAP I2C and preserving your 
notes.
I really appreciate sharing the detailed notes and workarounds to avoid 
lockups.

I'll following up with the HW team on your observations.
>
> Matthijs
