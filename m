From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 1/7] extcon: usb-gpio: Introduce gpio usb extcon driver
Date: Thu, 29 Jan 2015 13:31:30 +0200
Message-ID: <54CA1A12.5080507@ti.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com> <1422274532-9488-2-git-send-email-rogerq@ti.com> <CAGTfZH3nmpUGgFJ6RU+xH8tuDkGBFA-NbXWa0CSXZXR+DXrbkQ@mail.gmail.com> <54C66B0D.9040109@ti.com> <54C6EFC8.1090601@samsung.com> <54C7B0E5.20101@ti.com> <54C8472B.6070302@samsung.com> <54C8D238.4080001@ti.com> <20150128170954.GQ28663@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150128170954.GQ28663@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Felipe Balbi <balbi@ti.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, george.cherian@ti.com, nsekhar@ti.com, devicetree <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 28/01/15 19:09, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [150128 04:15]:
>> On 28/01/15 04:19, Chanwoo Choi wrote:
>>>>
>>>> I still fail to understand that we need to call disable_irq() in .suspend() and
>>>> enable_irq() in .resume()
>>>>
>>>> can you point me to any other drivers doing so?
>>>
>>> You can refer the suspend function in drivers/mfd/max14577.c or drivers/mfd/max77693.c.
>>> The max14577_suspend() includes the detailed comment for why using disable_irq() in suspend function.
>>>
>>> In max14577 case, max14577_suspend() use disable_irq() function because of i2c dependency.
>>> If max14577 device is wake-up from suspend state before completing the resume sequence
>>> of i2c, max14577 may fail to read/write i2c communication.
>>
>> Thanks for this information. I will add disable/enable_irq() in suspend/resume().
> 
> Are the .dts changes safe for me to apply already?
> 

Yes Tony, you can pick them. Thanks.

cheers,
-roger
