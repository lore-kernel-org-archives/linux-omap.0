From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] of: Add generic handling for hardware incomplete fail
 state
Date: Tue, 12 Apr 2016 13:34:31 -0700
Message-ID: <20160412203431.GU5995@atomide.com>
References: <1460486275-12256-1-git-send-email-tony@atomide.com>
 <570D56FE.2070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570D56FE.2070408@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tom Rini <trini@konsulko.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Frank Rowand <frowand.list@gmail.com> [160412 13:15]:
> Hi Tony,
> 
> I agree with the need for some way of handling the incomplete
> hardware issue.  I like the idea of having a uniform method for
> all nodes.
> 
> I am stumbling over what the status property is supposed to convey
> and what the "fail-hw-incomplete" is meant to convey.
> 
> The status property is meant to convey the current state of the
> node.
> 
> "fail-hw-incomplete" is meant to describe the node implementation,
> saying that some portions of hardware that the driver expects to
> be present do not exist.  If I understood your explanation at ELC
> correctly, an examples of this could be that a uart cell is not
> routed to transmit and receive data pins or the interrupt line
> from the cell is not routed to an interrupt controller.  So the
> node is not useful, but it makes sense to be able to power manage
> the node, turning off power so that it is not wasting power.

Yes cases like that are common.

> It seems to me that the info that needs to be conveyed is a
> description of the hardware, stating:
>   - some portions or features of the node are not present and/or
>     are not usable
>   - power management of the node is possible
> 
> Status of "fail-sss" is meant to indicate an error was detected in
> the device, and that the error might (or might not) be repairable.
> 
> So the difference I see is state vs hardware description.

OK thanks for the clarification. I don't see why "fail-hw-incomplete"
could not be set dynamically during the probe in some cases based
on the SoC revision detection for example. So from that point of
view using status with the "fail-sss" logic would make more sense.

> I would prefer to come up with a new boolean property (with a
> standard name that any node binding could choose to implement)
> that says something like "only power management is available for
> this node, do not attempt to use any other feature of the node".

Heh that's going to be a long property name :) How about
unusable-incomplete-idle-only :)

> With that change, the bulk of your patch looks good, with
> minor changes:
> 
>   __of_device_is_available() would not need to change.
> 
>   __of_device_is_incomplete() would change to check the new
>   boolean property.  (And I would suggest renaming it to
>   something that conveys it is ok to power manage the
>   device, but do not do anything else to the device.)

I'm fine with property too, but the runtime probe fail state
changes worry me a bit with that one.

I think Rob also preferred to use the status though while we
chatted at ELC?

Regards,

Tony
