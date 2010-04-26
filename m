From: Gregory CLEMENT <gclement00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/3] usb: ohci: introduce ohci-hcd driver for omap3
Date: Mon, 26 Apr 2010 07:57:20 +0200
Message-ID: <j2l305035a41004252257t189738cfj5fac86059b0b6192@mail.gmail.com>
References: <1272256489-3389-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272256489-3389-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/4/26 Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>
> Hi all,
>
> This patch series adds the bus glue layer for the OHCI controller
> on OMAP3 and later chips. This controller is a companion
> to the EHCI controller on that chip, and some code is common
> between the two drivers. The driver has been sitting in internal
> trees for ages, and I've finally found time to clean it up
> and submit it.
>
> The older OMAP1 and OMAP2 chips had a different OHCI controller,
> which already has driver support in mainline. I don't have access
> to any boards with this old controller and haven't tested the old
> driver on those boards - not sure if it still works.
> (Also, I made some updates to Kconfig, and have not yet
> updated the defconfigs for those omap1/2 boards. I'll update them
> if the Kconfig changes are okay)
>
> This controller supports multiple interface modes. Only 2 of them
> (3-pin DAT/SE0 and 4-pin DP/DM PHY modes) have been tested with this
> driver. (However the only change for the other modes is one register
> setting for selecting the mode, and the padconf setting for the omap
> pads, so I expect it to work correctly).
> (Someone did offer to test the 6-pin mode. Still awaiting results...)

[sending it again with no html inside]

Hi,
I am the one who offer to test 6-pin mode. Unfortunally, I still have
some problem.
The current version of our kernel is 2.6.33 so first I try to back
port your patch for our version, and so kernel crashes during access
to USB controller.
Then I try to port our kernel to the last version of Linux, but now I
can't see any traces on serial port after "Uncompressing Linux...
done, booting the kernel..".
I am still stuck to these problems which are not really related to your=
 patches.

--
Gregory CLEMENT
Responsable Technique Linux embarqu=E9 - Europe
Embedded Linux Development Lead - EMEA

Adeneo Embedded - Adetel Group
2, chemin du Ruisseau
69134 ECULLY - FRANCE
T=E9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
