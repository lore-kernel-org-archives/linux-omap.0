From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: DRA7: Add pcie1 dt node for EP mode
Date: Thu, 10 Aug 2017 10:06:18 -0700
Message-ID: <20170810170617.GN8569@atomide.com>
References: <20170808054024.18507-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170808054024.18507-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [170807 22:41]:
> Add pcie1 dt node in order for the controller to operate in
> endpoint mode. However since none of the dra7 based boards have
> slots configured to operate in endpoint mode, keep EP mode
> disabled.

Applying into omap-for-v4.14/dt thanks.

Tony
