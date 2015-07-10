From: Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH 2/3] PCI: host: pcie-designware: add support for suspend
 and resume
Date: Fri, 10 Jul 2015 21:00:46 +0530
Message-ID: <CAHM4w1mTCHNTAYG4c-9x9kMPjGevyngT4ixVinpuDPCwKtT0FA@mail.gmail.com>
References: <1435921425-15121-1-git-send-email-kishon@ti.com>
	<1435921425-15121-3-git-send-email-kishon@ti.com>
	<CAHM4w1m5gfFbKF6Up8YNQA8rK+avXuz8HZgtbj6pQAndSa_zBQ@mail.gmail.com>
	<559FDB97.1090803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <559FDB97.1090803@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tim Harvey <tharvey@gateworks.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On Fri, Jul 10, 2015 at 8:19 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:

[...]

>> Have you tested with a card having IO space memory as well.
>
> I don't have any cards with IO space memory. Do you have any suggestion for
> cards with IO space memory?

Sorry, I never used it either :(
IIRC, then Tim and Marek (in cc) had reported long back with some
issues of IO transaction
with SKY2 based card. They may let you know about exact card ID.

~Pratyush
