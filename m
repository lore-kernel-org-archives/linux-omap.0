From: Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v2 0/2] usb: dwc3: add disable receiver detection in P3
 quirk
Date: Mon, 18 Apr 2016 06:05:10 +0000
Message-ID: <HE1PR0401MB202854A38CBFC02201176D94E36B0@HE1PR0401MB2028.eurprd04.prod.outlook.com>
References: <1457946651-23381-1-git-send-email-rajesh.bhagat@nxp.com>
 <DB5PR0401MB2024DEBF67F3990558A1D6BBF56B0@DB5PR0401MB2024.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sriram Dash <sriram.dash-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Rajesh Bhagat
> Sent: Monday, April 18, 2016 11:31 AM
> To: 'balbi-l0cyMroinI0@public.gmane.org' <balbi-l0cyMroinI0@public.gmane.org>
> Cc: 'gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org' <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; 'linux-
> usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org' <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; 'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'
> <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; 'linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org' <linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Sriram Dash <sriram.dash-3arQi8VN3Tc@public.gmane.org>; Rajesh Bhagat
> <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
> Subject: RE: [PATCH v2 0/2] usb: dwc3: add disable receiver detection in P3 quirk
> 
> >-----Original Message-----
> >From: Rajesh Bhagat [mailto:rajesh.bhagat-3arQi8VN3Tc@public.gmane.org]
> >Sent: Monday, March 14, 2016 2:41 PM
> >To: balbi-l0cyMroinI0@public.gmane.org
> >Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> >kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sriram Dash
> ><sriram.dash-3arQi8VN3Tc@public.gmane.org>; Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
> >Subject: [PATCH v2 0/2] usb: dwc3: add disable receiver detection in P3
> >quirk
> >
> >Adds disable receiver detection in P3 quirk in DWC3 driver.
> >
> >Rajesh Bhagat (2):
> >  usb: dwc3: add disable receiver detection in P3 quirk
> >  Documentation: dt: dwc3: Add snps,dis_rxdet_inp3_quirk property
> >
> > Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
> > drivers/usb/dwc3/core.c                        | 6 ++++++
> > drivers/usb/dwc3/core.h                        | 2 ++
> > drivers/usb/dwc3/platform_data.h               | 1 +
> > 4 files changed, 11 insertions(+)
> >
> 
> Hello Felipe,
> 
> Any comments on above [v2] patches?
> 
> Best Regards,
> Rajesh Bhagat
> 

Just realized Felipe's email id has changed, Resending.

> >--
> >2.6.2.198.g614a2ac

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
