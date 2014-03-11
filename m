From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
Date: Tue, 11 Mar 2014 13:07:15 +0000
Message-ID: <20140311130715.GM21216@lee--X1>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <531ECDCB.4060700@ti.com>
 <20140311120259.GI21216@lee--X1>
 <531EFE97.1090202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <531EFE97.1090202@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> >>> This patchset brings up USB Host ports and Ethernet port on
> >>> the OMAP5 uEVM board.
> >>>
> >>> It also does some cleanup with respect to DT clock binding
> >>> for the mfd/omap-usb-host driver.
> >>>
> >>> Please queue these for -next.
> >>>
> >>> Lee,
> >>>
> >>> I've folded some platform data dependent patches with mfd patches
> >>> so that they don't break functionality when applied individually.
> >>> You can safely pull in all MFD patches (1 to 6).
> >>>
> >>> Tony & Benoit,
> >>>
> >>> Can you please accept patches 7, 8 and 9?
> >>
> >> Tony has already picked up 7,8 and 9 through omap-soc tree.
> >>
> >> Since you acked most patches except 5 and 6, are you fine if Tony =
takes
> >> all the patches 1 to 4 in this series via omap-soc tree?
> >>
> >> What about patches 5 and 6?
> >=20
> > Any patches which are orthogonal can just be sucked into whichever =
tree
> > they belong in. If there are inter-subsystem dependencies I'd prefe=
r
> > to take them and issue a immutable branch pull-request to the other
> > maintainers.
> >=20
> Awesome. That would be great, thanks.

That does mean I need a) all of the Maintainer Acks and b) you to tell
me which ones need to go through a single tree.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
