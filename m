From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: bluetooth: Add hci_h4p driver
Date: Sun, 14 Dec 2014 23:41:38 +0100
Message-ID: <20141214224138.GA11447@amd>
References: <20141213223727.GA13894@amd>
 <570BAC61-3137-42E5-B4F8-A61AEED380DE@holtmann.org>
 <20141214192124.GA22392@amd>
 <D1F25806-07C6-4876-8E62-A16CFB6827EA@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <D1F25806-07C6-4876-8E62-A16CFB6827EA-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi!

> >>> Hacks surrounding bluetooth address were removed; this results in
> >>> working driver with address that is probably not unique.
> >> 
> >> Just set HCI_QUIRK_INVALID_BDADDR and let someone deal with that in userspace. You can use the btmgmt public-addr command for testing.
> >> 
> > 
> > Ok, it took me a while to figure out that --enable-experimental is
> > needed.
> > 
> > Then help was playing tricks with me:
> > 
> > For more information on the usage of each command use:
> >    btmgmt <command> --help
> > root@n900:/my/bluez-5.26/tools# ./btmgmt public-addr --help
> > Set Public Address for hci0 failed with status 0x0b (Rejected)
> > root@n900:/my/bluez-5.26/tools# ./btmgmt public-addr
> > Usage: btmgmt public-addr <address>
> 
> that is indeed confusing. Something went wrong with that tool. Just keep in mind that tool is just for internal testing by the developers. Someone would still need to write a proper integration with listening for the appropriate events and dig out the actual address from the memory location.
>

You have patch that helps that issues in the email :-).

> > root@n900:/my/bluez-5.26/tools# ./btmgmt public-addr 01:02:03:04:05:06
> > Set Public Address for hci0 failed with status 0x0b (Rejected)
> > 
> > Hmm. Since setting public address only works when interface is down,
> > and we lose all the settings during up, this does not work at all,
> > right?
> 
> It does keep it. The address is stored in hdev->public_addr which is actually different from hdev->bdaddr which is the current address in use.
> 
> However I am not sure that hdev->set_bdaddr is executed again. Same
> as hdev->setup is not executed twice. The controller loosing all
> states is something we have not yet encountered. At least not
> while the hci_dev stays around.

It looks like that's the exact issue. It seems to me like set_bdaddr
is actually called while the device is "down".

> I wonder if the drastic power off might be better hooked into a
> platform RFKILL switch. And with that you would just unregister
> hci_dev and re-register it when the RFKILL switch is unblocked.

Ok, so kernel currently wants bluetooth out of reset at 

> The other option is to introduce a quirk that allows running hdev->setup and hdev->set_bdaddr all the time when you bring up your device.
> 
> Another alternate idea for getting something upstream for testing is to ignore the whole firmware loading in the kernel and bring up the controller with HCI_QUIRK_EXTERNAL_CONFIG. Doing that would allow you to do bette testing and evolve the driver in small tests.
>

Actually, firmware loading is _not_ the biggest problem. That is
pretty self-contained now.

I guess I should just configure it at probe time, put it into reset
during rmmod, keep it out of reset otherwise, and see how it works.

Thanks,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
