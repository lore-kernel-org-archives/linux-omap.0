From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH 23/30] of/platform: Export of_platform_device_create_pdata()
Date: Mon, 10 Jun 2019 11:43:44 -0600
Message-ID: <CAL_JsqJ5gsctd7L3VOhTO1JdUqmMmSJRpos1XQyfxzmGO7wauw@mail.gmail.com>
References: <20190604131516.13596-1-kishon@ti.com> <20190604131516.13596-24-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-24-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 4, 2019 at 7:19 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Export of_platform_device_create_pdata() to be used by drivers to
> create child devices with the given platform data. This can be used
> by platform specific driver to send platform data core driver. For e.g.,
> this will be used by TI's J721E SoC specific PCIe driver to send
> ->start_link() ops and ->is_link_up() ops to Cadence core PCIe driver.

NAK

of_platform_device_create_pdata() is purely for legacy handling of
auxdata which is something I hope to get rid of someday. Or to put it
another way, auxdata use is a sign of platforms not fully converted to
DT.

Rob
