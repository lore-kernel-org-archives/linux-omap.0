From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: switch to using remoteproc OF
 infrastructure
Date: Fri, 12 Aug 2016 09:43:35 -0700
Message-ID: <20160812164335.GG26240@tuxbot>
References: <20160812003529.519-1-s-anna@ti.com> <20160812110201.GD25844@dell>
 <55d90506-eb1b-c8f9-02b5-8484b9a4babd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <55d90506-eb1b-c8f9-02b5-8484b9a4babd@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, linux-remoteproc@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri 12 Aug 09:00 PDT 2016, Suman Anna wrote:

> On 08/12/2016 06:02 AM, Lee Jones wrote:
> > On Thu, 11 Aug 2016, Suman Anna wrote:
> > 
> >> The remoteproc framework has been enhanced recently to provide new
> >> OF API to retrieve a remoteproc handle by client drivers through a
> >> standard 'rprocs' property in client nodes. The wkup_m3_ipc driver
> >> has been using a custom 'ti,rproc' property until now, switch this
> >> to use this new OF infrastructure. The wkup_m3_ipc driver has been
> >> fixed up to provide backward compatibility for older DTBs by
> >> replacing the older property with the standard newer property.
> >>
> >> The wkup_m3_ipc binding has also been updated accordingly.
> >>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> ---
> >> This patch is based on the discussion [1] for introducing new standard
> >> OF API in remoteproc core series [2] and the exporting of couple of
> >> functions in OF base code [3].
> >>
> >> With this in place, the remoteproc core need not be looking for the
> >> TI specific property anymore. I will submit the DTS changes once this
> >> makes it to mainline.
> >>
> >> regards
> >> Suman
> >>
> >> [1] https://patchwork.kernel.org/patch/9237767/
> >> [2] http://marc.info/?l=linux-kernel&m=146894341701010&w=2
> >> [3] https://patchwork.kernel.org/patch/9276181/
> >>
> >>  .../devicetree/bindings/soc/ti/wkup_m3_ipc.txt     |  9 ++++++--
> >>  drivers/soc/ti/wkup_m3_ipc.c                       | 26 +++++++++++++++++++++-
> >>  2 files changed, 32 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
> >> index 401550487ed6..2ea7dd91acff 100644
> >> --- a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
> >> +++ b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
> >> @@ -23,12 +23,17 @@ Required properties:
> >>  			with the Wakeup M3 processor
> >>  - interrupts:		Contains the interrupt information for the wkup_m3
> >>  			interrupt that signals the MPU.
> >> -- ti,rproc:		phandle to the wkup_m3 rproc node so the IPC driver
> >> +- rprocs:		phandle to the wkup_m3 rproc node so the IPC driver
> >>  			can boot it.
> >>  - mboxes:		phandles used by IPC framework to get correct mbox
> >>  			channel for communication. Must point to appropriate
> >>  			mbox_wkupm3 child node.
> >>  
> >> +Deprecated properties:
> >> +----------------------
> >> +- ti,rproc:		This property has been replaced with the "rprocs"
> >> +			property.
> >> +
> >>  Example:
> >>  --------
> >>  /* AM33xx */
> >> @@ -48,7 +53,7 @@ Example:
> >>  				compatible = "ti,am3352-wkup-m3-ipc";
> >>  				reg = <0x1324 0x24>;
> >>  				interrupts = <78>;
> >> -				ti,rproc = <&wkup_m3>;
> >> +				rprocs = <&wkup_m3>;
> >>  				mboxes = <&mailbox &mbox_wkupm3>;
> >>  			};
> >>  
> >> diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
> >> index 8823cc81ae45..86085f9bf6a8 100644
> >> --- a/drivers/soc/ti/wkup_m3_ipc.c
> >> +++ b/drivers/soc/ti/wkup_m3_ipc.c
> >> @@ -1,7 +1,7 @@
> >>  /*
> >>   * AMx3 Wkup M3 IPC driver
> >>   *
> >> - * Copyright (C) 2015 Texas Instruments, Inc.
> >> + * Copyright (C) 2015-2016 Texas Instruments, Inc.
> >>   *
> >>   * Dave Gerlach <d-gerlach@ti.com>
> >>   *
> >> @@ -390,6 +390,8 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
> >>  	struct resource *res;
> >>  	struct task_struct *task;
> >>  	struct wkup_m3_ipc *m3_ipc;
> >> +	struct property *nprop, *oprop;
> >> +	const char nprop_name[] = "rprocs";
> >>  
> >>  	m3_ipc = devm_kzalloc(dev, sizeof(*m3_ipc), GFP_KERNEL);
> >>  	if (!m3_ipc)
> >> @@ -415,6 +417,28 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
> >>  		return ret;
> >>  	}
> >>  
> >> +	/* provide compatibility for older DTBs using ti,rproc property */
> >> +	nprop = of_find_property(dev->of_node, "rprocs", NULL);
> >> +	if (!nprop) {
> >> +		oprop = of_find_property(dev->of_node, "ti,rproc", NULL);
> >> +		if (!oprop) {
> >> +			dev_err(&pdev->dev, "node is missing ti,rproc property\n");
> >> +			return -ENODEV;
> >> +		}
> >> +
> >> +		nprop = kzalloc(sizeof(*nprop) + sizeof(nprop_name),
> >> +				GFP_KERNEL);
> >> +		if (!nprop)
> >> +			return -ENOMEM;
> >> +
> >> +		nprop->name = (char *)nprop + sizeof(*nprop);
> >> +		snprintf(nprop->name, sizeof(nprop_name), nprop_name);
> >> +		nprop->value = oprop->value;
> >> +		nprop->length = oprop->length;
> >> +		of_update_property(dev->of_node, nprop);
> >> +		of_remove_property(dev->of_node, oprop);
> >> +	}
> >> +
> > 
> > +1 for getting the functionality out of core code.
> > 
> > -100 for having to jump though all these hoops.
> > 
> > If you are going to keep all of this, I would at least tuck it away in
> > a header file or something.
> 
> Hiding it somewhere else won't make much of a difference though. If this
> is such an eyesore, we still can do this cleanly without jumping through
> these hoops. I would say this is a direct result of the removal of the
> rproc_get_by_phandle API in Patch 2 of your OF remoteproc series [2].
> That API is still an agnostic API. We can just add the of_rproc_get()
> convenience helper in your Patch 1 and drop patch 2 completely with no
> references to ti,rproc in the core code in the first place. The other
> option, if we do want to remove that API is to add an additional
> property name argument (NULL to mean "rprocs") to
> of_rproc_get_by_index(), and it can be hidden away under of_rproc_get()
> API - which is what I am expecting most of the new client users would
> use anyway.
> 
> Once "rprocs" hits mainline, I will definitely switch over the
> wkup_m3_ipc nodes to use that standard property and can fix this driver
> independently.
> 

We're stuck with this problem all over the place, as the world continues
to evolve we will have issues with DT being static. This has been
discussed many times before and the suggested solution is always what
you implemented here - make the code deal with both versions, preferably
by patching.

The fact that you had to export the of_ operations indicates that no-one
has tried this before and I'm happy you did. I'm however not happy about
the size of the chunk of code it takes to do this dance.

I think for this to be practical we need to provide higher level
operations for DT modification - in this case a of_rename_property().

@Rob, any comments on this?

> Anyway, I have given all sorts of inputs to arrive at a clean solution
> in both remoteproc core and this driver. I will leave it to Bjorn and
> Tony/Santosh to decide what they want in each driver. As it is, this
> patch will be moot if the core OF exports patch falls through.
> 

I appreciate your input and we need to settle above discussion
regardless of this case - and by then have it implemented as you have
suggested.

Regards,
Bjorn
