From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: Add generic handling for hardware incomplete fail
 state
Date: Tue, 12 Apr 2016 13:13:50 -0700
Message-ID: <570D56FE.2070408@gmail.com>
References: <1460486275-12256-1-git-send-email-tony@atomide.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460486275-12256-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tom Rini <trini@konsulko.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I agree with the need for some way of handling the incomplete
hardware issue.  I like the idea of having a uniform method for
all nodes.

I am stumbling over what the status property is supposed to convey
and what the "fail-hw-incomplete" is meant to convey.

The status property is meant to convey the current state of the
node.

"fail-hw-incomplete" is meant to describe the node implementation,
saying that some portions of hardware that the driver expects to
be present do not exist.  If I understood your explanation at ELC
correctly, an examples of this could be that a uart cell is not
routed to transmit and receive data pins or the interrupt line
from the cell is not routed to an interrupt controller.  So the
node is not useful, but it makes sense to be able to power manage
the node, turning off power so that it is not wasting power.

It seems to me that the info that needs to be conveyed is a
description of the hardware, stating:
  - some portions or features of the node are not present and/or
    are not usable
  - power management of the node is possible

Status of "fail-sss" is meant to indicate an error was detected in
the device, and that the error might (or might not) be repairable.

So the difference I see is state vs hardware description.

I would prefer to come up with a new boolean property (with a
standard name that any node binding could choose to implement)
that says something like "only power management is available for
this node, do not attempt to use any other feature of the node".

With that change, the bulk of your patch looks good, with
minor changes:

  __of_device_is_available() would not need to change.

  __of_device_is_incomplete() would change to check the new
  boolean property.  (And I would suggest renaming it to
  something that conveys it is ok to power manage the
  device, but do not do anything else to the device.)

-Frank
