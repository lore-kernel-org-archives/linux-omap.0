From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] of: Add a reg-names property to name reg entries
Date: Wed, 26 Oct 2011 14:23:32 +0200
Message-ID: <20111026122332.GM4429@atomide.com>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
 <20111025082632.GJ4429@atomide.com>
 <440786C5-FA1C-4750-9990-0BA5AABC2190@kernel.crashing.org>
 <4EA6BC54.7030007@ti.com>
 <BC60AF8F-C329-44B9-BEC9-EA5821725E1B@kernel.crashing.org>
 <4EA6DF88.2080704@ti.com>
 <FD4B90D7-4B26-42C2-8CF9-7AA9971BCBEB@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19012 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932751Ab1JZMXz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Oct 2011 08:23:55 -0400
Content-Disposition: inline
In-Reply-To: <FD4B90D7-4B26-42C2-8CF9-7AA9971BCBEB@kernel.crashing.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

* Segher Boessenkool <segher@kernel.crashing.org> [111026 05:22]:
> >>>>What problem does any of this solve?  The device binding for the
> >>>>"mcasp" device will have to describe the possible "reg-names", and
> >>>>what those mean; but the binding already has to describe its "reg"
> >>>>property anyway.
> >>>
> >>>What this solve is the ability to use the
> >>>platform_get_resource_byname directly to retrieve the proper
> >>>register base address.
> >>
> >>You do not have to put it in the device tree for that, the device
> >>driver can implement this itself if it cares.
> >
> >???
> >
> >The driver is the user of that name, so it has to be populated
> >before into the resource during device creation.
> 
> It can be as simple as
> 
> #define FOO_REG_INDEX 0
> #define BAR_REG_INDEX 1
> 
> but you can use C strings if you want to.

Fox pin muxing, we really want to use the actual signal names in
the drivers. The define example above would means mapping the defines
multiple times depending which packaging you're using.

There can be several packages for each SoC, where the pins wired up
whichever way. For example, for a serial driver to use UART RX pin,
the driver can just request a signal called "uart_tx", which is the
actual hardware name for the signal inside the SoC.

Using the signal names also makes it easier to make drivers to support
the same device IP blocks across multiple SoC as the signal name most
likely is the same as what the device IP block is using.

Regards,

Tony 
