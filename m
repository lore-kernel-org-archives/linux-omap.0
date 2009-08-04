From: "Fischer Steven-P27614" <Steven.Fischer@motorola.com>
Subject: RE: DSS2 Video Overlay Scaling Patch
Date: Tue, 4 Aug 2009 18:22:08 -0400
Message-ID: <84FF2D40FEDEB74A98203E6EA01A4E1C05AA1023@de01exm63.ds.mot.com>
References: <84FF2D40FEDEB74A98203E6EA01A4E1C059446C7@de01exm63.ds.mot.com> <84FF2D40FEDEB74A98203E6EA01A4E1C059446CD@de01exm63.ds.mot.com> <84FF2D40FEDEB74A98203E6EA01A4E1C059446D0@de01exm63.ds.mot.com> <4A781627.2060405@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail128.messagelabs.com ([216.82.250.131]:18501 "EHLO
	mail128.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933461AbZHDWWa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 18:22:30 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id n74MMUGo000182
	for <linux-omap@vger.kernel.org>; Tue, 4 Aug 2009 15:22:30 -0700 (MST)
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n74MMUN6012725
	for <linux-omap@vger.kernel.org>; Tue, 4 Aug 2009 17:22:30 -0500 (CDT)
Received: from de01exm63.ds.mot.com (de01exm63.am.mot.com [10.176.8.108])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n74MMUCf012721
	for <linux-omap@vger.kernel.org>; Tue, 4 Aug 2009 17:22:30 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <4A781627.2060405@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

I'll try out your patch, hopefully tomorrow, and let you know.

Thanks,

Steve.

-----Original Message-----
From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] 
Sent: Tuesday, August 04, 2009 6:06 AM
To: Fischer Steven-P27614
Cc: linux-omap@vger.kernel.org
Subject: Re: DSS2 Video Overlay Scaling Patch

Hi,

ext Fischer Steven-P27614 wrote:
> Ugh, messed up morning, forgot the patch as well :(
> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Fischer
> Steven-P27614
> Sent: Tuesday, July 07, 2009 8:05 AM
> To: linux-omap@vger.kernel.org
> Subject: RE: DSS2 Video Overlay Scaling Patch
> 
> Sorry, missed the subject line.
> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Fischer
> Steven-P27614
> Sent: Tuesday, July 07, 2009 7:54 AM
> To: linux-omap@vger.kernel.org
> Subject: 
> 
> All,
>  
> The DSS2 code base seems to inadvertently prevent downscaling of video

> overlay frames.  Attached is my attempt at a patch to resolve this 
> issue.
>  
> As I gather from the code, there is an attempt to limit the overlay 
> output frame size (x, y, outw, outh) to the managers updated window 
> (mc->x, mc->y, mc->w, mc->h).  The problem is that the input frame 
> size (w & h) is being used to instead of the output frame size (outw,
outh).
> Due to this, when the input frame size is large than the output frame 
> size, the input frame is being cropped, thus no downscaling occurs.  
> My patch corrects this issue and also attempts to properly scale the 
> input frame size if indeed the output frame is cropped.
>  
> In my particular case, the output frame size is never cropped, so I 
> have not explicitly tested these equations, but I believe they are 
> mathematically correct.
>  
> With this patch overlay downscaling is functional.
>  

It was indeed slightly broken. The code is there because we cannot use
partial update for scaled overlays, but we need to update the whole
overlay. Otherwise there could be visual errors on the screen.

However, your patch didn't apply to my tree, and I think it can be
solved in slightly more clear way. If the overlay in question is scaled,
we don't even need to run that code. All we have to do is to adjust x/y
depending on the x/y of the update area.

Here's a patch, can you check if it works for you?

  Tomi

