From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] usb: musb: fix context save over suspend.
Date: Tue, 12 Feb 2013 17:13:38 -0800
Message-ID: <87ip5xggn1.fsf@linaro.org>
References: <20130121202831.40a09bbc@notabene.brown>
	<50FD28D3.5070107@compulab.co.il>
	<20130122083832.7a3026c9@notabene.brown> <87zjz9i6s7.fsf@linaro.org>
	<20130213120121.3df7dd88@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130213120121.3df7dd88@notabene.brown> (NeilBrown's message of
	"Wed, 13 Feb 2013 12:01:21 +1100")
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

NeilBrown <neilb@suse.de> writes:

> On Tue, 12 Feb 2013 13:03:36 -0800 Kevin Hilman <khilman@linaro.org> wrote:
>
>> NeilBrown <neilb@suse.de> writes:
>> 

[...]

>> My patch was fixing a real hang when musb was built-in (or loaded), in
>> host-mode (mini-A cable attached) but no devices attached.  I just tried
>> to reproduce this, and with your patch, the system hangs during suspend.
>> 
>
> Odd.  I plug in a mini-A cable, note that the 'mode' file holds
> 'a_idle' (sometimes just plugging in the cable isn't enough to trigger that,
> but sometimes it is....) and suspend/resume work perfectly.  Though after
> resume it is back to b_idle.
>
> unplug/replug and it is back to  a_idle.  suspend/resume and back to b_idle.
>
>> That being said, your description makes sense why this context
>> save/restore is needed.  Perhaps your patch needs to add a check whether
>> the device is runtime suspended (I gather this is what Ruslan's patch is
>> doing.)
>
> I'm not sure it is possible for the device to be runtime suspended at this
> point.  Certainly my device never is, even if it was just before the suspend
> sequence started. Something is waking it up...
> (instruments the code).
>
> Ahh - usb_suspend() calls choose_wakeup() which might call
> pm_runtime_resume() if the could be a need to reprogram the wakeup setting.
> As that is a 'might', the device might not be runtime-awake when 'suspend'
> runs.
>
> Can you see if this, on top of my previous patch, does any better on your
> hardware?

Yes, this patch adding the check on top of your previous one makes
things work just fine on my hardware (3530/Overo).

Kevin

> Thanks,
> NeilBrown
>
>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 956db0e..00deb94 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2278,7 +2278,8 @@ static int musb_suspend(struct device *dev)
>  	}
>  
>  	spin_unlock_irqrestore(&musb->lock, flags);
> -	musb_save_context(musb);
> +	if (!pm_runtime_status_suspended(dev))
> +		musb_save_context(musb);
>  	return 0;
>  }
>  
> @@ -2289,7 +2290,8 @@ static int musb_resume_noirq(struct device *dev)
>  	 * module got reset through the PSC (vs just being disabled).
>  	 */
>  	struct musb	*musb = dev_to_musb(dev);
> -	musb_restore_context(musb);
> +	if (!pm_runtime_status_suspended(dev))
> +		musb_restore_context(musb);
>  	return 0;
>  }
>  
