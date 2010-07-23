From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 4/5] OMAP: DSS2: Video3 pipeline IRQs
Date: Fri, 23 Jul 2010 11:22:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044ED62F7B@dbde02.ent.ti.com>
References: <1279540544-12682-1-git-send-email-archit@ti.com>
 <1279540544-12682-2-git-send-email-archit@ti.com>
 <1279540544-12682-3-git-send-email-archit@ti.com>
 <1279540544-12682-4-git-send-email-archit@ti.com>
 <1279540544-12682-5-git-send-email-archit@ti.com>
 <19F8576C6E063C45BE387C64729E7394044ED62F62@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870305EEAA36@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59465 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab0GWFwH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 01:52:07 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870305EEAA36@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>


> -----Original Message-----
> From: Taneja, Archit
> Sent: Friday, July 23, 2010 11:17 AM
> To: Hiremath, Vaibhav; tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Semwal, Sumit; Mittal, Mukund
> Subject: RE: [PATCH 4/5] OMAP: DSS2: Video3 pipeline IRQs
> 
> 
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Friday, July 23, 2010 11:10 AM
> > To: Taneja, Archit; tomi.valkeinen@nokia.com
> > Cc: linux-omap@vger.kernel.org; Semwal, Sumit; Mittal,
> > Mukund; Taneja, Archit
> > Subject: RE: [PATCH 4/5] OMAP: DSS2: Video3 pipeline IRQs
> >
> 
> <snap>
> 
> > > @@ -173,7 +173,8 @@ struct dispc_reg { u16 idx; };
> > >  					 DISPC_IRQ_SYNC_LOST | \
> > >  					 DISPC_IRQ_SYNC_LOST_DIGIT | \
> > >  					 (cpu_is_omap44xx() ? \
> > > -					 DISPC_IRQ_SYNC_LOST_2 : 0))
> > > +
> > (DISPC_IRQ_VID3_FIFO_UNDERFLOW | \
> > > +					 DISPC_IRQ_SYNC_LOST_2) : 0))
> > [Hiremath, Vaibhav] This looks bit suspicious to me, against
> > which tree this patch has been generated? I think you have
> > missed some of the patches in between.
> 
> [Archit] This patch series sits over a previously sent RFC:
> 
> https://patchwork.kernel.org/patch/111901/
> 
[Hiremath, Vaibhav] Ohhh, I missed it completely. Perhaps it would be good if you could mention this dependency in you PATCH [0/x].

I think Sanjeev has already provided some comments, so I would rather prefer to review latest version (when you post it again).

Thanks,
Vaibhav
> >
> > >
> > >  #define DISPC_MAX_NR_ISRS		8
> > >
> > > @@ -2540,6 +2541,8 @@ void dispc_dump_irqs(struct seq_file *s)
> > >  		PIS(VSYNC2);
> > >  		PIS(ACBIAS_COUNT_STAT2);
> > >  		PIS(SYNC_LOST_2);
> > > +		PIS(VID3_FIFO_UNDERFLOW);
> > > +		PIS(VID3_END_WIN);
> > >  	}
> > >  #undef PIS
> > >  }
> > > @@ -3151,6 +3154,24 @@ static void dispc_error_worker(struct
> > > work_struct
> > > *work)
> > >  		}
> > >  	}
> > >
> > > +	if (errors & DISPC_IRQ_VID3_FIFO_UNDERFLOW) {
> > > +		DSSERR("VID3_FIFO_UNDERFLOW, disabling VID2\n");
> > [Hiremath, Vaibhav] typo mistake VID2 => VID3
> >
> > Thanks,
> > Vaibhav
> 
> Will fix this.
> 
> Thanks,
> 
> Archit
