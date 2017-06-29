From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] multi_v7_defconfig: Enable OMAP MTD and DM816 AHCI
Date: Thu, 29 Jun 2017 17:22:52 +0200
Message-ID: <CAK8P3a1qN79DhoQ-SCNaF8i+60N0RDMOGpfWQ+gRLBdjKcXoPg@mail.gmail.com>
References: <1498045359-27376-1-git-send-email-trini@konsulko.com> <20170626073333.GR3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170626073333.GR3730@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tom Rini <trini@konsulko.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>, Mihail Grigorov <michael.grigorov@konsulko.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 26, 2017 at 9:33 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tom Rini <trini@konsulko.com> [170621 04:42]:
>> A wide variety of TI platforms support NAND via the
>> CONFIG_MTD_NAND_OMAP2 driver (and related BCH options), so enable this.
>> In addition, multi_v7_defconfig supports the dm8168-evm and that
>> supports root being on a SATA drive, so build the DM816 AHCI driver into
>> the resulting kernel as well.
>
> Best that Arnd picks up this one directly:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Pulled into next/defconfig, thanks!

        Arnd
