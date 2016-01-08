From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: dra7xx pci driver broken on dra7xx-evm
Date: Fri, 8 Jan 2016 11:37:09 +0530
Message-ID: <568F520D.9050807@ti.com>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com> <568ED7FA.4000508@ti.com>
 <20160107215946.GP12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160107215946.GP12777@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Tero Kristo <t-kristo@ti.com>, "Murphy, Dan" <dmurphy@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 08 January 2016 03:29 AM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [160107 13:26]:
>> On 01/06/2016 11:17 PM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>
>> + Tero, Tony and linux-omap
>>
>>>
>>> On Thursday 07 January 2016 03:15 AM, Richard Cochran wrote:
>>>>
>>>> The dra7xx-evm box freezes hard at the very first PCI bus access, the
>>>> call to in dra7xx_pcie_readl() in dra7xx_pcie_probe().
>>>>
>>>> The out-of-tree 3.14.53 TI driver performs a reset via platform data,
>>>> calling omap_device_assert_hardreset() by hook and crook.
>>
>> Yeah, this is the only feasible way and not break multi-arch atm until a
>> reset framework is in place. We have couple of drivers (omap_iommu and
>> wkup_m3_rproc) following this approach.
> 
> Sounds like doing reset with platform data is the way to go until the
> reset controller works.

All right. I'll post the patch to do reset using platform data.

Thanks
Kishon
