From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Wed, 21 Apr 2010 16:15:09 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E1EB360@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
 <1271410679.2690.290.camel@tubuntu.research.nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E1371C6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35171 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754044Ab0DUKpQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 06:45:16 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E1371C6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hiremath, Vaibhav
> Sent: Friday, April 16, 2010 4:28 PM
> To: Tomi Valkeinen
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> 
> 
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Friday, April 16, 2010 3:08 PM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> >
> > On Mon, 2010-03-22 at 14:09 +0100, ext hvaibhav@ti.com wrote:
> > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >
> > > In case of 720P with 90/270 degree rotation, the system reports
> > > GFX_FIFO_UNDERFLOW error which usually happens if DSS DMA is not able to
> > fill
> > > the FIFO as per requirement.
> > >
> > > In TRM (section 11.2.6.1.3), where is has been clearly mentioned that,
> > >
> > > "To improve the performance on 90 degree rotation, split the data access
> > on
> > > write side and not read side."
> > >
> > > That means, read should always happen on 0 degree and write should go to
> > > respective rotation view.
> > >
> >
> > With this patch my db test app (from
> > git://gitorious.org/linux-omap-dss2/omapfb-tests.git) shows a lot of
> > tearing when rotation != 0. I tested this on 3430SDP using the LCD.
[Hiremath, Vaibhav] Tomi,

Yes, just now I tried your db application and I am also seeing tearing effect. All other apps (including the one which I used for testing) works fine for other rotation angles.

Let me debug further before commenting anything on this, I just thought of updating you on this.

Thanks,
Vaibhav

> >
> [Hiremath, Vaibhav] I had tested it with the sample application which draws
> color bars to the frame-buffer, let me once again check with your (omapfb-
> test) application.
> 
> Tomi,
> I am going out of station so will be able to do this on Tuesday.
> 
> Thanks,
> Vaibhav
> 
> >  Tomi
> >
> >
<snip>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
