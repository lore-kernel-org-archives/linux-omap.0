From: Rami Rosen <roszenrami@gmail.com>
Subject: Re: [PATCH v3 08/23] Documentation: PCI: Add binding documentation
 for pci-test endpoint function
Date: Thu, 9 Mar 2017 23:59:18 +0200
Message-ID: <CAKoUArkTXbMvfTmNjA_VGWodbP5JxVNBP1DNUTYND2LvUfKsJQ@mail.gmail.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com> <1489046254-19919-9-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489046254-19919-9-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, hch@infradead.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,
Minor comment: typo, should be: don't care:

> +revid           : dont't care
> +progif_code     : don't care
> +subclass_code   : don't care
> +baseclass_code  : should be 0xff
> +cache_line_size         : don't care
> +subsys_vendor_id : don't care
> +subsys_id       : don't care
> +interrupt_pin   : Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
> +msi_interrupts  : Should be 1 to 32 depending on the number of msi

Regards,
Rami Rosen
