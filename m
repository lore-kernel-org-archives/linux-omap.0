From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Wed, 21 Apr 2010 17:20:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E1EB3B1@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
	 <1271410679.2690.290.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044E1371C6@dbde02.ent.ti.com>
	 <19F8576C6E063C45BE387C64729E7394044E1EB360@dbde02.ent.ti.com>
 <1271848174.2433.49.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54039 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754188Ab0DULvH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 07:51:07 -0400
In-Reply-To: <1271848174.2433.49.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Wednesday, April 21, 2010 4:40 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> 
> On Wed, 2010-04-21 at 12:45 +0200, ext Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Hiremath, Vaibhav
> > > Sent: Friday, April 16, 2010 4:28 PM
> > > To: Tomi Valkeinen
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> > >
> > >
> > > > -----Original Message-----
> > > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > > Sent: Friday, April 16, 2010 3:08 PM
> > > > To: Hiremath, Vaibhav
> > > > Cc: linux-omap@vger.kernel.org
> > > > Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> > > >
> > > > On Mon, 2010-03-22 at 14:09 +0100, ext hvaibhav@ti.com wrote:
> > > > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > >
> > > > > In case of 720P with 90/270 degree rotation, the system reports
> > > > > GFX_FIFO_UNDERFLOW error which usually happens if DSS DMA is not
> able to
> > > > fill
> > > > > the FIFO as per requirement.
> > > > >
> > > > > In TRM (section 11.2.6.1.3), where is has been clearly mentioned
> that,
> > > > >
> > > > > "To improve the performance on 90 degree rotation, split the data
> access
> > > > on
> > > > > write side and not read side."
> > > > >
> > > > > That means, read should always happen on 0 degree and write should
> go to
> > > > > respective rotation view.
> > > > >
> > > >
> > > > With this patch my db test app (from
> > > > git://gitorious.org/linux-omap-dss2/omapfb-tests.git) shows a lot of
> > > > tearing when rotation != 0. I tested this on 3430SDP using the LCD.
> > [Hiremath, Vaibhav] Tomi,
> >
> > Yes, just now I tried your db application and I am also seeing tearing
> effect. All other apps (including the one which I used for testing) works
> fine for other rotation angles.
> >
> > Let me debug further before commenting anything on this, I just thought of
> updating you on this.
> 
> "db" app uses double buffering for updating the display, with maximum
> update rate. There's also "pan" app, that does a bit similar thing using
> fb offsets.
[Hiremath, Vaibhav] Sorry, was not at my desk. 

Tomi,
pan application works fine. The only issue I have seen is with db application.

> 
> What kind of test apps you have?
[Hiremath, Vaibhav] I have similar application which does panning using offset, it draws color bar pattern with giver rotation angle and keep on scrolling in 0,0 to max,max direction.

Thanks,
Vaibhav

> 
>  Tomi
> 

