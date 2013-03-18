From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 2/8] staging: omap-thermal: use spin_lock_irqsave inside
 IRQ handler
Date: Mon, 18 Mar 2013 15:38:38 -0400
Message-ID: <51476D3E.6010305@ti.com>
References: <1363618756-15851-1-git-send-email-eduardo.valentin@ti.com> <1363618756-15851-3-git-send-email-eduardo.valentin@ti.com> <20130318191618.GU9138@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130318191618.GU9138@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 18-03-2013 15:16, Dan Carpenter wrote:
> On Mon, Mar 18, 2013 at 10:59:10AM -0400, Eduardo Valentin wrote:
>> Even if the IRQ is not firing because it is ONE_SHOT and disable
>> at INTC level, the IRQ handler must use spin_lock_irqsave.
>> It is necessary to disable IRQs from the current
>> CPU while it is holding a spin_lock which is need.
>>
>
> Gar...  I think I was just totally wrong on this.  I think your
> original code was fine.  Sorry Eduardo and Greg.
>
> This is a threaded IRQ so the regular spin_lock is fine or even the
> mutex would have been.

In fact it is. But I rather prefer to use spinlocks there, just to keep 
the irq handler sane, even if it is moved to non-threaded IRQ.

>
> IRQ_ONESHOT is about triggering a second IRQ before the first one
> has been finished, btw.

It is, and that gets done by masking the IRQ at INTC level.

>
> I am an idiot.


Not really. Thanks for your time reviewing the driver.

  I will resend this series. Drop this one and split patch 4/8 into two 
I think (one for moving files, one for renaming functions)

>
> regards,
> dan carpenter
>
>
>
