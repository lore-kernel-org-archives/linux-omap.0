From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am33xx: Remove unnecessary properties
Date: Tue, 11 Dec 2018 08:36:18 -0800
Message-ID: <20181211163618.GU6707@atomide.com>
References: <20181210132448.7865-1-fb@ltec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181210132448.7865-1-fb@ltec.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Brack <fb@ltec.ch>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com, robh+dt@kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felix Brack <fb@ltec.ch> [181210 05:25]:
> Remove the unnecessary properties #address-cells and #size-cells
> of node pinmux as there are no child-nodes with property reg.

Applying into omap-for-v4.21/dt thanks.

Tony
