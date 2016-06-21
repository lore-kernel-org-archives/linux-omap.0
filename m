From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 02:30:22 +0000
Message-ID: <SG2PR06MB0919045392F2545FF85033CED82B0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com> <5767C1B9.2060805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5767C1B9.2060805-l0cyMroinI0@public.gmane.org>
Content-Language: ja-JP
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>, "b-liu-l0cyMroinI0@public.gmane.org" <b-liu-l0cyMroinI0@public.gmane.org>, "joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org" <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

> From: Roger Quadros
> Sent: Monday, June 20, 2016 7:13 PM
> 
> Hi,
> 
> On 20/06/16 10:45, Felipe Balbi wrote:
< snip >
> >> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> >> index f4fc0aa..1d74fb8 100644
> >> --- a/include/linux/usb/gadget.h
> >> +++ b/include/linux/usb/gadget.h
> >> @@ -328,6 +328,7 @@ struct usb_gadget_ops {
> >>   * @in_epnum: last used in ep number
> >>   * @mA: last set mA value
> >>   * @otg_caps: OTG capabilities of this gadget.
> >> + * @otg_dev: OTG controller device, if needs to be used with OTG core.
> >
> > do you really know of any platform which has a separate OTG controller?
> >
> 
> Andrew had pointed out in [1] that Tegra210 has separate blocks for OTG, host
> and gadget.
> 
> [1] http://article.gmane.org/gmane.linux.ports.tegra/22969
> 
> Yoshihiro,
> 
> How is the dual-role architecture on your Renesas platform?

About the dual-role architecture, Renesas platform (R-Car H3) has a USB 2.0 host controller (EHCI/OHCI)
with OTG function and a separate USB 2.0 peripheral controller (HS-USB).
The OTG function is related to some PHY control registers, so I intend to add the OTG/Dual-role core
support into the phy driver (drivers/phy/phy-rcar-gen3-usb2.c).

Best regards,
Yoshihiro Shimoda

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
