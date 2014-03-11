From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
Date: Tue, 11 Mar 2014 09:24:29 -0700
Message-ID: <20140311162428.GA7177@atomide.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <531ECDCB.4060700@ti.com>
 <20140311120259.GI21216@lee--X1>
 <531EFE97.1090202@ti.com>
 <20140311130715.GM21216@lee--X1>
 <531F0B49.2070008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <531F0B49.2070008@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140311 06:13]:
> On 03/11/2014 03:07 PM, Lee Jones wrote:
> > 
> >>>>> This patchset brings up USB Host ports and Ethernet port on
> >>>>> the OMAP5 uEVM board.
> >>>>>
> >>>>> It also does some cleanup with respect to DT clock binding
> >>>>> for the mfd/omap-usb-host driver.
> >>>>>
> >>>>> Please queue these for -next.
> >>>>>
> >>>>> Lee,
> >>>>>
> >>>>> I've folded some platform data dependent patches with mfd patches
> >>>>> so that they don't break functionality when applied individually.
> >>>>> You can safely pull in all MFD patches (1 to 6).
> >>>>>
> >>>>> Tony & Benoit,
> >>>>>
> >>>>> Can you please accept patches 7, 8 and 9?
> >>>>
> >>>> Tony has already picked up 7,8 and 9 through omap-soc tree.
> >>>>
> >>>> Since you acked most patches except 5 and 6, are you fine if Tony takes
> >>>> all the patches 1 to 4 in this series via omap-soc tree?
> >>>>
> >>>> What about patches 5 and 6?
> >>>
> >>> Any patches which are orthogonal can just be sucked into whichever tree
> >>> they belong in. If there are inter-subsystem dependencies I'd prefer
> >>> to take them and issue a immutable branch pull-request to the other
> >>> maintainers.
> >>>
> >> Awesome. That would be great, thanks.
> > 
> > That does mean I need a) all of the Maintainer Acks and b) you to tell
> > me which ones need to go through a single tree.
> > 
> 
> You need to take patches 1 to 6 in the MFD tree. Out of these, patches 1 to 4
> need to be shared with Tony as an immutable branch.
> 
> Tony, could you please Ack patches 1 to 4? Thanks.

Changes in 1 to 6 look OK to me, so for those please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
