From: Niklas Cassel <niklas.cassel@axis.com>
Subject: Re: [PATCH 09/10] PCI: dwc: make cpu_addr_fixup take struct dw_pcie
 as argument
Date: Mon, 16 Oct 2017 14:40:24 +0200
Message-ID: <3970f7e1-c5bf-3c0c-98fb-fc0bf5b14212@axis.com>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-10-niklas.cassel@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171013160914.3220-10-niklas.cassel@axis.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jesper Nilsson <jespern@axis.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

On 10/13/2017 06:09 PM, Niklas Cassel wrote:
(snip)

Hello Kishon

I just wanted to say that the function
artpec6_pcie_calc_cpu_fixup_mask should work on dra7xx
as well. (I had dra7xx in mind when I wrote it.)
However, I did not want to change pci-dra7xx.c to
also use this function, since your current code is
quite simple.
But if you think that it's a good idea, we could
rename and move artpec6_pcie_calc_cpu_fixup_mask
to pcie-designware.c, and migrate pci-dra7xx
to utilize this function as well, as it is strictly
more correct to use values from device tree, rather
than having a hard coded define in the SoC driver.


Regards,
Niklas
