From: Ian Coolidge <iancoolidge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: MUSB-HDRC Gadget driving VBUS inappropriately
Date: Fri, 14 Dec 2012 01:53:07 -0800
Message-ID: <C3E8C797-AE49-4638-B41B-B3AE180D3426@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, icoolidge-N6lXUpBFt8Mlk5EcyZIkJQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

We're using Linux 3.3 on DM3730 with TPS6595xx PMIC for an embedded product.
For a particular board, we have musb-hdrc (RTL 1.4) configured in peripheral mode.
We use the Ethernet gadget configured for cdc_eem to use Ethernet emulation over USB for this link, and the robustness of the link is mission-critical. To assure this, we have performed some massive reboot testing to ensure that this usb link reliably comes up.

After working through an issue which required pulling in the following patch,
-----
commit b1b552a69b8805e7e338074a9e8b670b4a795218
Author: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date:   Wed Aug 8 11:48:10 2012 +0200

    usb: gadget: u_ether: fix kworker 100% CPU issue with still used interfaces in eth_stop
-----

we find that with about a 2% chance, the gadget comes up in some kind of firmware failed state, driving VBUS.
In this condition, we found that MUSB_DEVCTL_SESSION bit was set.
I understand this to be indicative of MUSB thinking it is in host mode, which agrees with the driven VBUS.
Further, in this state, I found that usually, there was one interrupt from twl4030_usb, but NO interrupts from musb-hdrc.

So, as a hack, I cleared MUSB_DEVCTL_SESSION in omap2430.c in the notifier block from the VBUS interrupt.
This appears to reduce the frequency of the problem -- I now always at least one instance of the musb-hdrc interrupt.
However, sometimes, it looks like the MUSB PHY dies shortly thereafter.
So, I don't think this hack is fully effective.

I reviewed commits that post-date 3.3 in omap2430.c, musb_core.c, twl4030-usb.c, musb_gadget.c, and I couldn't find anything interesting -- it looks like mostly reorganization has taken place.

We have also engaged TI to try to get some silicon errata from Mentor Graphics, and maybe a register manual for the MUSB HDRC IP, but this is slow going, and that has little guarantee of paying off anyways.

Are there any ideas, or patches that anyone might suggest?

Thanks!

Ian--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
