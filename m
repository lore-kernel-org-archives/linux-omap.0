From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH] mfd: menelaus: remove obsolete local_irq_disable() and
 local_irq_enable()
Date: Wed, 19 Apr 2017 08:10:24 +0200
Message-ID: <131724c6-4ca3-9649-457c-44cdc8b22043@ginzinger.com>
References: <1491817038-4956-1-git-send-email-martin.kepplinger@ginzinger.com>
 <20170412201523.goonigemlsez5m46@raspberrypi-3.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170412201523.goonigemlsez5m46@raspberrypi-3.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>
Cc: lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Henri Roosen <henri.roosen@ginzinger.com>
List-Id: linux-omap@vger.kernel.org



On 2017-04-12 22:15, Aaro Koskinen wrote:
> On Mon, Apr 10, 2017 at 11:37:18AM +0200, Martin Kepplinger wrote:
>> Since
>>
>> commit e6229bec25be ("rtc: make rtc_update_irq callable with irqs enabled")
>>
>> rtc_update_irq() is callable with irqs enabled, see the rtc drivers.
>> So update this accordingly.
>>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>> Cc: Henri Roosen <henri.roosen@ginzinger.com>
> 
> I think the patch looks OK, so:
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 

Any other concern about this?

                      martin
