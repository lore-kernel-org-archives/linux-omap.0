From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 23/30] of/platform: Export
 of_platform_device_create_pdata()
Date: Tue, 11 Jun 2019 10:08:24 +0530
Message-ID: <a80c7c33-7091-70d9-cd86-a19fe43d3bc6@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
 <20190604131516.13596-24-kishon@ti.com>
 <CAL_JsqJ5gsctd7L3VOhTO1JdUqmMmSJRpos1XQyfxzmGO7wauw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAL_JsqJ5gsctd7L3VOhTO1JdUqmMmSJRpos1XQyfxzmGO7wauw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tom Joseph <tjoseph-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Gustavo Pimentel <gustavo.pimentel-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 10/06/19 11:13 PM, Rob Herring wrote:
> On Tue, Jun 4, 2019 at 7:19 AM Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
>>
>> Export of_platform_device_create_pdata() to be used by drivers to
>> create child devices with the given platform data. This can be used
>> by platform specific driver to send platform data core driver. For e.g.,
>> this will be used by TI's J721E SoC specific PCIe driver to send
>> ->start_link() ops and ->is_link_up() ops to Cadence core PCIe driver.
> 
> NAK
> 
> of_platform_device_create_pdata() is purely for legacy handling of
> auxdata which is something I hope to get rid of someday. Or to put it
> another way, auxdata use is a sign of platforms not fully converted to
> DT.

All right. Thanks for letting me know your thoughts.

Lorenzo,

We've modeled Cadence PCIe core as a separate driver and for some of the
functionalities (for example starting LTSSM or checking link status) it has to
invoke the wrapper driver functions (The registers for these are present in
wrapper and not in Cadence Core). In the case of Designware, we modeled DWC
core as a library which provided APIs to be used by wrapper driver. Now that
Rob is not inclined for passing platform data from one driver to another (in
this case TI specific J721E driver to Cadence PCIe driver), should we model
Cadence core also as a library? If you agree, I can prepare patches for making
Cadence PCIe core as a library. Please let me know your thoughts.

Thanks
Kishon
