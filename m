From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v2 07/11] usb: otg: nop: add dt support
Date: Wed, 18 Jul 2012 06:53:58 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAD9BE9@DBDE01.ent.ti.com>
References: <1342516407-16515-1-git-send-email-ajay.gupta@ti.com>
 <1342516407-16515-8-git-send-email-ajay.gupta@ti.com>
 <50055D54.9040005@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58337 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab2GRGyI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 02:54:08 -0400
In-Reply-To: <50055D54.9040005@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>

Hi,
> 
> On 17-07-2012 13:13, Ajay Kumar Gupta wrote:
> 
> > Added device tree support for nop transceiver driver and updated the
> > Documentation with device tree binding information for am33xx
> platform.
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> >   .../devicetree/bindings/usb/am33xx-usb.txt         |    3 +++
> >   drivers/usb/otg/nop-usb-xceiv.c                    |   12
> ++++++++++++
> >   2 files changed, 15 insertions(+), 0 deletions(-)
> 
> > diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> > index ca8fa56..a314720 100644
> > --- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> > +++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> > @@ -12,3 +12,6 @@ AM33XX MUSB GLUE
> >      represents PERIPHERAL.
> >    - power : Should be "250". This signifies the controller can
> supply upto
> >      500mA when operating in host mode.
> > +
> > +NOP USB PHY
> > + - compatible : Should be "ti,nop-xceiv-usb"
> 
>     Why are you declaring it as TI specific. There's nothing company
> specific in the NOP transceiver.

Thanks for review. I will change this to "nop-xceiv-usb".

Ajay
> 
> WBR, Sergei
