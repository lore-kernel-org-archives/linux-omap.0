From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Thu, 23 Jun 2016 07:42:05 +0000
Message-ID: <SG2PR06MB0919F0BD0D600FBFFB95FFBED82D0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2>
 <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2>
 <87h9cmoo4s.fsf@linux.intel.com> <20160621130512.GF5108@shlinux2>
 <87por9lnjd.fsf@linux.intel.com> <576A4321.6020209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <576A4321.6020209-l0cyMroinI0@public.gmane.org>
Content-Language: ja-JP
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>, "b-liu-l0cyMroinI0@public.gmane.org" <b-liu-l0cyMroinI0@public.gmane.org>, "joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org" <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger-san,

< snip >
> >>>> commit 11c011a5e777c83819078a18672543f04482b3ec
> >>>> Author: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>> Date:   Thu May 19 11:12:56 2016 +0100
> >>>>
> >>>>     usb: echi-hcd: Add ehci_setup check before echi_shutdown
> >>>>
> >>>>
> >>>>
> >>>> In some cases, the USB code (gadget/hcd->start/stop) needs to be called
> >>>> during the role swap. For example, if you have mux driver, you may
> >>>> need to call usb_remove_hcd when ID from 0 to 1. Without Roger's framework,
> >>>> how can we do that?
> >>>
> >>> You don't really need to remove the gadget. Just mask its interrupts and
> >>> ignore any calls to any gadget_driver ops, right? Likewise for
> >>> XHCI. Just clear RUN/STOP and no events will ever reach XHCI. But, from
> >>> the point of view of dwc3, it's simpler to unregister the platform
> >>> device we create for xhci-plat.c. I need no changes in XHCI to do that
> >>> and driver model will make sure to call xhci-plat's ->remove() which
> >>> will handle everything for me correctly.
> >>>
> >>
> >> I admit it can do in a IP driver, eg both host and peripheral for the
> >> single IP, eg chipidea, dwc3, etc. But how can we clear RUN/STOP bit
> >> or what else for HCD at mux driver?
> >
> > dwc3's OTG block has control of that, however, what I'll do is
> > platform_device_del() xhci-plat's device. Not one line changes inside
> > XHCI.
> >
> 
> Let's talk about how non dwc3 based platforms can get it done.
> 
> Yoshihiro-san, could you please share your platform requirements from dual-role
> perspective?

My platform requirements about dual-role are:
- Initial settings of all host, gadget and OTG IP registers are needed before enters [AB]-device recognition procedure.
- In the recognition procedures, a software needs:
 - to check ID pin related register in OTG
 - to set OTG IP registers to change the role
  - and then host or gadget can start.
- In the disconnect detection procedures, a software needs similar checkings/settings with the recognition.

Best regards,
Yoshihiro Shimoda

> cheers,
> -roger

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
