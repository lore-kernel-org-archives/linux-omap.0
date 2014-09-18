From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA7: Add PMU nodes
Date: Thu, 18 Sep 2014 09:58:18 -0700
Message-ID: <20140918165817.GI14505@atomide.com>
References: <1408456440-30171-1-git-send-email-nm@ti.com>
 <540719FC.5070803@ti.com>
 <20140917142503.GA11856@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140917142503.GA11856@kahuna>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140917 07:26]:
> On 08:39-20140903, Nishanth Menon wrote:
> > On 08/19/2014 08:54 AM, Nishanth Menon wrote:
> > > From: Lucas Weaver <l-weaver-l0cyMroinI0@public.gmane.org>
> > > 
> > > DRA74x and DRA72x family of processors vary slightly in the number
> > > of CPUs. So, add different instances of PMU for each of these processor
> > > groups. Further, since the interrupts bypass crossbar and are directly
> > > connected to GIC, mark the dts nodes with relevant information.
> > > 
> > > Tested with perf utility.
> > > 
> > > Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > > Signed-off-by: Lucas Weaver <l-weaver-l0cyMroinI0@public.gmane.org>
> > > Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > > ---
> > Hi,
> > Gentle ping..
> 
> Tony,
> I dont see this patch in omap-for-v3.18/dt
> 
> Is there anyway you might consider pulling this for 3.18?
> 
> Patchworks link:
> https://patchwork.kernel.org/patch/4743121/

Thanks applying into omap-for-v3.18/dt.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
