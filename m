From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] : Bug fix in generic runtime pm APIs
Date: Mon, 16 Aug 2010 20:54:21 +0200
Message-ID: <201008162054.21274.rjw@sisk.pl>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940270AE9715@dbde02.ent.ti.com> <4C693E82.9000503@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E940270BE1011@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45391 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575Ab0HPS4D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 14:56:03 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940270BE1011@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-pm@lists.linux-foundation.org

On Monday, August 16, 2010, Kalliguddi, Hema wrote:
> Hi,
>  
> >> -----Original Message-----
> >> From: Kalliguddi, Hema
> >> Sent: Friday, August 13, 2010 7:08 PM
> >> To: Cousson, Benoit
> >> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Kevin Hilman; 
> >Paul.Walmsley[paul@pwsan.com]
> >> Subject: RE: [PATCH] : Bug fix in generic runtime pm APIs
> >>
> >> Hi,
> >>
> >>> -----Original Message-----
> >>> From: Cousson, Benoit
> >>> Sent: Friday, August 13, 2010 6:29 PM
> >>> To: Kalliguddi, Hema
> >>> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Kevin Hilman;
> >>> Paul.Walmsley[paul@pwsan.com]
> >>> Subject: Re: [PATCH] : Bug fix in generic runtime pm APIs
> >>>
> >>> Hi Hema,
> >>>
> >>> On 8/13/2010 2:31 PM, Kalliguddi, Hema wrote:
> >>>> From: Hema HK<hemahk@ti.com>
> >>>>
> >>>> pm_generic_runtime_resume/pm_generic_runtime_suspend api
> >>> should return zero if
> >>>> driver has not implemented runtime_suspend or runtime_resume apis.
> >>>
> >>> Why? Could you elaborate?
> >>>
> >> I don't have runtime_suspend and runtime_resume APIs 
> >implemented in the usb driver.
> >> When runtime_pm_get_sync is called there is a -22 as return value.
> >
> >It is still not clear why it is related to the following patch?
> >Can you explain in what context you observe that?
> 
> Sorry. It is not related o following commit. It is related to 
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=1ebda92e47879750c739f6125ab11632a8f6f713
> 
> In this pm_generic_runtime_resume() API returns -EINVAL if there is no 
> runtime_resume and runtime_suspend APIs implemented by driver.
> 
> I observe this issue when I call runtime_pm_get_sync api in the driver and check for the return value.
> The return value is -22 because there is no runtime_resume API implemented in the USB driver.
> 
> >
> >> Is not it is valid if there is no runtime_suspend and 
> >runtime_resume implemented by drivers/device?
> >> Why should this API returns -EINVAL if there is no 
> >runtime_resume and runtime_suspend APIs ?
> >
> >Good question, you should maybe ask the original author, who is Rafael.
> >
> 
> Rafael,
> 
> Is it mandatory to implement the runtime_suspend and runtime_resume APIs in the driver
> even if there is nothing to done in the APIs?

That depends on the bus type routines.  If your bus type uses the generic
ones then yes, it is.

Thanks,
Rafael
