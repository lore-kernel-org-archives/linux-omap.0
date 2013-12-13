From: David Cohen <david.a.cohen@linux.intel.com>
Subject: Re: [PATCH 3/7] usb: dwc3: pci: add pm_runtime support
Date: Thu, 12 Dec 2013 17:56:05 -0800
Message-ID: <20131213015605.GC29964@psi-dev26.jf.intel.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386884325-11440-4-git-send-email-balbi@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, kgene.kim@samsung.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, w-kwok2@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 12, 2013 at 03:38:41PM -0600, Felipe Balbi wrote:
> teach the PCI glue about pm_runtime so that
> it's easier to teach dwc3 core about it
> later.
> 
> No functional changes otherwise.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

I was able to test this one with Intel Merrifield:
Acked-by: David Cohen <david.a.cohen@linux.intel.com>
