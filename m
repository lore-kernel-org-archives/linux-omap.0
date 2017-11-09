From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 2/7] arm: omap: Move dmtimer.h out of plat-omap
Date: Thu, 9 Nov 2017 09:55:25 +0530
Message-ID: <6ca9c73a-95a1-2466-151e-cdba64c3c478@ti.com>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-3-git-send-email-j-keerthy@ti.com>
 <20171108164221.GV28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20171108164221.GV28152@atomide.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk
List-Id: linux-omap@vger.kernel.org



On Wednesday 08 November 2017 10:12 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [171108 12:31]:
>> The header file is currently under plat-omap directory
>> under arch/omap. Move this out to an accessible place.
>>
>> No Code changes done to the header file.
> 
> Some of the dmtimer functions are in this header to optimize the
> size of the system timer code. Can you please check if some of them
> can be left out of dmtimer.h and be made private to mach-omap1/timer.c
> and mach-omap2/timer.c?

Okay. I will try to clean that as well.

> 
> Again, we don't want driver code to start mis-using these as that's
> immediately going to be big mess out of control.

Sure.

> 
> Regards,
> 
> Tony
> 
