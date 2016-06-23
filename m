From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Thu, 23 Jun 2016 07:41:18 +0000
Message-ID: <SG2PR06MB09196A50729B6E8AC3B75159D82D0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <5767C1B9.2060805@ti.com> <878ty0qd7q.fsf@linux.intel.com>
 <20160621063936.GB5108@shlinux2> <87d1nbovp7.fsf@linux.intel.com>
 <20160621080209.GC5108@shlinux2> <87mvmfneeq.fsf@linux.intel.com>
 <20160621091437.GE5108@shlinux2> <87fus6n2iz.fsf@linux.intel.com>
 <20160621131205.GG5108@shlinux2> <874m8mmwdo.fsf@linux.intel.com>
 <20160622033356.GB21361@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160622033356.GB21361@shlinux2>
Content-Language: ja-JP
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>, "b-liu-l0cyMroinI0@public.gmane.org" <b-liu-l0cyMroinI0@public.gmane.org>, "joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org" <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TbrhsbdSgBK9A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

> From: Peter Chen
> Sent: Wednesday, June 22, 2016 12:34 PM
> 
> On Tue, Jun 21, 2016 at 05:47:47PM +0300, Felipe Balbi wrote:
> >
> > Hi,
> >
> > Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> > >> >> >> >> >>> + * @otg_dev: OTG controller device, if needs to be used with OTG core.
> > >> >> >> >> >>
> > >> >> >> >> >> do you really know of any platform which has a separate OTG controller?
> > >> >> >> >> >>
> > >> >> >> >> >
> > >> >> >> >> > Andrew had pointed out in [1] that Tegra210 has separate blocks for OTG, host
> > >> >> >> >> > and gadget.
> > >> >> >> >> >
> > >> >> >> >> > [1] http://article.gmane.org/gmane.linux.ports.tegra/22969
> > >> >> >> >>
> > >> >> >> >> that's not an OTG controller, it's just a mux. No different than Intel's
> > >> >> >> >> mux for swapping between XHCI and peripheral-only DWC3.
> > >> >> >> >>
> > >> >> >> >> frankly, I would NEVER talk about OTG when type-C comes into play. They
> > >> >> >> >> are two competing standards and, apparently, type-C is winning when it
> > >> >> >> >> comes to role-swapping.
> > >> >> >> >>
> > >> >> >> >
> > >> >> >> > In fact, OTG is mis-used by people. Currently, if the port is dual-role,
> > >> >> >> > It will be considered as an OTG port.
> > >> >> >>
> > >> >> >> That's because "dual-role" is a non-standard OTG. Seen as people really
> > >> >> >> didn't care about OTG, we (linux-usb folks) ended up naturally referring
> > >> >> >> to "non-standard OTG" as "dual-role". Just to avoid confusion.
> > >> >> >
> > >> >> > So, unless we use OTG FSM defined in OTG spec, we should not mention
> > >> >> > "OTG" in Linux, right?
> > >> >>
> > >> >> to avoid confusion with the terminology, yes. With that settled, let's
> > >> >> figure out how you can deliver what your marketting guys are asking of
> > >> >> you.
> > >> >>
> > >> >
> > >> > Since nxp SoC claims they are OTG compliance, we need to pass usb.org
> > >> > test. The internal bsp has passed PET test, and formal compliance test
> > >> > is on the way (should pass too).
> > >> >
> > >> > The dual-role and OTG compliance use the same zImage, but different
> > >> > dtb.
> > >>
> > >> okay, that's good to know. Now, the question really is: considering we
> > >> only have one user for this generic OTG FSM layer, do we really need to
> > >> make it generic at all? I mean, just look at how invasive a change that
> > >> is.
> > >
> > > If the chipidea is the only user for this roger's framework, I don't
> > > think it is necessary. In fact, Roger introduces this framework, and
> > > the first user is dwc3, we think it can be used for others. Let's
> >
> > Right, we need to look at the history of dwc3 to figure out why the
> > conclusion that dwc3 needs this was made.
> >
> > Roger started working on this framework when Power on Reset section of
> > databook had some details which weren't always clear and, for safety, we
> > always had reset asserted for a really long time. It was so long (about
> > 400 ms) that resetting dwc3 for each role swap was just too much.
> >
> > Coupled with that, the OTG chapter wasn't very clear either on
> > expections from Host and Peripheral side initialization in OTG/DRD
> > systems.
> >
> > More recent version of dwc3 databook have a much better description of
> > how and which reset bits _must_ be asserted and which shouldn't be
> > touched unless it's for debugging purposes. When I implemented that, our
> > ->probe() went from 400ms down to about 50us.
> >
> > Coupled with that, the OTG chapter also became a lot clearer to the
> > point that it states you just don't initialize anything other than the
> > OTG block, and just wait for OTG interrupt to do whatever it is you need
> > to do.
> >
> > This meant that we could actually afford to do full reinitialization of
> > dwc3 on role swap (it's now only 50us anyway) and we knew how to swap
> > roles properly.
> >
> > (The reason for needing soft-reset during role swap is kinda long. But
> > in summary dwc3 shadows register writes to both host and peripheral
> > sides)
> >
> > > just discuss if it is necessary for dual-role switch.
> >
> > fair. However, if we have a single user we don't have a Generic
> > layer. There's not enough variance to come up with truly generic
> > architecture for this.
> >
> > --
> 
> I have put some points in my last reply [1], I summery it here to
> see if a generic framework is deserved or not?
> 
> 1. If there are some parts we can use during the role switch
> - The common start/stop host and peripheral operation
> eg, when switch from host to peripheral, all drivers can use
> usb_remove_hcd to finish it.
> - A common workqueue to handle vbus and id event
> - sysfs for role switch
> 
> 2. Does a mux driver can do it well? Yoshihiro, here we need your
> point. The main point is if we need to call USB API to change
> roles (eg, usb_remove_hcd) during the role switch, thanks.

In my platform, it doesn't need to call USB API (usb_remove_hcd) when
"A-host" is changed to "A-peripheral".
(Since this is a prototype local code, the code is not upstreaming yet though.)

Best regards,
Yoshihiro Shimoda

> 
> [1] http://www.spinics.net/lists/linux-usb/msg142974.html
> --
> 
> Best Regards,
> Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
