From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/5] OMAP3EVM: Board bug fixes/enhancements
Date: Fri, 28 Jan 2011 00:16:07 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD7BE82E@dbde02.ent.ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
 <87pqrinq8x.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45017 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab1A0SqU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 13:46:20 -0500
In-Reply-To: <87pqrinq8x.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, January 28, 2011 12:12 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 0/5] OMAP3EVM: Board bug fixes/enhancements
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > The current linux-omap/master is broken for lots of features/modules
> > and also there are few enhancements required with addition of AM/DM37x
> > family of devices.
> >
> > 	- Migrate TWL gpio_xxx api to gpio_xx_cansleep
> > 	- TSC: Driver init fails due to missing VIO regulator
> > 	- TSC: Wakeup is broken, enable the wakeup capability
> > 	- DSS: Addition of Mux changes for AM/DM37x
> > 	- Make Backlight gpio off in default state
> >
> > Note: Resetting the revision of patches since this is first bundled
> series.
> 
> Again, please state exactly what tree and commit this applies to, as it
> does not apply cleanly to l-o master.
> 
> Specifically,
> 
> > Vaibhav Hiremath (5):
> >   OMAP:board-omap3evm: Change TWL related gpio API's to gpio*_cansleep
> >   OMAP3EVM: Add vio regulator supply required for ads7846 TSC driver
> >   AM/DM37x: DSS mux configuration for >Rev-B processor cards
> 
> This one doesn't apply without fuzz.
> 
> >   OMAP3EVM: Made backlight GPIO default state to off
> >   OMAP3EVM: Set TSC wakeup option in pad config
> 
> And this one doesn't apply as it seems to apply on top of code that
> doesn't exist upstream.
> 
[Hiremath, Vaibhav] Kevin,

You should first apply Ethernet-reset patch first, and then all patches will get applied cleanly. I have tested it here at my end. 

Since you already acked Ethernet patch, I thought it will make its way to mainline before all these patches. And also while posting, I posted Ethernet patch again first and then this series.


Thanks,
Vaibhav

> Kevin

