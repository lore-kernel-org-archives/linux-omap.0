From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Wed, 13 Jan 2016 09:19:14 -0800
Message-ID: <20160113171913.GH12777@atomide.com>
References: <1452667666-17533-1-git-send-email-kishon@ti.com>
 <1452667666-17533-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452667666-17533-4-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [160112 22:48]:
> Use platform populated reset assert and deassert
> callbacks to perform reset of PCIe.
> 
> Use these callbacks until a reset interface using drivers/reset
> is available for the purpose.

This one has a dependency to the second patch for the platform
data.

Bjorn, how do you prefer to merge this once there are no more
comments?

How about I set up an immutable branch against v4.5-rc1 with
just these three patches that we can both then merge in?

My preference is to add this to linux next after the merge
window for v4.6. Bjorn, if you want it merged as fixes, I'm
fine with that too naturally.

Regards,

Tony
