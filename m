From: Badola Nikhil <nikhil.badola@freescale.com>
Subject: RE: [PATCH 2/3][v3] drivers: usb: dwc3: Add frame length adjustment
 quirk
Date: Thu, 3 Sep 2015 17:28:18 +0000
Message-ID: <SN1PR0301MB1629059BF4CA9A45BBE44A98F3680@SN1PR0301MB1629.namprd03.prod.outlook.com>
References: <1441260244-27279-1-git-send-email-nikhil.badola@freescale.com>
 <20150903155521.GD4031@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150903155521.GD4031@saruman.tx.rr.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "balbi@ti.com" <balbi@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Thursday, September 03, 2015 9:25 PM
> To: Badola Nikhil-B46172 <nikhil.badola@freescale.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> omap@vger.kernel.org; balbi@ti.com; gregkh@linuxfoundation.org
> Subject: Re: [PATCH 2/3][v3] drivers: usb: dwc3: Add frame length
> adjustment quirk
> 
> On Thu, Sep 03, 2015 at 11:34:04AM +0530, Nikhil Badola wrote:
> > Add adjust_frame_length_quirk for writing to fladj register which
> > adjusts (micro)frame length to value provided by
> > "snps,quirk-frame-length-adjustment" property thus avoiding USB 2.0
> > devices to time-out over a longer run
> >
> > Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> > ---
> > Changes for v3:
> > 	- removed unnecessary if(fladj) condition
> > 	- removed stray newline
> >
> >  drivers/usb/dwc3/core.c          | 34
> ++++++++++++++++++++++++++++++++++
> >  drivers/usb/dwc3/core.h          |  5 +++++
> >  drivers/usb/dwc3/platform_data.h |  2 ++
> >  3 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
> > 064123e..75a17bf 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -143,6 +143,32 @@ static int dwc3_soft_reset(struct dwc3 *dwc)
> >  	return 0;
> >  }
> >
> > +/*
> > + * dwc3_frame_length_adjustment - Adjusts frame length if required
> > + * @dwc3: Pointer to our controller context structure
> > + * @fladj: Value of GFLADJ_30MHZ to adjust frame length  */ static
> > +void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj) {
> > +	if (dwc->revision < DWC3_REVISION_250A)
> > +		return;
> > +
> > +	if (fladj == 0)
> > +		return;
> > +
> > +	u32 reg;
> > +	u32 dft;
> 
> are you seriously telling me that GCC didn't warn you about mixing
> declaration and code ?

That's really careless of me.  Somehow this warning skipped my attention.
Apologies for this silly thing. I will resend the patch.
