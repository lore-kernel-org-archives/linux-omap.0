From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 10/14] usb: otg: add hcd companion support
Date: Mon, 23 May 2016 16:07:25 -0500
Message-ID: <20160523210725.GA29722@rob-hp-laptop>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-11-git-send-email-rogerq@ti.com>
 <573ED9AB.6010508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <573ED9AB.6010508@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 20, 2016 at 12:32:27PM +0300, Roger Quadros wrote:
> Since some host controller (e.g. EHCI) needs a companion host controller
> (e.g. OHCI), this patch adds such a configuration to use it in the OTG
> core.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Peter Chen <peter.chen@nxp.com>
> ---
> v9:
> - add DT property documentation under OTG controllers.
> 
>  Documentation/devicetree/bindings/usb/generic.txt |  3 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/usb/common/usb-otg.c                      | 32 ++++++++++++++++-------
>  include/linux/usb/otg.h                           |  7 ++++-
>  3 files changed, 32 insertions(+), 10 deletions(-)
