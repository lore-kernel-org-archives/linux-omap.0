From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Fri, 16 Mar 2012 17:20:22 +0100
Message-ID: <20120316162022.GA20524@sortiz-mobl>
References: <1330077975-31694-1-git-send-email-keshava_mgowda@ti.com>
 <20120224101632.GL17178@legolas.emea.dhcp.ti.com>
 <CAP05o4KRUp_W1yXn29TATMDOwMVbX_pWt6iKrrb=2jkOuWij+A@mail.gmail.com>
 <CAP05o4J1BYN2WkJToswcp4ofagp2mOuPmwWeMfJRwrfS_xEe0Q@mail.gmail.com>
 <CAP05o4KDYqcU+TbMouQGsMaLUjZsJ7G+Anp9RcvUKuoFqQab3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21588 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030239Ab2CPQM2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 12:12:28 -0400
Content-Disposition: inline
In-Reply-To: <CAP05o4KDYqcU+TbMouQGsMaLUjZsJ7G+Anp9RcvUKuoFqQab3g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, parthab@india.ti.com, govindraj.raja@ti.com, balbi@ti.com

Hi Keshava,

On Thu, Mar 08, 2012 at 08:30:21PM +0530, Munegowda, Keshava wrote:
> On Fri, Mar 2, 2012 at 7:36 PM, Munegowda, Keshava
> <keshava_mgowda@ti.com> wrote:
> > On Fri, Feb 24, 2012 at 5:14 PM, Munegowda, Keshava
> > <keshava_mgowda@ti.com> wrote:
> >> On Fri, Feb 24, 2012 at 3:46 PM, Felipe Balbi <balbi@ti.com> wrote=
:
> >>> Hi,
> >>>
> >>> On Fri, Feb 24, 2012 at 03:36:15PM +0530, Keshava Munegowda wrote=
:
> >>>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
> >>>>
> >>>> It is observed that the echi ports of 3430 sdp board
> >>>> are not working due to the random timing of programming
> >>>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
> >>>> If the PHYs are reset at during usbhs core driver, host ports wi=
ll
> >>>> not work because EHCI driver is loaded after the resetting PHYs.
> >>>> The PHYs should be in reset state while initializing the EHCI
> >>>> controller.
> >>>> The code which does the GPIO pins associated with the PHYs
> >>>> are programmed to reset is moved from the USB host core driver
> >>>> to EHCI driver.
> >>>>
> >>>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> >>>> Reviewed-by: Partha Basak <parthab@india.ti.com>
> >>>
> >>> won't this cause issues with EHCI/OHCI interactions ? I mean, wha=
t if
> >>> you connect a FS/LS device and port is handed over to OHCI, does =
OHCI
> >>> have any needs to reset the PHY or something similar ?
> >>
> >> No, it will not cause any issues with EHCI-OHCI issues.
> >> But its difficult to comment on this because we don't have port
> >> handoff supported
> >> in hardware.
> >>
> >> regards
> >> keshava
> >
> > Hi Samuel
> > =A0 =A0 =A0 =A0please let me know if you have any comments on this =
patch.
> > This is required patch for omap3 ehci enumeration instabilities.
> >
> > Regards
> > Keshava
>=20
> Hi Samuel
>       do you have any comments on this patch?
I actually never received the actual patch, I think.


> Felipe has reviewed this patch and he is agreed for this patch.
> there are no comments from your side, requesting to push this change
> to mainline.
I looked at it on gmame, and it seems fine to me. If you want me to pus=
h this
patch, then please (re-)send it to me, even privately.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
