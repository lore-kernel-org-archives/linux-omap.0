From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] PCI: dwc: dra7xx: Create functional dependency
 between PCIe and PHY
Date: Tue, 10 Oct 2017 13:12:18 +0530
Message-ID: <ac5b3f42-19a1-3f8d-3bb6-37d63c3574de@ti.com>
References: <20171009090338.26033-1-kishon@ti.com>
 <20171009090338.26033-2-kishon@ti.com>
 <f258c2f0-11a2-60ac-3919-dcc0badfa870@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f258c2f0-11a2-60ac-3919-dcc0badfa870@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Roger,

On Tuesday 10 October 2017 12:49 PM, Roger Quadros wrote:
> On 09/10/17 12:03, Kishon Vijay Abraham I wrote:
>> PCI core access configuration space registers in resume_noirq callbacks.
>> In the case of dra7xx, PIPE3 PHY connected to PCIe controller has to be
>> enabled before accessing configuration space registers. Since
>> PIPE3 PHY is enabled by only configuring control module registers, no
>> aborts has been observed so far (though during noirq stage, interface
>> clock of PIPE3 PHY is not enabled).
>>
>> With new TRM updates, PIPE3 PHY has to be initialized (PIPE3 PHY
>> registers has to be accessed) as well which requires the interface
>> clock of PIPE3 PHY to be enabled. The interface clock of PIPE3 PHY is
>> derived from OCP2SCP and hence PCIe PHY is modeled as a child of
>> OCP2SCP. Since pm_runtime is not enabled during noirq stage,
>> pm_runtime_get_sync done in phy_init doesn't enable
>> OCP2SCP clocks resulting in abort when PIPE3 PHY registers are
>> accessed.
> 
> This could be the case not only with PCIe but even with USB and SATA?

right, if USB/SATA driver has no_irq callbacks then the same issue might occur.
But looks like none of them uses no_irq callbacks.
> Maybe today it doesn't complain because USB/SATA is being resumed (by chance) after PHY?

But once pm_runtime is enabled, USB/SATA can enable PHY which in turn will
enable OCP2SCP and PHY can be accessed without any issues.

Thanks
Kishon
