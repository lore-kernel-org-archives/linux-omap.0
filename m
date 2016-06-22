From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 22 Jun 2016 15:33:29 +0800
Message-ID: <20160622073329.GD21361@shlinux2>
References: <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com>
 <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com>
 <20160621060517.GA5108@shlinux2>
 <877fdjovef.fsf@linux.intel.com>
 <20160621090738.GD5108@shlinux2>
 <87h9cmoo4s.fsf@linux.intel.com>
 <20160621130512.GF5108@shlinux2>
 <87por9lnjd.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87por9lnjd.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 22, 2016 at 09:56:22AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Peter Chen <hzpeterchen@gmail.com> writes:
> >> Peter Chen <hzpeterchen@gmail.com> writes:
> >> >> >> So far, I haven't seen anybody talking about real USB OTG (the spec)
> >> >> >> when they say OTG. Usually they just mean "a method for swapping between
> >> >> >> host and peripheral roles, but we really don't want all the extra cost
> >> >> >> of the OTG specification".
> >> >> >> 
> >> >> >
> >> >> > That's what I thought before, but the request from the Marketing guy is
> >> >> > "To prove the SoC is OTG compliance, support HNP and SRP", don't you
> >> >> > see the SoC reference manual say "it supports HNP and SRP"?
> >> >> >
> >> >> > If there is no request, who else wants to implement so complicated FSM
> >> >> > but seldom use cases, and go to pass OTG compliance test (tested by PET).
> >> >> 
> >> >> I stand corrected :-)
> >> >> 
> >> >> So there is one user for this layer. And this user has its own role
> >> >> control registers. I'm not convinced we need this large generic layer
> >> >> for one user.
> >> >> 
> >> >
> >> > You mean chipidea or dwc3? I have more comments below.
> >> 
> >> chipidea. From the point of OTG (or DRD) dwc3 is very
> >> self-sufficient. HW itself tracks state machine, much like MUSB does.
> >
> > You mean HW can do state machine switch? If we are A device,
> > - Does the hardware knows if B device is HNP enabled or not?
> 
> that's enabled through control message, keep a flag.
> 
> > - And if B device is HNP enabled, does it can switch itself from host
> > to peripheral when the B device is disconnected (a_suspend->a_peripheral)
> 
> It cannot. It must rely on hnp polling which is, again, a control message.
> 
> > Does hardware can really follow Figure 7-1: OTG A-device with HNP State
> > Diagram at On-The-Go and Embedded Host Supplement to the USB Revision
> > 2.0 Specification? And can pass PET test?
> 
> Seriously, what does this add to the conversation? It has already been
> stated that there's nobody asking for OTG certification on dwc3. So all
> of this is vaporware from the point of view of dwc3.

This is just a technical question that I can't understand your words
"HW itself tracks state machine"?

-- 

Best Regards,
Peter Chen
