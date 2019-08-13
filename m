From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] bus: ti-sysc: fixes for reset handling
Date: Tue, 13 Aug 2019 04:33:45 -0700
Message-ID: <20190813113345.GP52127@atomide.com>
References: <1565181965-21039-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565181965-21039-1-git-send-email-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, s-anna@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [190807 05:47]:
> Hi,
> 
> Here are a few patches to fix reset handling for ti-sysc bus driver.
> Without these, the iommu won't be working properly at least.

Applying these into omap-for-v5.4/ti-sysc since the prm rstctrl
driver is not yet merged and these should not be needed as fixes
at this point.

Regards,

Tony
