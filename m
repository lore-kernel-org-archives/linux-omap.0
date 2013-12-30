From: boris brezillon <b.brezillon@overkiz.com>
Subject: Re: [RFC PATCH] gpio: add GPIO hogging mechanism
Date: Mon, 30 Dec 2013 10:48:48 +0100
Message-ID: <52C14180.4080801@overkiz.com>
References: <1387463671-1164-1-git-send-email-b.brezillon@overkiz.com> <1387463671-1164-2-git-send-email-b.brezillon@overkiz.com> <20131219164109.GB27409@kroah.com> <20131219164737.GA4536@saruman.home> <52B32A70.1080700@overkiz.com> <20131219182227.GB4536@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131219182227.GB4536@saruman.home>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Ben Gamari <bgamari.foss@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On 19/12/2013 19:22, Felipe Balbi wrote:
> On Thu, Dec 19, 2013 at 06:18:40PM +0100, boris brezillon wrote:
>> Hello Felipe,
>>
>> On 19/12/2013 17:47, Felipe Balbi wrote:
>>> On Thu, Dec 19, 2013 at 08:41:09AM -0800, Greg Kroah-Hartman wrote:
>>>> On Thu, Dec 19, 2013 at 03:34:31PM +0100, Boris BREZILLON wrote:
>>>>> GPIO hogging is a way to request and configure specific GPIO without
>>>>> explicitly requesting it in the device driver.
>>>>>
>>>>> The request and configuration procedure is handled in the core device
>>>>> driver code before the driver probe function is called.
>>>>>
>>>>> It allows specific GPIOs to be configured without any driver specific code.
>>>>>
>>>>> Particularly usefull when a external device is connected to a bus and the
>>>>> bus connections depends on an external switch controlled by a GPIO pin.
>>> for external switches, you probably need a pinctrl-gpio driver.
>> Do you mean using pinctrl pinconf to configure the PIN as output-high or
>> output-low ?
>>
>> This was my first proposal
>> (see https://www.mail-archive.com/devicetree@vger.kernel.org/msg05829.html).

My mistake: this is not exactly what I proposed in my patch series.

Actually, I was directly requesting the pin connected to the external 
switch as
OUTPUT + (OUTPUT-LEVEL) according the the device needs:
- output high for MMC slot
- output low for SPI device

And, I guess this is why Linus asked me to find a better solution.

IMHO your approach is, by far, much better. You expose the external switch
as a PIN muxing device and the devices connected to through this PIN mux
block just have to request the appropriate PIN states.

In my specific case this would give the following:
- MMC conf for mmc slot 0
- SPI conf for the SPI device

With your approach the HW representation is better: the different signals
controlled by the external switch can be seen using debugfs, and device
tree definition is closer to the real HW design.

> that's quite a weird argument from Linus W, considering you _do_ have a
> discrete mux on the board.

> We have quite a few of such "crazy" scenarios here at TI and we were
> going to send a pinctrl-gpio driver. If that's not acceptable, then I
> suppose there is no way to boot from NAND on a board where NAND signals
> go through a discrete mux where the select signal is a GPIO pin.
>

Please keep going with the submission process: I'm really interested in this
driver (BTW could you add me in the CC list ?).

Linus, tell me if I'm wrong, but I think, the pinctrl-gpio is the right 
way to solve
the at91rm9200ek board use case.

This does not mean, the gpio hogs approach does not solve other issues (see
https://lkml.org/lkml/2013/8/29/333 and
https://www.mail-archive.com/linux-gpio@vger.kernel.org/msg01084.html), 
but in
my specific case, I'd rather use the pinctrl-gpio driver.

Best Regards,

Boris
