From: Adam Wozniak <awozniak@irobot.com>
Subject: Re: spin_lock_irqsave and ISP interrupts on OMAP 3530
Date: Thu, 10 Feb 2011 09:15:54 -0800
Message-ID: <4D541D4A.7060301@irobot.com>
References: <4D4AD877.8070702@irobot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.irobot.com ([206.83.81.187]:24214 "EHLO smtp1.irobot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204Ab1BJRQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 12:16:09 -0500
In-Reply-To: <4D4AD877.8070702@irobot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

No one can confirm this?

On 02/03/2011 08:31 AM, Adam Wozniak wrote:
> I'm hoping I'm just not understanding something and this isn't as 
> broke as I fear it is.
>
> I'm using the ISP on an OMAP3530, linux 2.6.32.  I've got some kernel 
> code I want to lock in both the process context and the ISP interrupt 
> context, so I'm using a spinlock.  As I understand it, locking the 
> spinlock should disable all interrupts.  However, I'm still seeing the 
> ISP interrupt happen when I've got the spinlock locked in the process 
> context.
>
> i.e. somewhere I've got the code below, and my Warning is tripping.  
> Is this broken, or am I not understanding something?
>
> int am_i_locked = 0;
> spinlock_t my_spinlock = SPIN_LOCK_UNLOCKED;
>
> void foo(void) {
>     /* function could be called from process context, or could be 
> called from omap34xx_isp_isr (interrupt context) */
>     unsigned long flags;
>     spin_lock_irqsave(&my_spinlock, flags);
>     WARN_ON(am_i_locked);
>     am_i_locked++;
>
>     /* do some stuff */
>
>     am_i_locked--;
>     spin_unlock_irqrestore(&my_spinlock, flags);
> }
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

