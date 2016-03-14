From: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Subject: RE: [PATCH] usb: dwc3: add disable receiver detection in P3 quirk
Date: Mon, 14 Mar 2016 07:00:36 +0000
Message-ID: <HE1PR0401MB20286F97B39C39DD97531556E3880@HE1PR0401MB2028.eurprd04.prod.outlook.com>
References: <1457929793-18910-1-git-send-email-rajesh.bhagat@nxp.com>
 <87io0pblai.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87io0pblai.fsf@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sriram Dash <sriram.dash@nxp.com>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@linux.intel.com]
> Sent: Monday, March 14, 2016 12:26 PM
> To: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-omap@vger.kernel.org; Sriram Dash
> <sriram.dash@nxp.com>; Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Subject: Re: [PATCH] usb: dwc3: add disable receiver detection in P3 quirk
> 
> 
> Hi,
> 

Hello Felipe, 

Thanks for the comments. 

> Rajesh Bhagat <rajesh.bhagat@nxp.com> writes:
> > [ text/plain ]
> > Some freescale QorIQ platforms require to disable receiver detection
> > in P3 for correct detection of USB devices. If
> > GUSB3PIPECTL(DISRXDETINP3) is set, Core will change PHY power state to
> > P2 and then perform receiver detection. After receiver detection, Core
> > will change PHY power state to P3. Same quirk would be added in dts file in future
> patches.
> >
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> > ---
> >  drivers/usb/dwc3/core.c          |    6 ++++++
> >  drivers/usb/dwc3/core.h          |    2 ++
> >  drivers/usb/dwc3/platform_data.h |    1 +
> >  3 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
> > de5e01f..b2f2b08 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -446,6 +446,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
> >  	if (dwc->u2ss_inp3_quirk)
> >  		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
> >
> > +	if (dwc->dis_rxdet_inp3_quirk)
> > +		reg |= DWC3_GUSB3PIPECTL_DISRXDETINP3;
> > +
> >  	if (dwc->req_p1p2p3_quirk)
> >  		reg |= DWC3_GUSB3PIPECTL_REQP1P2P3;
> >
> > @@ -903,6 +906,8 @@ static int dwc3_probe(struct platform_device *pdev)
> >  				"snps,u2exit_lfps_quirk");
> >  	dwc->u2ss_inp3_quirk = device_property_read_bool(dev,
> >  				"snps,u2ss_inp3_quirk");
> > +	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
> > +				"snps,dis_rxdet_inp3_quirk");
> 
> not documented under Documentation/devicetree/bindings/usb/dwc3.txt.
> 

Will take care in v2.

> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
> > e4f8b90..41cc22c 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -193,6 +193,7 @@
> >  /* Global USB3 PIPE Control Register */
> >  #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
> >  #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
> > +#define DWC3_GUSB3PIPECTL_DISRXDETINP3	(1 << 28)
> >  #define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
> >  #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
> >  #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK
> 	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
> > @@ -873,6 +874,7 @@ struct dwc3 {
> >
> >  	unsigned		tx_de_emphasis_quirk:1;
> >  	unsigned		tx_de_emphasis:2;
> > +	unsigned		dis_rxdet_inp3_quirk:1;
> 
> _must_ be sorted alphabetically and you _must_ update the kernel doc above this
> structure.
> 

Will take care in v2.

> >  };
> >
> >  /*
> > ----------------------------------------------------------------------
> > ---- */ diff --git a/drivers/usb/dwc3/platform_data.h
> > b/drivers/usb/dwc3/platform_data.h
> > index 2bb4d3a..9df1dfb 100644
> > --- a/drivers/usb/dwc3/platform_data.h
> > +++ b/drivers/usb/dwc3/platform_data.h
> > @@ -46,6 +46,7 @@ struct dwc3_platform_data {
> >
> >  	unsigned tx_de_emphasis_quirk:1;
> >  	unsigned tx_de_emphasis:2;
> > +	unsigned dis_rxdet_inp3_quirk:1;
> 
> likewise.
> 

Will take care in v2.

> --
> balbi
