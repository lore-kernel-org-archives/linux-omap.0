From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 3/6] usb: otg: utils: change the phy lib to support
 multiple PHYs of same type
Date: Fri, 18 Jan 2013 10:58:03 +0530
Message-ID: <50F8DD63.8070404@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-4-git-send-email-kishon@ti.com> <50F821DD.1040609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50F821DD.1040609-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 17 January 2013 09:37 PM, Roger Quadros wrote:
> On 01/16/2013 05:00 PM, Kishon Vijay Abraham I wrote:
>> In order to add support for multipe PHY's of the same type, the API's
>> for adding PHY and getting PHY has been changed. Now the binding
>> information of the PHY and controller should be done in platform file
>> using usb_bind_phy API. And for getting a PHY, the device pointer of the
>> USB controller and an index should be passed. Based on the binding
>> information that is added in the platform file, get_phy will return the
>> approappropriate PHY.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/mach-shmobile/board-marzen.c |    2 +-
>>   drivers/power/ab8500_charger.c        |    2 +-
>>   drivers/power/isp1704_charger.c       |    2 +-
>>   drivers/power/pda_power.c             |    2 +-
>>   drivers/power/twl4030_charger.c       |    2 +-
>>   drivers/usb/chipidea/udc.c            |    2 +-
>>   drivers/usb/dwc3/core.c               |    4 +-
>>   drivers/usb/gadget/fsl_udc_core.c     |    2 +-
>>   drivers/usb/gadget/mv_udc_core.c      |    2 +-
>>   drivers/usb/gadget/omap_udc.c         |    2 +-
>>   drivers/usb/gadget/pxa25x_udc.c       |    2 +-
>>   drivers/usb/gadget/pxa27x_udc.c       |    2 +-
>>   drivers/usb/gadget/s3c-hsudc.c        |    2 +-
>>   drivers/usb/host/ehci-fsl.c           |    2 +-
>>   drivers/usb/host/ehci-msm.c           |    2 +-
>>   drivers/usb/host/ehci-mv.c            |    2 +-
>>   drivers/usb/host/ehci-tegra.c         |    2 +-
>>   drivers/usb/host/ohci-omap.c          |    2 +-
>>   drivers/usb/musb/am35x.c              |    2 +-
>>   drivers/usb/musb/blackfin.c           |    2 +-
>>   drivers/usb/musb/da8xx.c              |    2 +-
>>   drivers/usb/musb/davinci.c            |    2 +-
>>   drivers/usb/musb/musb_dsps.c          |    2 +-
>>   drivers/usb/musb/omap2430.c           |    2 +-
>>   drivers/usb/musb/tusb6010.c           |    2 +-
>>   drivers/usb/musb/ux500.c              |    2 +-
>>   drivers/usb/otg/ab8500-usb.c          |    3 +-
>>   drivers/usb/otg/fsl_otg.c             |    5 ++-
>>   drivers/usb/otg/gpio_vbus.c           |    3 +-
>>   drivers/usb/otg/isp1301_omap.c        |    3 +-
>>   drivers/usb/otg/msm_otg.c             |    3 +-
>>   drivers/usb/otg/mv_otg.c              |    3 +-
>>   drivers/usb/otg/nop-usb-xceiv.c       |    3 +-
>>   drivers/usb/otg/otg.c                 |   67 +++++++++++++++------------------
>>   drivers/usb/otg/twl4030-usb.c         |    3 +-
>>   drivers/usb/phy/mv_u3d_phy.c          |    3 +-
>>   drivers/usb/phy/omap-usb2.c           |   11 ++----
>>   drivers/usb/phy/rcar-phy.c            |    3 +-
>>   include/linux/usb/phy.h               |   12 +++---
>>   39 files changed, 87 insertions(+), 89 deletions(-)
>
> I think it better to leave the existing add/get APIs as they are add add
> new APIs that support multiple PHYs. You could probably mark the old
> ones as deprecated.
>
> That way you don't need to wait till all users are converted and tested.

Makes sense. Will do that :-)

Thanks
Kishon
