From: Suman Anna <s-anna@ti.com>
Subject: Re: dra7xx pci driver broken on dra7xx-evm
Date: Thu, 7 Jan 2016 15:26:18 -0600
Message-ID: <568ED7FA.4000508@ti.com>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <568DF4FE.5010704@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Richard Cochran <richardcochran@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Murphy,
 Dan" <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 01/06/2016 11:17 PM, Kishon Vijay Abraham I wrote:
> Hi,

+ Tero, Tony and linux-omap

> 
> On Thursday 07 January 2016 03:15 AM, Richard Cochran wrote:
>>
>> The dra7xx-evm box freezes hard at the very first PCI bus access, the
>> call to in dra7xx_pcie_readl() in dra7xx_pcie_probe().
>>
>> The out-of-tree 3.14.53 TI driver performs a reset via platform data,
>> calling omap_device_assert_hardreset() by hook and crook.

Yeah, this is the only feasible way and not break multi-arch atm until a
reset framework is in place. We have couple of drivers (omap_iommu and
wkup_m3_rproc) following this approach.

>>
>> Adding the reset into the mainline driver cures the freeze.


>>
>> Question: How on earth is this driver supposed to work?
> 
> It doesn't work out of the box in mainline. (Every time I post a PCI patch, I
> add the pdata-quirks mechanism to test it). The pdata-quirks mechanism used in
> TI tree is not an upstream-able solution. Something like this [1] was done for
> performing reset. Not sure the latest state of that. Dan? Suman?

Yeah, [1] is very old, and it doesn't deal with the hwmod integration
for pm_runtime API usage. Tero has posted another revamped series [2]
with hwmod integration, and it needs to be refreshed with few additional
patches and fixes. It will probably take couple of releases before it
hits mainline. So, I guess it is then a question of picking up the pdata
quirks solution for interim to get the driver functional until the reset
framework hits mainline, or mark the driver as broken.

regards
Suman

> 
> [1] -> https://patches.linaro.org/33797/

[2] http://marc.info/?l=linux-omap&m=144310496514782&w=2
