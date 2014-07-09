From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH 3/4] tty: serial: 8250 core: add runtime pm
Date: Wed, 09 Jul 2014 13:35:57 +0200
Message-ID: <53BD291D.3040307@linutronix.de>
References: <1404491651-1388-1-git-send-email-bigeasy@linutronix.de> <1404491651-1388-3-git-send-email-bigeasy@linutronix.de> <20140707142056.46f61cf9@alan.etchedpixels.co.uk> <20140709111705.GR28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140709111705.GR28884@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mika.westerberg@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On 07/09/2014 01:17 PM, Tony Lindgren wrote:
> * One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> [140707 06:22]:
>> On Fri,  4 Jul 2014 18:34:10 +0200
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>>
>>> While comparing the OMAP-serial and the 8250 part of this I noticed that
>>> the the latter does not use runtime-pm.
>>
>> Yes it does, but 8250 parts (generally - omap presumably is special
>> here ?) need to be powered on to transmit/receive not just for register
>> access. The core uart layer implements a "pm" operation for this.
> 
> At least for omaps the UARTs need to be idled for the SoC to
> hit off-idle where the SoC is powered off and rebooted during
> idle.
>
> So we can certainly enable this in a generic way, however, this
> can only be done under the following conditions:
> 
> 1. We can save and restore the serial register context and detect
>    when context was lost in the serial driver. The context loss
>    can be detected by looking at some registers that are only
>    initialized during init.

A register check on restore context? DLL+DLH might be a good hint here
since its value should be >0 in the running case.

> 
> 2. There's a way for the serial RX pin to wake the SoC. On some
>    omaps there's a separate pin specific wake-up interrupt that
>    can be used for that.

That one would be handled by omap separately.

> 3. The serial PM features must be only enabled if requested by
>    the user via sysfs. Typically extra latency and loss of the
>    first RX character occur which is not acceptable to most
>    applications.

Unless I'm mistaken the omap driver now initializes the timeout to -1.
So nothing happens unless this is enabled separately.

> Regards,
> 
> Tony
> 

Sebastian
