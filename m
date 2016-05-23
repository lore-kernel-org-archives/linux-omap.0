From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 09/14] usb: of: add an API to get OTG device from USB
 controller node
Date: Mon, 23 May 2016 16:06:25 -0500
Message-ID: <20160523210625.GA28986@rob-hp-laptop>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-10-git-send-email-rogerq@ti.com>
 <573ED917.6090803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <573ED917.6090803@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 20, 2016 at 12:29:59PM +0300, Roger Quadros wrote:
> The OTG controller and the USB controller can be linked via the
> 'otg-controller' property in the USB controller's device node.
> 
> of_usb_get_otg() can be used to get the OTG controller device
> from the USB controller's device node.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Peter Chen <peter.chen@nxp.com>
> ---
> v9:
> Clearly indicate which properties are for OTG controller and which ones
> are for host/device controllers
> 
>  Documentation/devicetree/bindings/usb/generic.txt |  7 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/usb/common/common.c                       | 27 +++++++++++++++++++++++
>  include/linux/usb/of.h                            |  9 ++++++++
>  3 files changed, 43 insertions(+)
