From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] arm: omap: Proper cleanups for omap_device
Date: Thu, 8 Aug 2013 00:25:14 -0700
Message-ID: <20130808072513.GY7656@atomide.com>
References: <1375775624-12250-1-git-send-email-panto@antoniou-consulting.com>
 <1375775624-12250-6-git-send-email-panto@antoniou-consulting.com>
 <20130806093356.GA27889@kroah.com>
 <8C31ED90-E9EF-4264-858A-17CC2536B552@antoniou-consulting.com>
 <20130807161557.GO7656@atomide.com>
 <4B64047B-505F-4D54-871B-8F1B5315B613@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B64047B-505F-4D54-871B-8F1B5315B613@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, =?utf-8?Q?Beno=C3=AEt?= Coussno <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Sourav Poddar <sourav.poddar@ti.com>, Russ Dill <Russ.Dill@ti.com>, Felipe Balbi <balbi@ti.com>, Koen Kooi <koen@circuitco.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [130807 09:31]:
> Hi Tony,
> 
> On Aug 7, 2013, at 7:15 PM, Tony Lindgren wrote:
> 
> > * Pantelis Antoniou <panto@antoniou-consulting.com> [130806 02:44]:
> >> On Aug 6, 2013, at 12:33 PM, Greg Kroah-Hartman wrote:
> >>> On Tue, Aug 06, 2013 at 10:53:44AM +0300, Pantelis Antoniou wrote:
> >>>> +
> >>>> static int _omap_device_notifier_call(struct notifier_block *nb,
> >>>> 				      unsigned long event, void *dev)
> >>>> {
> >>>> @@ -185,9 +211,13 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
> >>>> 	struct omap_device *od;
> >>>> 
> >>>> 	switch (event) {
> >>>> -	case BUS_NOTIFY_DEL_DEVICE:
> >>>> +	case BUS_NOTIFY_UNBOUND_DRIVER:
> >>>> +		/* NOTIFY_DEL_DEVICE is not the right call...
> >>>> +		 * we use a callback here, to make sure no-one is going to
> >>>> +		 * try to use the omap_device data after they're deleted
> >>>> +		 */
> >>>> 		if (pdev->archdata.od)
> >>>> -			omap_device_delete(pdev->archdata.od);
> >>>> +			device_schedule_callback(dev, _omap_device_cleanup);
> >>> 
> >>> Really?  This is one sign that you are totally using the driver core
> >>> incorrectly.  You shouldn't have to rely on notifier callbacks to handle
> >>> device removals, your bus code should do that for you directly.
> >>> 
> >>> I don't like this at all, sorry.
> >>> 
> >> 
> >> Don't shoot the messenger please...
> > 
> > As you're inititalizing capebus with DT, let's figure out what if
> > anything you actually need from omap_device. I'd much rather remove
> > dependencies than add more.
> > 
> 
> There is no such thing as capebus anymore. This is just the path of
> removing a platform device, which happens to also be an omap_device.

OK, so let's figure out the minimal fixes needed.
 
> >> This is all about fixing a crash without messing too many things.
> > 
> > It seems this fix is only needed for supporting out-of-tree code?
> > These features with omap_device we may not even want to support in
> > the mainline tree as is being discussed..
> > 
> 
> What out of tree code? The only thing this patch does is make sure we
> don't crash when a perfectly valid call to platform_device_unregister() happens.
> 
> Drivers that don't use omap_device work just fine.

So what's the minimal set of fixes then?

Regards,

Tony
