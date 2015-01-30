From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/7] extcon: usb-gpio: Introduce gpio usb extcon driver
Date: Fri, 30 Jan 2015 12:58:39 +0200
Message-ID: <54CB63DF.6070007@ti.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com> <1422274532-9488-2-git-send-email-rogerq@ti.com> <CAGTfZH3nmpUGgFJ6RU+xH8tuDkGBFA-NbXWa0CSXZXR+DXrbkQ@mail.gmail.com> <54C66B0D.9040109@ti.com> <54C6EFC8.1090601@samsung.com> <54C7B0E5.20101@ti.com> <54C8472B.6070302@samsung.com> <54C8D238.4080001@ti.com> <20150128170954.GQ28663@atomide.com> <54CA1A12.5080507@ti.com> <20150129165625.GB16250@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150129165625.GB16250-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 29/01/15 18:56, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150129 03:34]:
>> On 28/01/15 19:09, Tony Lindgren wrote:
>>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150128 04:15]:
>>>> On 28/01/15 04:19, Chanwoo Choi wrote:
>>>>>>
>>>>>> I still fail to understand that we need to call disable_irq() in .suspend() and
>>>>>> enable_irq() in .resume()
>>>>>>
>>>>>> can you point me to any other drivers doing so?
>>>>>
>>>>> You can refer the suspend function in drivers/mfd/max14577.c or drivers/mfd/max77693.c.
>>>>> The max14577_suspend() includes the detailed comment for why using disable_irq() in suspend function.
>>>>>
>>>>> In max14577 case, max14577_suspend() use disable_irq() function because of i2c dependency.
>>>>> If max14577 device is wake-up from suspend state before completing the resume sequence
>>>>> of i2c, max14577 may fail to read/write i2c communication.
>>>>
>>>> Thanks for this information. I will add disable/enable_irq() in suspend/resume().
>>>
>>> Are the .dts changes safe for me to apply already?
>>>
>>
>> Yes Tony, you can pick them. Thanks.
> 
> OK will apply the dts changes into omap-for-v3.20/dt thanks.
> I have also the defconfig changes tagged, will apply those
> a bit later probably as a fix after the driver is merged.

Sounds good to me. Thanks Tony.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
