From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] dra7/omap5: Increase max-voltage of pbias to 3.3v
Date: Wed, 11 Oct 2017 08:46:10 -0700
Message-ID: <20171011154610.GA4394@atomide.com>
References: <20171009055312.24165-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171009055312.24165-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [171008 22:54]:
> Max voltage of pbias was set to 3.0v because of an error in TRM in
> omap5/dra7 SoCs. It's now corrected to be 3.3v.
> 
> Corresponding change in pbias regulator driver is already merged in
> ulf -next
> commit 27eae9d4b9d4cd9c204ef81f46078d91362ed41c

Thanks applying both into omap-for-v4.15/dt.

Regards,

Tony
