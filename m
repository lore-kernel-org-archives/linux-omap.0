From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Tue, 10 Jul 2012 23:47:25 -0700
Message-ID: <20120711064724.GA1122@atomide.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
 <20120705105535.GB1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com>
 <20120706120533.GU1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A622E@DBDE01.ent.ti.com>
 <20120710094538.GT1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A64D0@DBDE01.ent.ti.com>
 <20120710131734.GV1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A669D@DBDE01.ent.ti.com>
 <4FFC6330.1040409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47263 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab2GKGr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 02:47:29 -0400
Content-Disposition: inline
In-Reply-To: <4FFC6330.1040409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [120710 10:20]:
> Hi Afzal,
> 
> On 07/10/2012 08:47 AM, Mohammed, Afzal wrote:
> > Hi Tony,
> > 
> > On Tue, Jul 10, 2012 at 18:47:34, Tony Lindgren wrote:
> >> * Mohammed, Afzal <afzal@ti.com> [120710 03:09]:
> >>> On Tue, Jul 10, 2012 at 15:15:38, Tony Lindgren wrote:
> >>>> * Mohammed, Afzal <afzal@ti.com> [120709 23:24]:
> > 
> >>>>> For the peripherals requiring retime, we cannot (as otherwise whatever
> >>>>> retime does would have to be manually done based on the knowledge of
> >>>>> boot time gpmc clock period to calculate gpmc timings to be fed to DT)
> >>>>> pass gpmc timings via device tree, right ?
> >>>>
> >>>> We can still do it when the connected peripheral probe registers with
> >>>> gpmc.
> > 
> > Were you actually referring to updating kernel view of device tree nodes, and
> > not the device tree file (not sure whether it is really possible) ?
> 
> I believe that Tony is suggesting performing the retime at probe time.
> In the case of OneNand you would simply call the
> onenand_set_async_mode/sync_mode from within the probe as a retime
> function.

Yes there's no need to do it earlier.
 
> >>> We can, but would it be feasible practically ?, gpmc timings to update in
> >>> DT for a such a peripheral (requiring retime) can be found out only by
> >>> manual calculation similar to the way done in retime function (based on
> >>> peripheral's timings and boot time gpmc clock period), correct ?, Also
> >>> wouldn't this make it necessary to know gpmc clock period at boot time
> >>> for properly updating gpmc timing entry in DT ?
> >>
> >> The gpmc clock period can be returned to the connected peripheral when
> >> it's registering. Well basically we can call the retime function upon
> >> registering and pass the gpmc clock period.
> > 
> > Won't this lead to the necessity of particular driver load order problem ?,
> > As per the above, to return gpmc clock period to the connected peripheral,
> > we need to ensure that gpmc driver is probed before peripheral driver.
> 
> I think it is more like when probing the gpmc, the retime function for
> the connected peripheral is called passing the gpmc clock freq.

Right, there's no need to do any of that at gpmc probe time. And the
module dependencies take care of the load ordrer as gpmc_cs_request()
is exported.
 
> > And in that case how can gpmc driver rely on DT as gpmc timings for the
> > peripheral requiring retime would not yet be available as peripheral
> > driver is not yet probed, seems like a circular dependency.
> 
> The DT node should simply have the information required by the retime
> function or gpmc timings themselves if available. In the case of OneNAND
> async mode you have a bunch of constants such as ...
> 
> const int t_cer  = 15;
> const int t_avdp = 12;
> const int t_cez  = 20; /* max of t_cez, t_oez */
> const int t_ds   = 30;
> const int t_wpl  = 40;
> const int t_wph  = 30
> 
> These can be stored in the DT and then translated to gpmc timings at
> runtime. DT should only store static timing or clock information known
> at compile time.

Yup. And the format of the timing data in DT should be standardized so
the only differences for each connected peripheral is the retime function.
 
> >>> And in this case, we are going to register retime function, so instead of
> >>> relying on DT to provide gpmc timings for such a peripheral, won't it
> >>> be better to make use of retime that is already registered ?
> >>
> >> No we need to pass the timings from device tree as they may be different
> >> for similar boards. For example, different level shifters used on
> >> similar boards may affect the timings, although the retime function
> >> can be the same.
> > 
> > Unless I am missing something, could not see this scenario taken care
> > in the existing retime functions, did see one comment for smc91x, but
> > seems in that case Kernel doesn't do any timing configuration and
> > leave timings as configured by bootloader
> 
> I think that we just need to adapt the current functions that our
> calculating the timings so that ...
> 
> 1. We can call from them within the gpmc probe to setup the timings
> versus having the peripherals program the gpmc priory to probe.
> 2. Any static timing information needed by the retime function is part
> of the platform data passed to the gpmc probe and therefore can also be
> read from DT.

Yup, and also:

3. Disable frequency scaling for L3 if no retime function is specified

In that case we may have a generic default function that just sets the
boot time values and disables the L3 scaling.
 
> From a high-level I think that the goal should be ...
> 
> gpmc_probe
> 	--> request CS
> 	--> calls retime function to calculate gpmc timing (optional)
> 	--> configures CS
> 	--> registers peripheral device

Yes with few additions.. Connected peripheral probe requests CS from
gpmc with the optional retime function pointer passed as a parameter.
After gpmc code has determined the CS is available, it calls the optional
retime function before returning back to the connected peripheral probe.

So how about the following with a bit more details:

gpmc_probe
	--> just sets up gpmc resources then idles itself

connected peripheral probe
	--> calls gpmc_cs_request() with gpmc timings from DT and an
	    optional retime function as a parameter
	--> gpmc_cs_request() allocates the CS
	--> gpmc_cs_request() calls the optional retime function and
	    if not specified, just sets the DT timings and disables
	    L3 DFS
	--> gpmc_cs_request() returns to connected peripheral probe

Regards,

Tony
