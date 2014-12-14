From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: bluetooth: Add hci_h4p driver
Date: Sun, 14 Dec 2014 11:40:31 +0100
Message-ID: <20141214104031.GA30692@amd>
References: <20141213223727.GA13894@amd>
 <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <570BAC61-3137-42E5-B4F8-A61AEED380DE-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun 2014-12-14 00:30:13, Marcel Holtmann wrote:
> Hi Pavel,
> 
> > Add hci_h4p bluetooth driver to staging tree. This device is used
> > for example on Nokia N900 cell phone.
> > 
> > Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > Thanks-to: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> > Thanks-to: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
> > 
> > ---
> > 
> > 
> > I'd prefer to resurect the driver in staging/ in order not to lose
> > history, but Marcel wanted to treat it as new submission, so I'm doing
> > that.
> 
> that history is in linux.git now for all times. No need to repeat it. I rather not play around with that again. Lets get a minimal driver merged so we can give people something to improve.
>

We will merge minimum version. Still I'd like complete history for
credits and bisect and easy ability to diff original and minimum
version.

> > Firmware load was converted to hci_cmd_sync(). Unfortunately, the
> > firmware is needed after every open/close, so the setup mechanism does
> > not quite fit. (But code is now way cleaner).
> 
> What is the reason for that? Does it mean that the device will always loose all its settings when powering it down. Do we know why that is that way and can we maybe change it?
> 
> If there is no way around this, we can introduce a quirk that will always run hdev->setup. However if the device keeps forgetting all settings all the time, that means it will also keep forgetting its address. So that power on procedure will be wasting time. We would need to check if we can make it so that it only has unconfigured state once and then keeps remembering the address even if we have to re-program it every time.
> 
> > Device tree bindings work for me, but they are not yet official and I
> > expect some more fun there.
> > 
> > Hacks surrounding bluetooth address were removed; this results in
> > working driver with address that is probably not unique.
> 
> Just set HCI_QUIRK_INVALID_BDADDR and let someone deal with that in
> userspace. You can use the btmgmt public-addr command for testing.

What command would that be? Do I need some new versions of tools?

root@n900:/my/modules# man hciconfig
(don't see anything relevant).
root@n900:/my/modules# btmgmt
-bash: btmgmt: command not found
root@n900:/my/modules# apt-cache search btmgmt
root@n900:/my/modules#

> On the kernel side you need to add hdev->set_bdaddr support. For the Broadcom based devices you can copy it from the btusb.c driver.
> 

I tried doing that from setup, but either command failed or it killed
hte kernel. 

> > HCI_QUIRK_RESET_ON_CLOSE will need to be investigated some more.
> 
> Why was that needed again? If the device loses power anyway, then that seems wasteful. Also the core changed to make sure it resets all settings on power down correctly.
>

Ok.

> > My notes say that Marcel wanted different filenames, but I'd need
> > advice exactly what filenames. I guess platform data supprort should
> > be removed altogether, rather than renamed.
> 
> Yes, the platform support should go away. This should be purely based on DT.
> 
> Can you also start using git format-patch so that patches get a diffstat.

I can do diffstat manually for you, git format-patch does not fit my
workflow.

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
