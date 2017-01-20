From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 37/37] ARM: dts: DRA7: Add pcie1 dt node for EP mode
Date: Fri, 20 Jan 2017 10:30:00 -0800
Message-ID: <20170120183000.GF7403@atomide.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-38-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484216786-17292-38-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [170112 02:34]:
> Add pcie1 dt node in order for the controller to operate in
> endpoint mode. However since none of the dra7 based boards have
> slots configured to operate in endpoint mode, keep EP mode
> disabled.

Can this be merged separately later on without breaking anything?

Regards,

Tony
