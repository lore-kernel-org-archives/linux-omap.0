From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Thu, 23 Sep 2010 16:41:22 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863DBA4@dbde02.ent.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D9E5@dbde02.ent.ti.com>
 <20100923085138.GG4580@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50251 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0IWLLa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 07:11:30 -0400
In-Reply-To: <20100923085138.GG4580@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi, 

>-----Original Message-----
>From: Balbi, Felipe 
>Sent: Thursday, September 23, 2010 2:22 PM
>To: Kalliguddi, Hema
>Cc: Balbi, Felipe; linux-omap@vger.kernel.org; 
>linux-usb@vger.kernel.org; Basak, Partha; Tony Lindgren; Kevin 
>Hilman; Cousson, Benoit; Paul Walmsley
>Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
>
>Hi,
>
>On Thu, Sep 23, 2010 at 02:51:12AM -0500, Kalliguddi, Hema wrote:
>>>these two should a separate series, otherwise it's difficult for
>>>different maintainers to decide what they need to pick up :-)
>>>
>>I don't mind
>
>if you're re-sending already, please do split :-)
>

Ok. I will do that.

>>>I would rather remove these, adding ifdefs is bad :-( Unless
>>>other archs
>>>(blackfin, davinci) would have problems if we remove those.
>>>
>>If we remove this then how the clock will be enabled for the other
>>platforms where runtime pm is not used?
>
>yeah, let's see what other archs will say...
>
>>>>@@ -2457,9 +2465,26 @@ static int musb_resume_noirq(struct devi
>>>> 	return 0;
>>>> }
>>>>
>>>>+static int musb_runtime_suspend(struct device *dev)
>>>>+{
>>>>+	struct musb	*musb = dev_to_musb(dev);
>>>
>>>missing lock ??
>>I am wondering whether we need the lock here? As these 
>functions are supposed to be
>>Called by runtime pm framework only.
>
>is that done with IRQs disabled ?

At high level it was looking like the irqs are disabled by looking below function.

int pm_runtime_resume(struct device *dev)
{
	int retval;

	spin_lock_irq(&dev->power.lock);
	retval = __pm_runtime_resume(dev, false);
	spin_unlock_irq(&dev->power.lock);

	return retval;
}

But after going through further details, before calling the driver's 
pm->runtime_suspend/resume functions the irqs are enabled back.
So we need to have lock.

>
>>>>+	musb_save_context(musb);
>>>
>>>shouldn't you disable the clock here ?
>>>
>>This hook is called when we call pm_runtime_put_sync api which takes
>>care of disabling clocks and configuring the sysconfig register.
>
>but those are methods you have provided, right ? I mean, in the end
>it'll call musb_runtime_suspend() and musb_runtime_resume() ?? Or am I
>missing something ?

The flow when you call pm_runtime_put_sync is as below.

1. Calls the driver's runtime_suspend hook
2. Configures the sysconfig
3. Disable the clocks.

The driver's runtime_suspend/resume hooks are provided to prepare the
Device for the idle incase if there is something to be done. For 
Example you can use it for storing the context and restoring the context.
Since framework is taking of diabling the clock when runtime pm funtions are
called so there is no need of disabling the clock here.

>
>>>should you pm_runtime_put_sync(dev) here ??
>>>
>>Calling pm_runtime_put_sync leading to crash as
>>driver_detach calls __device_release_driver which intern calls
>>pm_runtime_put_sync function, with this the musb clocks are 
>already disabled
>>And usecount is 0.
>
>looks weird though, I'll have to read that code more carefully when you
>send another version.
>
OK.

>>>>-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>>>>-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
>>>>-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>>>>+	pm_runtime_enable(dev);
>>>>+	pm_runtime_get_sync(dev);
>>>
>>>seems like you're going to call pm_runtime_get_sync twice ? once here
>>>and another time on musb_resume_noirq(). why ?
>>
>>pm_runtime_get_sync is called in the musb_platform_resume function
>>during the initialization of the driver. Where we need to 
>enable the clocks
>>and put the sysconfig registers to known configurations.
>>
>>pm_runtime_get_sync is called in musb_resume_noirq() to 
>re-enable the cloks
>>and configure the sysconfig because the clocks are disabled 
>in musb_suspend()
>>by calling pm_runtime_put_sync() during global suspend/resume.
>
>hmm, also weird logic. I'll wait for next version and read that code
>with more care.
>

musb_platform_resume functions gets executed when the driver is loaded.
Clock hs to be enabled before accessing the registers so calling the
pm_runtime_get_sync api to do the same.

When there is global suspend initiated, driver's pm_ops functions
Musb_suspend api is called and the clocks are disabled.
Now when the system resumes after wakeup,
Musb_resume_noirq is called, now need to re-enable the clocks so calling
pm_runtime_get_sync function.

Do you see wny problem with it?

>-- 
>balbi
>