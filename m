From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 1/7] usb: dwc3: get "usb_phy" only if the platform
 indicates the presence of PHY's
Date: Tue, 3 Dec 2013 12:39:50 +0200
Message-ID: <20131203103950.GB26423@xps8300>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
 <1381866857-3861-2-git-send-email-kishon@ti.com>
 <525E8E93.9010503@ti.com>
 <525E9046.3090209@ti.com>
 <525E943E.3080706@ti.com>
 <20131017145425.GE11611@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131017145425.GE11611@gimli>
Sender: linux-doc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, gregkh@linuxfoundation.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, s.nawrocki@samsung.com, galak@codeaurora.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Oct 17, 2013 at 09:54:26AM -0500, Felipe Balbi wrote:
> On Wed, Oct 16, 2013 at 04:27:26PM +0300, Roger Quadros wrote:
> > On 10/16/2013 04:10 PM, Kishon Vijay Abraham I wrote:
> > Do you know if there are users of dwc3 other than exynos5250 and omap5?
> > If not, we should get rid of the old USB PHY altogether.
> 
> Intel's Baytrail, at least. But they don't use DT.

I don't see any use for the generic-phy when the device is enumerated
from PCI. If dwc3 can live without phys, there should not be any
problem dropping the old USB PHY support.

Br,

-- 
heikki
