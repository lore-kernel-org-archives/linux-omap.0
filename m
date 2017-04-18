From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [Query] Enabling parent device clock from resume_noirq
Date: Tue, 18 Apr 2017 15:05:48 -0500
Message-ID: <4c6e91e4-35fa-2fde-7915-fb922ec22567@ti.com>
References: <62cd5ee0-3f0c-5e65-5f64-0c91a2a6f1e6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <62cd5ee0-3f0c-5e65-5f64-0c91a2a6f1e6@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, khilman@kernel.org, rnayak@codeaurora.org, Paul Walmsley <paul@pwsan.com>, Bjorn Helgaas <helgaas@kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Kristo, Tero" <t-kristo@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-omap@vger.kernel.org

+ linux-pm

On 04/18/2017 01:07 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> resume_noirq callbacks are used in PCIe core to restore PCI state (this
> accesses PCI module). So the clocks of PCI module has to be enabled before
> resume_noirq.
> 
> The clocks for the PCI module in DRA7xx is provided by PIPE3 PHY device which
> in turn gets it's clock from OCP2SCP device. During resume_noirq callbacks,
> pm_runtime is disabled, so pm_runtime_get_sync is ineffective. However
> pm_runtime can be enabled using pm_runtime_force_resume. Now the problem is
> adding pm_runtime_force_resume() in resume_noirq callback of pci-dra7xx driver
> will enable only the pm_runtime of PCI device but not PIPE3 PHY or OCP2SCP.
> Adding pm_runtime_force_resume() in resume_noirq callback of PIPE3 PHY driver
> or OCP2SCP driver will not help if the resume_noirq callbacks in PIP3PHY driver
> and OCP2SCP driver are invoked after the resume_noirq of pci-dra7xx driver.
> 
> How to enable the pm_runtime of parent devices in resume_noirq callback? Does
> existing pm_runtime framework has support for that?
> 

Most probably you've hit the issue described in [1].
In general, if pci-dra7xx is consumer of  PIPE3 PHY device and 
PIPE3 PHY device is child of OCP2SCP then suspend/resume order should be
- pci-dra7xx
- PIPE3 PHY
- OCP2SCP
 and resume
- OCP2SCP
- PIPE3 PHY
- pci-dra7xx
and in this case  pm_runtime_force_x() might work.

Hence, approach [1] was not accepted (personally I still like it) and
"Functional dependencies tracking support" was introduced instead by commit 9ed9895 [2]
you can try it.

But, as per code, I'm not sure that Functional dependencies properly tracked in 
pm_runtime_force_x() functions.

PS: you can try to reorder device's nodes in DT and place PCI node after "ocp2scp" :P

[1] "driver core: Ensure proper suspend/resume ordering"
 https://patchwork.kernel.org/patch/7153201/
[2] https://patchwork.kernel.org/patch/9404547/
-- 
regards,
-grygorii
