From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 23/30] of/platform: Export
 of_platform_device_create_pdata()
Date: Fri, 19 Jul 2019 16:25:37 +0530
Message-ID: <f9034a1d-1906-54e8-62f0-cdacf95c42ab@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
 <20190604131516.13596-24-kishon@ti.com>
 <CAL_JsqJ5gsctd7L3VOhTO1JdUqmMmSJRpos1XQyfxzmGO7wauw@mail.gmail.com>
 <a80c7c33-7091-70d9-cd86-a19fe43d3bc6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a80c7c33-7091-70d9-cd86-a19fe43d3bc6@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Lorenzo,

On 11/06/19 10:08 AM, Kishon Vijay Abraham I wrote:
> Hi Rob,
> 
> On 10/06/19 11:13 PM, Rob Herring wrote:
>> On Tue, Jun 4, 2019 at 7:19 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>
>>> Export of_platform_device_create_pdata() to be used by drivers to
>>> create child devices with the given platform data. This can be used
>>> by platform specific driver to send platform data core driver. For e.g.,
>>> this will be used by TI's J721E SoC specific PCIe driver to send
>>> ->start_link() ops and ->is_link_up() ops to Cadence core PCIe driver.
>>
>> NAK
>>
>> of_platform_device_create_pdata() is purely for legacy handling of
>> auxdata which is something I hope to get rid of someday. Or to put it
>> another way, auxdata use is a sign of platforms not fully converted to
>> DT.
> 
> All right. Thanks for letting me know your thoughts.
> 
> Lorenzo,
> 
> We've modeled Cadence PCIe core as a separate driver and for some of the
> functionalities (for example starting LTSSM or checking link status) it has to
> invoke the wrapper driver functions (The registers for these are present in
> wrapper and not in Cadence Core). In the case of Designware, we modeled DWC
> core as a library which provided APIs to be used by wrapper driver. Now that
> Rob is not inclined for passing platform data from one driver to another (in
> this case TI specific J721E driver to Cadence PCIe driver), should we model
> Cadence core also as a library? If you agree, I can prepare patches for making
> Cadence PCIe core as a library. Please let me know your thoughts.

Can you share your thoughts on this?

Thanks
Kishon
