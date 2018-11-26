From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Mon, 26 Nov 2018 15:41:16 -0800
Message-ID: <20181126234116.GQ53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
 <a4fe952b-9065-d91b-4c07-984ec3f5b276@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a4fe952b-9065-d91b-4c07-984ec3f5b276@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: Roger Quadros <rogerq@ti.com>, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* David Lechner <david@lechnology.com> [181126 21:14]:
> I haven't looked into Tony's suggestion of using ti-sysc yet, so this may be a
> moot point, but how will this work with AM18xx that does not have a PRUSS CFG
> register? It seems to me that reg here should be the address and size of the
> entire PRUSS IP block and the CFG register should be a syscon node or something
> like that.

The SoC specific wrapper IP is probably different on am18xx compared
to omaps, it might be TIPB like on omap1?

If am18xx has something simlar to omaps, there would be revision,
sysconfig and sysstatus registers typically at offsets 0x00, 0x10
and 0x14.

The wrapper IP code should be independent of the PRU code and just
provide services to the PRU. For a minimal wrapper IP driver example
that might work for am18xx see for drivers/usb/musb/musb_am335x.c.

Regards,

Tony
