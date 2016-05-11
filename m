From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 10/14] usb: otg: add hcd companion support
Date: Wed, 11 May 2016 08:54:26 -0500
Message-ID: <20160511135426.GA25762@rob-hp-laptop>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-11-git-send-email-rogerq@ti.com>
 <20160504131700.GA20184@rob-hp-laptop>
 <5729FD66.4020704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5729FD66.4020704@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 04, 2016 at 04:47:18PM +0300, Roger Quadros wrote:
> On 04/05/16 16:17, Rob Herring wrote:
> > On Mon, May 02, 2016 at 03:18:53PM +0300, Roger Quadros wrote:
> >> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >>
> >> Since some host controller (e.g. EHCI) needs a companion host controller
> >> (e.g. OHCI), this patch adds such a configuration to use it in the OTG
> >> core.
> >>
> >> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  Documentation/devicetree/bindings/usb/generic.txt |  3 +++
> >>  drivers/usb/common/usb-otg.c                      | 32 ++++++++++++++++-------
> >>  include/linux/usb/otg.h                           |  7 ++++-
> >>  3 files changed, 32 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> >> index f6866c1..1db1c33 100644
> >> --- a/Documentation/devicetree/bindings/usb/generic.txt
> >> +++ b/Documentation/devicetree/bindings/usb/generic.txt
> >> @@ -27,6 +27,9 @@ Optional properties:
> >>   - otg-controller: phandle to otg controller. Host or gadget controllers can
> >>  			contain this property to link it to a particular OTG
> >>  			controller.
> >> + - hcd-needs-companion: must be present if otg controller is dealing with
> >> +			EHCI host controller that needs a companion OHCI host
> >> +			controller.
> > 
> > Don't you need to have a link to the companion controller node?
> 
> primary and companion controllers are totally independent of each other
> e.g. EHCI and OHCI. They are enabled by separate Kconfig options and
> the system can operate with either or both of them enabled.
> 
> At the OTG layer we don't have information as to whether we should be waiting
> for both of them to register or not and hence need this "hcd-needs-companion" flag.

What I mean is if you have 2 EHCI controllers with 2 companion 
controllers, don't you need to know which companion goes with which EHCI 
controller? Just like you do for the otg-controller property.

Rob
