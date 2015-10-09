From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC PATCH 0/2] DRA72/DRA74: Add 2 lane support
Date: Fri, 9 Oct 2015 18:53:28 -0500
Message-ID: <20151009235328.GB623@localhost>
References: <1443445058-643-1-git-send-email-kishon@ti.com>
 <20151009225056.GD16112@localhost>
 <56184AE7.6060808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56184AE7.6060808@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bhelgaas@google.com, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 10, 2015 at 04:46:55AM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> On Saturday 10 October 2015 04:20 AM, Bjorn Helgaas wrote:
> > [+cc Arnd, Rob]
> > 
> > On Mon, Sep 28, 2015 at 06:27:36PM +0530, Kishon Vijay Abraham I wrote:
> >> Add driver modifications in pci-dra7xx to get x2 mode working in
> >> DRA72 and DRA74. Certain modifications is needed in PHY driver also
> >> which I'll send as a separate series.
> >>
> >> Kishon Vijay Abraham I (2):
> >>   pci: host: pci-dra7xx: use "num-lanes" property to find phy count
> >>   pci: host: pci-dra7xx: Enable x2 mode support
> > 
> > Applied to pci/host-dra7xx for v4.4, thanks!
> > 
> > I adjusted the subject line capitalization & format to match the history.
> > 
> > Arnd, Rob, any comments on the DT updates or the "num-lanes" vs number of
> > strings in "phy-names" changes?
> 
> I sent it as RFC since I didn't have the board to test 2 lane mode with
> $patch. And just now I got a board to test x2 and I found a problem with
> the 2nd patch.
> 
> .b1co_mode_sel_mask = GENMASK(2, 3), in the patch should be replaced with
> .b1co_mode_sel_mask = GENMASK(3, 2).
> 
> I'll resend the patch fixing the above.

OK, I dropped these two patches.  Thanks for letting me know.
