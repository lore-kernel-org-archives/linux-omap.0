From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH v6 01/16] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Mon, 3 Oct 2011 20:40:44 +0530
Message-ID: <36fe5ae626b83bb4856f3a58a23bf503@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com> <4E871883.4010207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4E871883.4010207@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Govindraj Raja <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

---snip--
> > +{
> > +	struct omap_device_pad *pad;
> > +	int ret = -EINVAL, j;
> > +
> > +	if (oh->mux&&  oh->mux->enabled) {
> > +		for (j = 0; j<  oh->mux->nr_pads_dynamic; j++) {
> > +			pad = oh->mux->pads_dynamic[j];
> > +			if (pad->flags&  OMAP_DEVICE_PAD_WAKEUP) {
> > +				if (set_wake)
> > +					pad->idle |= OMAP_WAKEUP_EN;
> > +				else
> > +					pad->idle&= ~OMAP_WAKEUP_EN;
>
> I think apart from enabling/disabling the IO wakeup's at the pad
> level, there is also a need to trigger the IO daisy chain control
> (Wu clock) by programming the PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN
> bit and waiting on the PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN) bit,
> which is done by the omap3_enable/disable_io_chain function.
> This is still done in the cpuidle path, but it makes sense to
> move that over here, since it should be done every time a pad
> level wakeup is enabled or disabled.
>
> See section 3.5.7.2.2 I/O Wake-Up Mechanism of 36xx TRM revA.
>
> "The I/O wake-up scheme is enabled by triggering the I/O daisy chain
> control (Wu clock) by
> programming a dedicated register (PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN)
> in
> the PRCM module.Software must wait for the I/O daisy chain to
> complete
> before it transitions the PER domain to a
> nonfunctional state. This is done by polling a dedicated status bit
> in
> the PRCM module
> (PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN). This status bit must be cleared
> by
> software when the bit is
> read to 1."
I am working on adding Daisy chain support via hwmod mux framework.
I will post the patches soon.

Regards
Vishwa
