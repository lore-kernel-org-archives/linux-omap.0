From: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Subject: RE: [PATCH v2 0/2] usb: dwc3: add disable receiver detection in P3
 quirk
Date: Mon, 18 Apr 2016 06:01:31 +0000
Message-ID: <HE1PR0401MB202883D07F5AB0E1FF7C00E1E36B0@HE1PR0401MB2028.eurprd04.prod.outlook.com>
References: <1457946651-23381-1-git-send-email-rajesh.bhagat@nxp.com>
 <DB5PR0401MB2024DEBF67F3990558A1D6BBF56B0@DB5PR0401MB2024.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB5PR0401MB2024DEBF67F3990558A1D6BBF56B0@DB5PR0401MB2024.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "balbi@ti.com" <balbi@ti.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sriram Dash <sriram.dash@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>
List-Id: linux-omap@vger.kernel.org

>-----Original Message-----
>From: Rajesh Bhagat [mailto:rajesh.bhagat@nxp.com]
>Sent: Monday, March 14, 2016 2:41 PM
>To: balbi@ti.com
>Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-omap@vger.kernel.org; Sriram Dash
><sriram.dash@nxp.com>; Rajesh Bhagat <rajesh.bhagat@nxp.com>
>Subject: [PATCH v2 0/2] usb: dwc3: add disable receiver detection in P3
>quirk
>
>Adds disable receiver detection in P3 quirk in DWC3 driver.
>
>Rajesh Bhagat (2):
>  usb: dwc3: add disable receiver detection in P3 quirk
>  Documentation: dt: dwc3: Add snps,dis_rxdet_inp3_quirk property
>
> Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
> drivers/usb/dwc3/core.c                        | 6 ++++++
> drivers/usb/dwc3/core.h                        | 2 ++
> drivers/usb/dwc3/platform_data.h               | 1 +
> 4 files changed, 11 insertions(+)
>

Hello Felipe,

Any comments on above [v2] patches?

Best Regards,
Rajesh Bhagat 

>--
>2.6.2.198.g614a2ac
