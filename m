From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: mfd/omap-usb-tll: Allocate driver data at once in
 usbtll_omap_probe()
Date: Mon, 15 Jan 2018 20:33:42 +0100
Message-ID: <20180115193342.GA32536@lenoch>
References: <20180115134101.GA6711@lenoch>
 <1ebb5ac5-aa4d-7c19-94db-210b518d562f@users.sourceforge.net>
 <20180115160522.GA2672@lenoch>
 <11eaf92d-3928-531f-35e8-fb5a60ff03e3@users.sourceforge.net>
 <20180115163543.GA10657@lenoch>
 <ead577ac-a36b-dfc4-9f2c-3d5f34495d78@users.sourceforge.net>
 <20180115174122.GA20745@lenoch>
 <cadb0da1-23d0-f629-8dcf-8d2566058812@users.sourceforge.net>
 <20180115183059.GA30039@lenoch>
 <9266b6cb-6b9f-5b76-dab8-8ec36269928f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9266b6cb-6b9f-5b76-dab8-8ec36269928f@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 15, 2018 at 08:26:00PM +0100, SF Markus Elfring wrote:
> >  		dev_dbg(dev,
> >  		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
> > -			ver, tll->nch);
> > +			ver, nch);
> >  		break;
> 
> Does this format string need an other indentation when you touch this statement?

Well, lets that the chance and make it shorter as well:

 	default:
-		tll->nch = OMAP_TLL_CHANNEL_COUNT;
-		dev_dbg(dev,
-		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
-			ver, tll->nch);
+		nch = OMAP_TLL_CHANNEL_COUNT;
+		dev_dbg(dev, "rev 0x%x not recognized, assuming %d channels\n",
+			ver, nch);
 		break;

Other proposals? 
