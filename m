From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/3] PCI: host: pcie-designware: add support for suspend and resume
Date: Fri, 10 Jul 2015 17:41:11 +0200
Message-ID: <201507101741.11873.marex@denx.de>
References: <1435921425-15121-1-git-send-email-kishon@ti.com> <559FDB97.1090803@ti.com> <CAHM4w1mTCHNTAYG4c-9x9kMPjGevyngT4ixVinpuDPCwKtT0FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAHM4w1mTCHNTAYG4c-9x9kMPjGevyngT4ixVinpuDPCwKtT0FA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tim Harvey <tharvey@gateworks.com>
List-Id: linux-omap@vger.kernel.org

On Friday, July 10, 2015 at 05:30:46 PM, Pratyush Anand wrote:
> Hi Kishon,

Hi,

> On Fri, Jul 10, 2015 at 8:19 PM, Kishon Vijay Abraham I <kishon@ti.com>
> wrote:
> 
> [...]
> 
> >> Have you tested with a card having IO space memory as well.
> > 
> > I don't have any cards with IO space memory. Do you have any suggestion
> > for cards with IO space memory?
> 
> Sorry, I never used it either :(
> IIRC, then Tim and Marek (in cc) had reported long back with some
> issues of IO transaction
> with SKY2 based card. They may let you know about exact card ID.

That was Tim, I didn't ever try with SKY2 , sorry.

Best regards,
Marek Vasut
