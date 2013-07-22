From: Illia Smyrnov <x0194613@ti.com>
Subject: Re: [PATCH 2/2] Input: omap-keypad: Cleanup - remove unnecessary
 IRQ enabling/disabling
Date: Mon, 22 Jul 2013 20:25:05 +0300
Message-ID: <51ED6AF1.9070605@ti.com>
References: <1374239027-3927-1-git-send-email-illia.smyrnov@globallogic.com> <1374239027-3927-3-git-send-email-illia.smyrnov@globallogic.com> <20130719132648.GB17188@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20130719132648.GB17188@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
To: balbi@ti.com
Cc: Illia Smyrnov <illia.smyrnov@globallogic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 07/19/2013 04:26 PM, Felipe Balbi wrote:
> Hi,
>
> [...]
> please don't remove this code. It'll be good to have this around when we
> move the driver to threaded IRQs without IRQF_ONESHOT. In fact, it would
> be very simple to implement such a change, wanna take it up ?
>
> It should be doable in few patches:
>
> 1) switch over to request_threaded_irq()
>
> 	just blind move to a thread, without hardirq handler, so
> 	IRQF_ONESHOT is mandatory.
>
> 2) add hardirq handler
>
> 	read IRQSTATUS to check if our device has generated IRQs
> 	returning IRQ_WAKE_THREAD if true
>
> 3) move 'IRQ masking logic' to hardirq handler, before returning
> IRQ_WAKE_THREAD
>
> 	this will let you remove IRQF_ONESHOT
>
> 4) finally remove IRQF_ONESHOT
>
> 	this makes sure that IRQs aren't kept disabled until we have
> 	time to iterate over the entire keypad matrix. Only the keypad
> 	IRQ will be masked.
>

Ok, but why we need to remove IRQF_ONESHOT flag for omap keypad driver?

The keypad IRQ isn't shared IRQ and in our case hardirq handler will 
always return IRQ_WAKE_THREAD like default irq_default_primary_handler 
do. With IRQF_ONESHOT flag IRQ line will be masked until the threaded
handler finished, but there is only keypad on this line.

I tested two versions:
the first one - just threaded IRQs with IRQF_ONESHOT and without 
specific hardirq handler.
the second version - threaded IRQs without IRQF_ONESHOT as you described.
Both versions was successfully tested on Blaze's keypad.
