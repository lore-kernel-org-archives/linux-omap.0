From: Badola Nikhil <nikhil.badola@freescale.com>
Subject: RE: [PATCH 2/3][v2] drivers: usb: dwc3: Add frame length adjustment
 quirk
Date: Tue, 1 Sep 2015 07:40:46 +0000
Message-ID: <SN1PR0301MB162922D2C8BCBD257E4FA545F36A0@SN1PR0301MB1629.namprd03.prod.outlook.com>
References: <1439785496-27243-1-git-send-email-nikhil.badola@freescale.com>
 <20150901072033.GA2873@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150901072033.GA2873@saruman.tx.rr.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "balbi@ti.com" <balbi@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Tuesday, September 01, 2015 12:51 PM
> To: Badola Nikhil-B46172 <nikhil.badola@freescale.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> omap@vger.kernel.org; balbi@ti.com; gregkh@linuxfoundation.org
> Subject: Re: [PATCH 2/3][v2] drivers: usb: dwc3: Add frame length
> adjustment quirk
> 
> Hi,
> 
> On Mon, Aug 17, 2015 at 09:54:56AM +0530, Nikhil Badola wrote:
> > +static void dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj)
> > +{
> > +	if (dwc->revision < DWC3_REVISION_250A)
> > +		return;
> > +
> > +	if (fladj == 0)
> > +		return;
> > +
> > +	if (fladj) {
> 
> right here you know fladj to be non-zero.
> 
> > @@ -957,6 +990,7 @@ static int dwc3_probe(struct platform_device
> *pdev)
> >  		goto err1;
> >  	}
> >
> > +
> 
> stray change
> 
Will make both changes and send a new version.
