From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Date: Fri, 4 Dec 2015 10:47:07 -0800
Message-ID: <20151204184706.GO23396@atomide.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
 <87wpsunn82.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87wpsunn82.fsf-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [151204 09:23]:
> 
> Hi,
> 
> Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> writes:
> > @@ -174,12 +182,44 @@
> >  		};
> >  
> >  		edma: edma@49000000 {
> > -			compatible = "ti,edma3";
> > -			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > -			reg =	<0x49000000 0x10000>,
> > -				<0x44e10f90 0x40>;
> > +			compatible = "ti,edma3-tpcc";
> > +			ti,hwmods = "tpcc";
> > +			reg =	<0x49000000 0x10000>;
> > +			reg-names = "edma3_cc";
> >  			interrupts = <12 13 14>;
> > -			#dma-cells = <1>;
> > +			interrupt-names = "edma3_ccint", "emda3_mperr",
> > +					  "edma3_ccerrint";
> > +			dma-requests = <64>;
> > +			#dma-cells = <2>;
> > +
> > +			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
> > +				   <&edma_tptc2 0>;
> > +
> > +			ti,edma-memcpy-channels = /bits/ 16 <20 21>;
> 
> can you explain this property here ? Are you setting bits 20 and 21 on a
> 16-bit field ?

I think it's an arry of u16 dma channels.. But could it be just /bits/ 8
instead of /bits/ 16?

Regards,

Tony


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
