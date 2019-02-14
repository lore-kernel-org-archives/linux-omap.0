From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Thu, 14 Feb 2019 07:56:40 -0800
Message-ID: <20190214155640.GD5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <16001a6f-faed-ee14-5ade-79d5462f6d51@ti.com>
 <5C654C39.2030308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5C654C39.2030308@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Suman Anna <s-anna@ti.com>, ohad@wizery.com, bjorn.andersson@linaro.org, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, dan@kulp.com, Matthijs van Duin <matthijsvanduin@gmail.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190214 11:09]:
> Suman is mainly concerned about the following changes in v2
> 1) pruss node does not contain reg property representing entire ICSS.
> 2) pruss node does not contain interrupts.
> 
> Both of these are required if drivers/uio/uio_pruss.c or in future if
> VFIO is to be used.
> 
> The beagleboard community is a primary user of this driver and we need to
> find a solution so that PRUSS is usable either via remoteproc or via UIO.
> 
> Ideal case should allow user to use either of the drivers by just doing
> a unbind and bind.
> 
> I don't have a better idea than having a encapsulating node that has
> the appropriate reg and interrupt properties.

If there are existing use cases that need to be supported
you should list them as non-standard usage in the binding
and not recommended for future use. Rob may have some
comments on how to deal with this.

Then you can have device driver that needs to pass them
parse them from the PRUSS parent node. That does not mean
there needs to be a top level device driver for PRUSS,
the child control module can just parse the non-standard
bindings for compability from the parent node.

And naturally in addition to handling the non-standard
binding we need to have a proper standardized binding
too :)

Regards,

Tony
