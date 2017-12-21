From: Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v6 00/18] dwc MSI fixes, ARTPEC-6 EP mode support,
 ARTPEC-7 SoC support
Date: Thu, 21 Dec 2017 09:23:44 +0000
Message-ID: <3aa8d7db-375b-051d-6a9e-16a1d19a7e67@synopsys.com>
References: <20171219232940.659-1-niklas.cassel@axis.com>
 <20171220173416.GD1709@red-moon>
 <32f6e02c-4230-9222-0ee1-54a045e78bd5@synopsys.com>
 <20171220232251.GA27011@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171220232251.GA27011@axis.com>
Content-Language: pt-PT
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@axis.com>, Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jingoo Han <jingoohan1@gmail.com>, linux-arm-kernel@axis.com, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, gustavo.pimentel@synopsys.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Niklas,

Às 11:22 PM de 12/20/2017, Niklas Cassel escreveu:
> On Wed, Dec 20, 2017 at 07:47:41PM +0000, Joao Pinto wrote:
>>
>> Hello to all,
>>
>> Às 5:34 PM de 12/20/2017, Lorenzo Pieralisi escreveu:
>>> On Wed, Dec 20, 2017 at 12:29:21AM +0100, Niklas Cassel wrote:
>>>> This is a series that adds:
>>>> - PCI endpoint mode support in the ARTPEC-6 driver.
>>>> - ARTPEC-7 SoC support in the ARTPEC-6 driver (the SoCs are very similar).
>>>> - Small fixes for MSI in designware-ep and designware-host,
>>>>   needed to get endpoint mode support working for ARTPEC-6.
>>>> - Cleanups in pci-dra7xx to better prepare for endpoint mode in other
>>>>   DWC based PCIe drivers.
>>>
>>> Joao, Jingoo,
>>>
>>> Gustavo tested the series and Kishon ACK'ed the relevant patches,
>>> I need your ACKs on designware patches to queue this series for
>>> v4.16.
>>>
>>> I am away from tomorrow (noon) till beginning of January which means
>>> that either I queue this series tomorrow or at -rc6, please do
>>> chime in if you can.
>>
>> Sorry, I have been a bit tied up! Already checked each patch related to DWC.
>> Could anyone from artpec finish the revision, since there are some patches
>> related to that SoC?
> 
> Thanks for looking at the patches.
> 
> Thanks to everyone that has helped in any way.
> 
> Since I am the maintainer for pcie-artpec6.c
> (at least according to MAINTAINERS ;)),
> I'm supposing that my sign-off will suffice.

You're right :), I didn't remember you were the maintainer.
Have a Merry Christmas.

Thanks,
Joao

> 
> Regards,
> Niklas
> 
