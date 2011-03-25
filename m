From: Patrick Radius <info@notoyota.nl>
Subject: Re: OMAP 3430 Camera/ISP out of memory error
Date: Fri, 25 Mar 2011 12:34:53 +0100
Message-ID: <1301052893.25083.3.camel@kaas>
References: <1301050377.25083.2.camel@kaas>
	 <4D8C7B62.9010701@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59834 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab1CYLfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 07:35:22 -0400
Received: by wya21 with SMTP id 21so1016032wya.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 04:35:21 -0700 (PDT)
In-Reply-To: <4D8C7B62.9010701@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Ok, thanks!
However, I'm also quite curious about peoples thoughts about it from
here.
Since I think what's happing is quite OMAP specific.
For example, I was wondering where omap34xxcam.c gets it's memory it
should allocate from.
Is it the 'main' memory? Or does it share memory with a framebuffer
(overlay)? Or memory from the (M-4MO) sensor?
Is it possible I should allocate memory for it as boot argument? similar
like vmem=16M omapfb.vram=0:8M

I can't find much information about this all...

On vr, 2011-03-25 at 13:24 +0200, Sakari Ailus wrote:
> Patrick Radius wrote:
> > Hi,
> 
> Hi Patrick,
> 
> I think this question will get better answered in the linux-media list.
> Cc it.
> 
> > i'm trying to get camera support working on a relatively new Android
> > port to an OMAP 3430 based phone (Samsung GT-i8320 a.k.a. Samsung H1).
> > However calls to VIDIOC_REQBUFS fail with a -12 (OUT OF MEMORY).
> > As far as I can see this return error isn't even supposed to exist,
> > according to the V4L2 spec.
> > I'm using the code from Android on the Zoom2.
> > The sensor is a Fujitsu M-4MO.
> > 
> > Any ideas on what could be wrong with the out of memory result?
> 
> First of all, which version of the driver are you using, i.e. is it the
> current one going to upstream?
> 


