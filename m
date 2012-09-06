From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 1/7] drivers: usb: phy: add a new driver for omap usb2
 phy
Date: Thu, 6 Sep 2012 17:45:33 +0530
Message-ID: <CAAe_U6KBNZpT03xATmPTNTgxm5hj+wJdsShdnm08EmF4Q=hTCw@mail.gmail.com>
References: <1344258480-4304-1-git-send-email-kishon@ti.com>
 <1344258480-4304-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1344258480-4304-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Aug 6, 2012 at 6:37 PM, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> All phy related programming like enabling/disabling the clocks, powering
> on/off the phy is taken care of by this driver. It is also used for OTG
> related functionality like srp.
>
> This also includes device tree support for usb2 phy driver and
> the documentation with device tree binding information is updated.
>
> Currently writing to control module register is taken care in this
> driver which will be removed once the control module driver is in place.
>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/bus/omap-ocp2scp.txt       |    3 +
>  Documentation/devicetree/bindings/usb/omap-usb.txt |   17 ++
>  drivers/usb/phy/Kconfig                            |   10 +
>  drivers/usb/phy/Makefile                           |    1 +
>  drivers/usb/phy/omap-usb2.c                        |  271 ++++++++++++++++++++
>  include/linux/usb/omap_usb.h                       |   46 ++++
>  include/linux/usb/phy_companion.h                  |   34 +++
>  7 files changed, 382 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/omap-usb.txt
>  create mode 100644 drivers/usb/phy/omap-usb2.c
>  create mode 100644 include/linux/usb/omap_usb.h
>  create mode 100644 include/linux/usb/phy_companion.h
>
> diff --git a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> index d2fe064..bb0c7f4 100644
> --- a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> +++ b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> @@ -8,3 +8,6 @@ properties:
>
>  Sub-nodes:
>  All the devices connected to ocp2scp are described using sub-node to ocp2scp
> +- usb2phy :
> +   The binding details of usb2phy can be found in:
> +   Documentation/devicetree/bindings/usb/omap-usb.txt

The above two lines should be added in omap-ocp2scp.txt (this file was
added as part of omap: add ocp2scp as a bus driver and is in
linux-next). However this file is still not in Felipe's xceiv branch.
So I'm not sure how I can get this patch merged in Felipe's tree
without conflict.

Thanks
Kishon
