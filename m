From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am33xx: Remove unnecessary properties
Date: Fri, 14 Dec 2018 07:18:25 -0800
Message-ID: <20181214151825.GU6707@atomide.com>
References: <20181210132448.7865-1-fb@ltec.ch>
 <20181211163618.GU6707@atomide.com>
 <20181211164336.GV6707@atomide.com>
 <89710fa1-38a9-1628-0651-003332780483@ltec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <89710fa1-38a9-1628-0651-003332780483@ltec.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Brack <fb@ltec.ch>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com, robh+dt@kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felix Brack <fb@ltec.ch> [181214 15:12]:
> Hi Tony,
> 
> On 11.12.2018 17:43, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [181211 16:36]:
> >> * Felix Brack <fb@ltec.ch> [181210 05:25]:
> >>> Remove the unnecessary properties #address-cells and #size-cells
> >>> of node pinmux as there are no child-nodes with property reg.
> >>
> >> Applying into omap-for-v4.21/dt thanks.
> > 
> > Actually this currently conflicts with the pending
> > am33xx l4 ti-sysc changes, so let's wait on this
> > one to avoid causing merge conflicts between
> > branches.
> >
> Okay, I see. The changes introduced by my patch would then affect the
> new file am33xx-l4.dtsi instead of am33xx.dtsi

Yup, and I wanted to keep the am33xx-l4.dtsi in a separate
branch from the rest of the dts changes.

> > So dropping for now.
> >
> Will you "apply" my patch once the am33xx l4 ti-sysc changes are applied
> or do you expect me to send V2 patch (to be applied to the new
> am33xx-l4.dtsi) ?

I'd prefer you to send an updated version against
Linux next as the am33xx-l4.dtsi changes have been
in next for a while now. It is unlikely at this point
that they would not get merged, but I'd rather wait
a bit before applying to avoid mixing the two otherwise
independent branches :)

Regards,

Tony
