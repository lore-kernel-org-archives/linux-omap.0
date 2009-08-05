From: "Fischer Steven-P27614" <Steven.Fischer@motorola.com>
Subject: RE: DSS2 Video Overlay Scaling Patch
Date: Wed, 5 Aug 2009 15:09:56 -0400
Message-ID: <84FF2D40FEDEB74A98203E6EA01A4E1C05AA125E@de01exm63.ds.mot.com>
References: <84FF2D40FEDEB74A98203E6EA01A4E1C059446C7@de01exm63.ds.mot.com> <84FF2D40FEDEB74A98203E6EA01A4E1C059446CD@de01exm63.ds.mot.com> <84FF2D40FEDEB74A98203E6EA01A4E1C059446D0@de01exm63.ds.mot.com> <4A781627.2060405@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail128.messagelabs.com ([216.82.250.131]:59940 "EHLO
	mail128.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZHETKS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 15:10:18 -0400
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n75JAI5W018218
	for <linux-omap@vger.kernel.org>; Wed, 5 Aug 2009 12:10:18 -0700 (MST)
Received: from il06vts02.mot.com (il06vts02.mot.com [129.188.137.142])
	by il06exr04.mot.com (8.13.1/Vontu) with SMTP id n75JAIXF024908
	for <linux-omap@vger.kernel.org>; Wed, 5 Aug 2009 14:10:18 -0500 (CDT)
Received: from de01exm63.ds.mot.com (de01exm63.am.mot.com [10.176.8.108])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id n75JAI8S024905
	for <linux-omap@vger.kernel.org>; Wed, 5 Aug 2009 14:10:18 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fischer Steven-P27614 <Steven.Fischer@motorola.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

Tomi,

I tried the patch you sent and after just a little testing I'm fairly
confident the change works just fine.  Thanks.

I couple of comments on the configure_overlay() function.  Unless I'm
mis-understanding the code the overlay output rectangle is defined by
the local variable "x/y/outw/outh".  I find it quite confusing that
there are separate "w" & "h" locals, since it makes it appear as if "x"
& "y" should be paired with "w" & "h" to make a rectangle.  Further
more, I see "x" & "w" added together, which similarly makes them appear
to be part of the same rectangle.  I would lightly suggest changing the
"x" & "y" locals to "outx" and "outy", just for clarity sake.

Also, I wonder about the code that adds "x" & "w" or even "y" & "h".
Shouldn't that code be adding "x" & "outw" or "y" & "outh"?  Again,
maybe I'm mis-understanding the code.

Steve.

-----Original Message-----
From: Fischer Steven-P27614 
Sent: Tuesday, August 04, 2009 5:22 PM
To: 'Tomi Valkeinen'
Cc: linux-omap@vger.kernel.org
Subject: RE: DSS2 Video Overlay Scaling Patch

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

