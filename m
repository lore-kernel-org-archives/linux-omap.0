From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] usb: musb: fix context save over suspend.
Date: Tue, 12 Feb 2013 13:03:36 -0800
Message-ID: <87zjz9i6s7.fsf@linaro.org>
References: <20130121202831.40a09bbc@notabene.brown>
	<50FD28D3.5070107@compulab.co.il>
	<20130122083832.7a3026c9@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130122083832.7a3026c9@notabene.brown> (NeilBrown's message of
	"Tue, 22 Jan 2013 08:38:32 +1100")
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

NeilBrown <neilb@suse.de> writes:

> On Mon, 21 Jan 2013 13:38:59 +0200 Igor Grinberg <grinberg@compulab.co.il>
> wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>> 
>> Hi Neil,
>> 
>> On 01/21/13 11:28, NeilBrown wrote:
>> > 
>> > 
>> > The standard suspend sequence involves runtime_resuming
>> > devices before suspending the system.
>> > So just saving context in runtime_suspend and restoring it
>> > in runtime resume isn't enough.  We  must also save in "suspend"
>> > and restore in "resume".
>> > 
>> > Without this patch, and OMAP3 system with off_mode enabled will find
>> > the musb port non-functional after suspend/resume.  With the patch it
>> > works perfectly.
>> 
>> Hmmm... Some time ago, this has been removed in
>> 5d193ce8 (usb: musb: PM: fix context save/restore in suspend/resume path)
>> 
>> Am I missing something? Or things changed and now this patch is correct?
>
> Hi Igor,
>  thanks for alerting me to that patch .... does anyone else get the feeling
>  that power management to too complex to be understood by a mere human?

Yes.  ;)

>  That commit (5d193ce8) suggests that the musb-hdrc device is an
>  'omap_device', or maybe has a PM domain set to something else.
>  However it isn't/doesn't.  dev->pm_domain is NULL.  So no PM domain layer
>  will ever call the musb_core musb_runtime_suspend/resume.
>
>  The parent device - musb-omap2430 - is an omap device, does have pm_domain
>  set, and does have its omap2430_runtime_suspend/resume called for system
>  suspend and so the context for that device is saved and restored.
>  However that doesn't help the context for musb-hdrc.
>
>  Whether musb ever was an omap_device is beyond my archaeological skills to
>  determine.
>
>  Kevin:  Was musb-hdrc ever a device with a pm_domain? or was it only ever
>      the various possible parents that had domains?
>      Are you able to defend your earlier patch in today's kernel?  It
>      certainly causes my device not to work properly.

Sorry for the delay here, I'm back to a place where I can test this on
real hardware.

My patch was fixing a real hang when musb was built-in (or loaded), in
host-mode (mini-A cable attached) but no devices attached.  I just tried
to reproduce this, and with your patch, the system hangs during suspend.

That being said, your description makes sense why this context
save/restore is needed.  Perhaps your patch needs to add a check whether
the device is runtime suspended (I gather this is what Ruslan's patch is
doing.)

Kevin
