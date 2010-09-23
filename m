From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Thu, 23 Sep 2010 11:51:38 +0300
Message-ID: <20100923085138.GG4580@legolas.emea.dhcp.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D9E5@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43084 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab0IWIvr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 04:51:47 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D9E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Thu, Sep 23, 2010 at 02:51:12AM -0500, Kalliguddi, Hema wrote:
>>these two should a separate series, otherwise it's difficult for
>>different maintainers to decide what they need to pick up :-)
>>
>I don't mind

if you're re-sending already, please do split :-)

>>I would rather remove these, adding ifdefs is bad :-( Unless
>>other archs
>>(blackfin, davinci) would have problems if we remove those.
>>
>If we remove this then how the clock will be enabled for the other
>platforms where runtime pm is not used?

yeah, let's see what other archs will say...

>>>@@ -2457,9 +2465,26 @@ static int musb_resume_noirq(struct devi
>>> 	return 0;
>>> }
>>>
>>>+static int musb_runtime_suspend(struct device *dev)
>>>+{
>>>+	struct musb	*musb = dev_to_musb(dev);
>>
>>missing lock ??
>I am wondering whether we need the lock here? As these functions are supposed to be
>Called by runtime pm framework only.

is that done with IRQs disabled ?

>>>+	musb_save_context(musb);
>>
>>shouldn't you disable the clock here ?
>>
>This hook is called when we call pm_runtime_put_sync api which takes
>care of disabling clocks and configuring the sysconfig register.

but those are methods you have provided, right ? I mean, in the end
it'll call musb_runtime_suspend() and musb_runtime_resume() ?? Or am I
missing something ?

>>should you pm_runtime_put_sync(dev) here ??
>>
>Calling pm_runtime_put_sync leading to crash as
>driver_detach calls __device_release_driver which intern calls
>pm_runtime_put_sync function, with this the musb clocks are already disabled
>And usecount is 0.

looks weird though, I'll have to read that code more carefully when you
send another version.

>>>-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>>>-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
>>>-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>>>+	pm_runtime_enable(dev);
>>>+	pm_runtime_get_sync(dev);
>>
>>seems like you're going to call pm_runtime_get_sync twice ? once here
>>and another time on musb_resume_noirq(). why ?
>
>pm_runtime_get_sync is called in the musb_platform_resume function
>during the initialization of the driver. Where we need to enable the clocks
>and put the sysconfig registers to known configurations.
>
>pm_runtime_get_sync is called in musb_resume_noirq() to re-enable the cloks
>and configure the sysconfig because the clocks are disabled in musb_suspend()
>by calling pm_runtime_put_sync() during global suspend/resume.

hmm, also weird logic. I'll wait for next version and read that code
with more care.

-- 
balbi
