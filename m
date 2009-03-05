From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: Setting individual GPIO registers
Date: Thu, 5 Mar 2009 09:24:25 +0900
Message-ID: <4d34a0a70903041624l7348f4cbm964850af0f20c39e@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC053014@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:31349 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbZCEAY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 19:24:27 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4202984wfa.4
        for <linux-omap@vger.kernel.org>; Wed, 04 Mar 2009 16:24:25 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC053014@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, Mar 5, 2009 at 12:41 AM, Premi, Sanjeev <premi@ti.com> wrote:
> I am trying to get the wakeup event from touchscreen on
> omap3evm to bring the EVM out of suspend state.
>
> For my private testing, I have been updating individual
> registers & bits in the GPIO registers from function
> ads7846_dev_init().
>
> Ideally, I should be using standard GPIO APIs. However,
> most of the APIs are static within gpio.c
>
> How can I call functions like gpio_wake_enable(), gpio_unmask_irq()

gpio_wake_enable:
enable_irq_wake(gpio_to_irq(gpio #));

gpio_unmake_irq:
request_irq(gpio_to_irq(gpio #), ...) or enable_irq(qpio_to_irq(gpio #));

> OR
> Is there a function to access interface registers for GPIO banks?
>

enable_irq_wake() and request_irq() would be enough.

Somewhat related:
I sent [OMAP wakeup source driver] a few days ago, so you can also use it.
But you may need to configure 'struct gpio_wake' well and your
'irqflags' argument of irq_request().

Regards,

-- 
Q1
