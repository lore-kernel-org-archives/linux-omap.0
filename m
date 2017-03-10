From: Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [RESEND PATCH v3 4/7] PCI: dwc: all: Modify dbi accessors to take
 dbi_base as argument
Date: Fri, 10 Mar 2017 12:30:07 +0000
Message-ID: <c147fa5e-2434-d2e5-c318-8ec984e0c673@synopsys.com>
References: <1489041545-15730-1-git-send-email-kishon@ti.com>
 <1489041545-15730-5-git-send-email-kishon@ti.com>
 <4e13580d-2625-5eed-bcbc-2ffd7493b073@axis.com>
 <595fab62-fb7a-888a-f898-7b59030585f1@axis.com> <58C28FCC.4070100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58C28FCC.4070100@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nsekhar@ti.com, Jingoo Han <jingoohan1@gmail.com>, Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Murali Karicheri <m-karicheri2@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jesper Nilsson <jespern@axis.com>, Zhou Wang <wangzhou1@hisilicon.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>
List-Id: linux-omap@vger.kernel.org

Às 11:36 AM de 3/10/2017, Kishon Vijay Abraham I escreveu:
> Hi,
> 
> On Thursday 09 March 2017 08:35 PM, Niklas Cassel wrote:
>>
>>
>> On 03/09/2017 03:48 PM, Niklas Cassel wrote:
>>> On 03/09/2017 07:39 AM, Kishon Vijay Abraham I wrote:
>>>> dwc has 2 dbi address space labeled dbics and dbics2. The existing
>>>> helper to access dbi address space can access only dbics. However
>>>> dbics2 has to be accessed for programming the BAR registers in the
>>>> case of EP mode. This is in preparation for adding EP mode support
>>>> to dwc driver.
>>> Hello Kishon
>>>
>>> I don't really like the idea of adding an extra argument to every existing read/write.
>>> Will not a read/write using dbi2 be quite uncommon compared to a read/write
>>> using dbi?
>>>
>>> How about something like this:
>>>
>>> void __dw_pcie_writel(struct dw_pcie *pci, void __iomem *base, u32 reg, u32 val)
>>> {
>>>     if (pci->ops->writel_dbi)
>>>         pci->ops->writel_dbi(pci, base, reg, val);
>>>     else
>>>         writel(val, base + reg);
>>> }
>>>
>>> #define dw_pcie_writel_dbi(pci, reg, val) __dw_pcie_writel(pci, pci->dbi_base, reg, val)
>>> #define dw_pcie_writel_dbi2(pci, reg, val) __dw_pcie_writel(pci, pci->dbi_base2, reg, val)
>>
>> Perhaps make dw_pcie_writel_dbi2 a function rather than a define,
>> so we can return an error if pci->dbi_base2 == NULL.
> 
> Should we return an error? We don't return error for dbi_base either. I think
> it should be sufficient to return errors while populating dbi_base or
> dbi_base2. Otherwise it's a bug and should result in abort. Joao?

I agree with Kishon.

Thanks,
Joao

> 
> Thanks
> Kishon
> 
