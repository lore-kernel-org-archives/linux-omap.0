From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 08/15] PCI: endpoint: Fix pci_epf_alloc_space to set
 correct MEM TYPE flags
Date: Fri, 15 Feb 2019 09:52:21 +0000
Message-ID: <20190215095214.GA24988@e107981-ln.cambridge.arm.com>
References: <20190114111513.21618-1-kishon@ti.com>
 <20190114111513.21618-9-kishon@ti.com>
 <20190211173723.GA31035@e107981-ln.cambridge.arm.com>
 <ebadc615-f633-e84e-041a-99b7936a123b@ti.com>
 <20190214162928.GA32523@e107981-ln.cambridge.arm.com>
 <edc76e9b-bdd4-80bb-3dff-1d44a100c153@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <edc76e9b-bdd4-80bb-3dff-1d44a100c153@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 15, 2019 at 11:49:12AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 14/02/19 9:59 PM, Lorenzo Pieralisi wrote:
> > On Wed, Feb 13, 2019 at 07:17:14PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi Lorenzo,
> >>
> >> On 11/02/19 11:07 PM, Lorenzo Pieralisi wrote:
> >>> On Mon, Jan 14, 2019 at 04:45:06PM +0530, Kishon Vijay Abraham I wrote:
> >>>> pci_epf_alloc_space() sets the MEM TYPE flags to indicate a 32-bit
> >>>> Base Address Register irrespective of the size. Fix it here to indicate
> >>>> 64-bit BAR if the size is > 2GB.
> >>>>
> >>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>> ---
> >>>>  drivers/pci/endpoint/pci-epf-core.c | 4 +++-
> >>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> This looks like a fix and should me marked as such. Does it work
> >>> as as standalone patch if it gets backported ?
> >>
> >> Yeah, it should work. But the current users doesn't allocate > 2GB and some
> >> EPC drivers configure their registers based on size. So nothing is broken
> >> without this patch as such.
> > 
> > I suspect you mean 4GB (here and the commit log), right ? I am checking
> > the commit logs, aiming at merging the patches.
> 
> A 32bit BAR register can support a 'size' of only up to 2GB. Though it
> can hold a memory address of up to 4GB.
> 
> This is also mentioned in the PCI Local Bus Specification.  "A 32-bit
> register can be implemented to support a single memory size that is a
> power of 2 from 16 bytes to 2 GB"

Very true - sorry for the noise.

Lorenz,o
