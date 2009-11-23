From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/3] Input:TouchScreen: Introduce TSC2004 driver support
Date: Mon, 23 Nov 2009 15:45:09 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404370D7395@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1258642000-2271-1-git-send-email-hvaibhav@ti.com>
 <20091120170220.GA16447@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20091120170220.GA16447@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Friday, November 20, 2009 10:32 PM
> To: Hiremath, Vaibhav
> Cc: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/3] Input:TouchScreen: Introduce TSC2004 driver
> support
> 
> Hi Vaibhav,
> 
> On Thu, Nov 19, 2009 at 08:16:40PM +0530, hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> 
> If I do:
> 
> sed 's/2004/2007/g' drivers/input/touchscreen/tsc2004.c | diff -u
> drivers/input/touchscreen/tsc2007.c -
> 
> the diff is miniscule so why can't TSC2004 support be simply added
> to
> TSC2007 driver?
[Hiremath, Vaibhav] The driver which I submitted is the basic version, there is lot which required to be added here for complete support of TSC2004 features. I tried to summarize it (in short) here - 

	- TSC2004 supports register based control, whereas TSC2007 is command based control.
	- TSC2004 supports 2 different modes of operation, whereas there is nothing like this in TSc2007
	- There are lots of configuration options TSC2004 provides.

Again there are differences like command/address formats 

TSC2004 -
---------- 
BIT 	NAME 		DESCRIPTION
D7 			Control Byte ID 1
D6-D3 C3-C0		Converter function select		
D2 	M 		1: 12 Bit 0: 10 bit
D1 SWRST		Software Reset.
D0 STS 		Stop bit for all converter functions.
 
TSC2007 - 
---------
BIT 	NAME 		DESCRIPTION
D7-D4 C3-C0 	All Converter Function Select bits
D3-D2 PD1-PD0	Power down bit control
D1 	M 		1: 8-bit 0: 12 bit
D0 	X Don't care.


So in my opinion we must not try to merge drivers for these two devices. I hope this information clears all the confusion.

Thanks,
Vaibhav
> 
> Thanks.
> 
> --
> Dmitry

