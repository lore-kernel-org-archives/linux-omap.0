From: Patrick Radius <info@notoyota.nl>
Subject: Re: OMAP 3430 Camera/ISP out of memory error
Date: Fri, 25 Mar 2011 20:01:33 +0100
Message-ID: <1301079693.25083.8.camel@kaas>
References: <1301050377.25083.2.camel@kaas>
	 <4D8C7B62.9010701@maxwell.research.nokia.com>
	 <1301052893.25083.3.camel@kaas>
	 <BANLkTik5MCZXWT5mAeAyL8Uh5eGE85-Ynw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64062 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1CYTCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 15:02:05 -0400
Received: by wya21 with SMTP id 21so1364713wya.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 12:02:04 -0700 (PDT)
In-Reply-To: <BANLkTik5MCZXWT5mAeAyL8Uh5eGE85-Ynw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: linux-omap@vger.kernel.org

Thanks,

I'm looking at
http://gitorious.org/linux-omap/mainline/trees/master/drivers/media/video

however, I can't seem to find the drivers I need.
I only see omap24xxcam while I was using the omap34xxcam from Linux
kernel 2.6.32.9.
And I also don't see any M-4MO driver anymore.
I'm probably looking at the wrong spot, but...

As you can tell, I'm fairly new with OMAP programming.

Thanks!

Regards,
Patrick

On vr, 2011-03-25 at 16:34 +0200, David Cohen wrote:
> Hi,
> 
> On Fri, Mar 25, 2011 at 1:34 PM, Patrick Radius <info@notoyota.nl> wrote:
> > Ok, thanks!
> > However, I'm also quite curious about peoples thoughts about it from
> > here.
> > Since I think what's happing is quite OMAP specific.
> > For example, I was wondering where omap34xxcam.c gets it's memory it
> > should allocate from.
> > Is it the 'main' memory? Or does it share memory with a framebuffer
> > (overlay)? Or memory from the (M-4MO) sensor?
> > Is it possible I should allocate memory for it as boot argument? similar
> > like vmem=16M omapfb.vram=0:8M
> >
> > I can't find much information about this all...
> 
> You're using an old version of the driver. Please, use the newer one
> available in mainline.
> 
> Regards,
> 
> David Cohen
> 
> >
> > On vr, 2011-03-25 at 13:24 +0200, Sakari Ailus wrote:
> >> Patrick Radius wrote:
> >> > Hi,
> >>
> >> Hi Patrick,
> >>
> >> I think this question will get better answered in the linux-media list.
> >> Cc it.
> >>
> >> > i'm trying to get camera support working on a relatively new Android
> >> > port to an OMAP 3430 based phone (Samsung GT-i8320 a.k.a. Samsung H1).
> >> > However calls to VIDIOC_REQBUFS fail with a -12 (OUT OF MEMORY).
> >> > As far as I can see this return error isn't even supposed to exist,
> >> > according to the V4L2 spec.
> >> > I'm using the code from Android on the Zoom2.
> >> > The sensor is a Fujitsu M-4MO.
> >> >
> >> > Any ideas on what could be wrong with the out of memory result?
> >>
> >> First of all, which version of the driver are you using, i.e. is it the
> >> current one going to upstream?
> >>
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


