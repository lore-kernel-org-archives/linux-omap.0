From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Thu, 10 Nov 2016 08:11:49 -0700
Message-ID: <20161110151149.GB27724@atomide.com>
References: <20161109192301.GS26979@atomide.com>
 <621758ce-dd3f-41ad-d9b8-b8e34538700e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <621758ce-dd3f-41ad-d9b8-b8e34538700e@redhat.com>
Sender: linux-leds-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Hans de Goede <hdegoede@redhat.com> [161110 01:35]:
> Hi,
> 
> On 09-11-16 20:23, Tony Lindgren wrote:
> > Hi,
> > 
> > Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
> > the sysfs brightness attr for changes.") breaks runtime PM for me.
> > 
> > On my omap dm3730 based test system, idle power consumption is over 70
> > times higher now with this patch! It goes from about 6mW for the core
> > system to over 440mW during idle meaning there's some busy timer now
> > active.
> 
> Do you have any blinking LEDs or LED triggers defined on the system ?

There are some configured in the dts file:

$ grep -i led arch/arm/boot/dts/*torpedo*.dts*

And the gpio controlled led1 is configured to blink with
linux,default-trigger = "cpu0".

> > Reverting this patch fixes the issue. Any ideas?
> 
> All I can think of is something calling led_set_brightness quite often,
> the patch in question makes led_set_brightness somewhat more expensive,
> but it should not cause such a big difference unless something is
> really calling led_set_brightness quite often maybe something is calling
> it with the same value all the time ?

I don't think this one has any brightness control.

Regards,

Tony
