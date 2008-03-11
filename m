From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: Registering ISR for OMAP2430
Date: Tue, 11 Mar 2008 13:40:24 +0200
Message-ID: <31e679430803110440n3eab31d6nc9ecc91a1d97959c@mail.gmail.com>
References: <7d8fdf6f0803110423j34a3e547nfa9fbcb919291a49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:21469 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbYCKLk0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 07:40:26 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2379045wff.4
        for <linux-omap@vger.kernel.org>; Tue, 11 Mar 2008 04:40:24 -0700 (PDT)
In-Reply-To: <7d8fdf6f0803110423j34a3e547nfa9fbcb919291a49@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raghunandan Dhongadi <dk.raghu@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, Mar 11, 2008 at 1:23 PM, Raghunandan Dhongadi
<dk.raghu@gmail.com> wrote:
> Hello All,

That list have being deactivated, I'm Cc:ing to the correct one.

>  I have been integrating a touch screen driver into Linux 2.6.22 kernel
>  for the OMAP2430 process. I have been able to get the driver working
>  in polled mode.
>  For interrupt mode the function "request_irq" returns with failure.
>
>  I have
>  #define TS_IRQ   132  // GPIO line 132

I think you should gpio_request(). Probably a gpio-switch on your
board file will be a lot
easier :-p

check arch/arm/mach-omap2/board-n800.c for example.

>
>  request_irq( irq_no, touch_screen_isr, ( IRQF_DISABLED | irqtype ),
>  "ts_i2c", id )
>    irq_type = IRQ_TRIGGER
>
>  I have done the following before calling this
>
>  omap_cfg_reg( J24_2430_GPIO132 );
>  omap_set_gpio_direction( GPIO1, 1 );
>
>  The touch screen device is an I2C device and used the I2C1 controller
>  of the OMAP2430.
>  Any clues ?
>
>  Thanks in advance
>  Warm Regards,
>  Raghu
>  _______________________________________________
>  Linux-omap-open-source mailing list
>  Linux-omap-open-source@linux.omap.com
>  http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>



-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
