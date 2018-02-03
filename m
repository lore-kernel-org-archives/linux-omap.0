From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: power management problems in ehci-omap
Date: Sun, 4 Feb 2018 00:03:48 +0100
Message-ID: <20180204000335.29812776@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I booted a 4.15 kernel without udev and loaded modules piece by piece to analyze
pm problems. modprobe ehci-omap increases current by around 35mA and
also rmmod ehci-omap does not let it go down at all.

I expect that removing hardware does the same thing

Also suspend current increases by around 15mA if that module is loaded.
I tested with having everything disabled which is attached to that usb bus.

System was 
GTA04A5 (with dm3730 processor and usb3322 phy)

I know it has worked once, but I do not remember the version.

The kernel config used can be found here:
http://misc.andi.de1.cc/config-4.15.gz

Regards
Andreas
BTW: I am at the FOSDEM, will probably spend a lot of time in the
hw enablement devroom. So maybe ideas could be discussed directly.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
