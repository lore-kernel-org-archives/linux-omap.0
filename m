From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
 omap4
Date: Sat, 2 Dec 2017 09:00:46 -0800
Message-ID: <20171202170046.GT28152@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
 <20170830151953.30856-15-tony@atomide.com>
 <20170911215016.far2rpihdd423ybt@rob-hp-laptop>
 <CAHCN7xL81vq+eUX_mPr7jrxTMBygqLST15okF5hipQDAP0j2PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xL81vq+eUX_mPr7jrxTMBygqLST15okF5hipQDAP0j2PQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [171202 00:20]:
> On Mon, Sep 11, 2017 at 4:50 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Wed, Aug 30, 2017 at 08:19:50AM -0700, Tony Lindgren wrote:
> >> On omap4 we're missing the PowerVR SGX GPU node with it's related
> >> "ti,hwmods" property that the SoC interconnect code needs.
> >>
> >> Note that this will only show up as a bug with "doesn't have
> >> mpu register target base" boot errors when the legacy platform
> >> data is removed.
> >>
> >> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> >> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >> ---
> 
> Out of curiosity, is anything being done with this?  I'm really
> interested to see the PVR working in a modern kernel.  I'd like to
> help more, but I am afraid I don't fully understand the interconnects
> and how the driver componenets interact with the omap processor.
> 
> Please let me know if there are sub-tasks that I can assist.

Well the powervr node should use a powervr generic binding that
does not yet exist. I think the TI tree binding could be easily
modified for a generic binding. So first doing a binding patch
for powervr and Cc dt list and SoC maintainers with powervr on
them would help.

And then eventually the powervr generic node should be a child
node under the "target-module" node in the dtsi file. See what
we have for gpu target-module@56000000 in omap4.dtsi.

Note that the interconnect target module does not yet work for
omap3 as the clocks are different. I'll be posting patches for
the clocks over next few weeks.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
