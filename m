From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/4] ARM: OMAP2+: Avoid idling memory controllers with
 no drivers
Date: Tue, 23 Jul 2013 10:29:22 +0530
Message-ID: <51EE0DAA.9000203@ti.com>
References: <1374487277-26099-1-git-send-email-rnayak@ti.com> <1374487277-26099-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.02.1307221746430.10891@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1307221746430.10891@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, balbi@ti.com, mpfj-list@newflow.co.uk, vaibhav.bedia@ti.com, khilman@linaro.org, sourav.poddar@ti.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

On Monday 22 July 2013 11:18 PM, Paul Walmsley wrote:
> Hi
> 
> On Mon, 22 Jul 2013, Rajendra Nayak wrote:
> 
>> Memory controllers in OMAP (like GPMC and EMIF) have the hwmods marked with
>> HWMOD_INIT_NO_IDLE and are left in enabled state post initial setup.
>>
>> Even if they have drivers missing, avoid idling them as part of
>> omap_device_late_idle()
> 
> Since this patch is intended for the -rc series, it's best if you explain 
> here what effects this patch will fix.  i.e., does this fix a crash, a 
> warning, etc?  Also maybe update your series description message?

This patch infact is needed because of 'PATCH 4/4' in the series which makes
sure the omap_device and pm_runtime state are in sync with the hwmod state.

Without that we always had gpmc and emif having the hwmod state as enabled but
omap_device state as disabled and we never hit the issue of omap_device_late_idle()
trying to disable gpmc and emif.

So in short, this does not fix anything in the existing code, but something that
was uncovered by syncing the states across hwmod and omap_device.

regards,
Rajendra

> 
> 
> - Paul
> 

