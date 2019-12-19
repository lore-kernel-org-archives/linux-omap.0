From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
Date: Thu, 19 Dec 2019 21:16:28 +0100
Message-ID: <CAK8P3a1pGiUco9DcBSOWbck4_qLTUcO5awPe1+sM9Jun17xsOw@mail.gmail.com>
References: <20191209092147.22901-1-kishon@ti.com> <20191209092147.22901-6-kishon@ti.com>
 <20191216144932.GY24359@e119886-lin.cambridge.arm.com> <d1ee4579-a3da-6a73-3516-a6d264f80995@ti.com>
 <CAK8P3a06XLSa-FHNGsN=b10JrddjbOKAvfU=iXdMa+0L43m5fA@mail.gmail.com> <9b40e71a-c18c-a958-84fe-c5a126fe8272@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9b40e71a-c18c-a958-84fe-c5a126fe8272@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Andrew Murray <andrew.murray@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-pci <linux-pci@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 19, 2019 at 2:17 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On 19/12/19 5:33 pm, Arnd Bergmann wrote:
> > On Thu, Dec 19, 2019 at 12:54 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Hi Andrew,
> >>
> >> On 16/12/19 8:19 pm, Andrew Murray wrote:
> >>> On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
> >>>> Certain platforms like TI's J721E allow only 32-bit register accesses.
> >>>
> >>> When I first read this I thought you meant only 32-bit accesses are allowed
> >>> and not other sizes (such as 64-bit). However the limitation you address
> >>> here is that the J721E allows only 32-bit *aligned* register accesses.
> >>
> >> It's both, it allows only 32-bit aligned accesses and the size should be
> >> only 32 bits. That's why I always use "readl" in the APIs below.
> >
> > In that case, can't you use the pci_generic_config_read32/write32
> > functions with a cadence specific .map_bus() function?
>
> pci_generic_config_read32() is for reading configuration space registers
> only. The accessors I added here are for the controller IP configuration.
>
> For the configuration space access I use
> pci_generic_config_read32/write32()([PATCH 11/13] PCI: j721e: Add TI
> J721E PCIe driver).

Got it, thanks for the clarification.

       Arnd
