From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 Video Overlay Scaling Patch
Date: Thu, 06 Aug 2009 16:38:04 +0300
Message-ID: <4A7ADCBC.9060801@nokia.com>
References: <84FF2D40FEDEB74A98203E6EA01A4E1C059446C7@de01exm63.ds.mot.com> <84FF2D40FEDEB74A98203E6EA01A4E1C059446CD@de01exm63.ds.mot.com> <84FF2D40FEDEB74A98203E6EA01A4E1C059446D0@de01exm63.ds.mot.com> <4A781627.2060405@nokia.com> <84FF2D40FEDEB74A98203E6EA01A4E1C05AA125E@de01exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31039 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbZHFNiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 09:38:14 -0400
In-Reply-To: <84FF2D40FEDEB74A98203E6EA01A4E1C05AA125E@de01exm63.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Fischer Steven-P27614 <Steven.Fischer@motorola.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

ext Fischer Steven-P27614 wrote:
> Tomi,
> 
> I tried the patch you sent and after just a little testing I'm fairly
> confident the change works just fine.  Thanks.
> 
> I couple of comments on the configure_overlay() function.  Unless I'm
> mis-understanding the code the overlay output rectangle is defined by
> the local variable "x/y/outw/outh".  I find it quite confusing that
> there are separate "w" & "h" locals, since it makes it appear as if "x"
> & "y" should be paired with "w" & "h" to make a rectangle.  Further
> more, I see "x" & "w" added together, which similarly makes them appear
> to be part of the same rectangle.  I would lightly suggest changing the
> "x" & "y" locals to "outx" and "outy", just for clarity sake.

I agree that it's confusing. Better naming making it clear what is used 
for input data and for output data would make it a bit clearer. Perhaps 
also use "inw" and "inh" to make it absolutely clear.

> 
> Also, I wonder about the code that adds "x" & "w" or even "y" & "h".
> Shouldn't that code be adding "x" & "outw" or "y" & "outh"?  Again,
> maybe I'm mis-understanding the code.
>

They are added only when w == outw, so it doesn't change the 
functionality. But you are again right, it's a bit confusing.

I remember I was at some point trying to clean up this input/output 
confusion, but I think it wasn't too simple at some points. I'll have to 
look at it again at some point.

  Tomi


> Steve.
> 
> -----Original Message-----
> From: Fischer Steven-P27614 
> Sent: Tuesday, August 04, 2009 5:22 PM
> To: 'Tomi Valkeinen'
> Cc: linux-omap@vger.kernel.org
> Subject: RE: DSS2 Video Overlay Scaling Patch
> 
> I'll try out your patch, hopefully tomorrow, and let you know.
> 
> Thanks,
> 
> Steve.
> 
> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, August 04, 2009 6:06 AM
> To: Fischer Steven-P27614
> Cc: linux-omap@vger.kernel.org
> Subject: Re: DSS2 Video Overlay Scaling Patch
> 
> Hi,
> 
> ext Fischer Steven-P27614 wrote:
>> Ugh, messed up morning, forgot the patch as well :(
>>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Fischer
>> Steven-P27614
>> Sent: Tuesday, July 07, 2009 8:05 AM
>> To: linux-omap@vger.kernel.org
>> Subject: RE: DSS2 Video Overlay Scaling Patch
>>
>> Sorry, missed the subject line.
>>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Fischer
>> Steven-P27614
>> Sent: Tuesday, July 07, 2009 7:54 AM
>> To: linux-omap@vger.kernel.org
>> Subject: 
>>
>> All,
>>  
>> The DSS2 code base seems to inadvertently prevent downscaling of video
> 
>> overlay frames.  Attached is my attempt at a patch to resolve this 
>> issue.
>>  
>> As I gather from the code, there is an attempt to limit the overlay 
>> output frame size (x, y, outw, outh) to the managers updated window 
>> (mc->x, mc->y, mc->w, mc->h).  The problem is that the input frame 
>> size (w & h) is being used to instead of the output frame size (outw,
> outh).
>> Due to this, when the input frame size is large than the output frame 
>> size, the input frame is being cropped, thus no downscaling occurs.
>> My patch corrects this issue and also attempts to properly scale the 
>> input frame size if indeed the output frame is cropped.
>>  
>> In my particular case, the output frame size is never cropped, so I 
>> have not explicitly tested these equations, but I believe they are 
>> mathematically correct.
>>  
>> With this patch overlay downscaling is functional.
>>  
> 
> It was indeed slightly broken. The code is there because we cannot use
> partial update for scaled overlays, but we need to update the whole
> overlay. Otherwise there could be visual errors on the screen.
> 
> However, your patch didn't apply to my tree, and I think it can be
> solved in slightly more clear way. If the overlay in question is scaled,
> we don't even need to run that code. All we have to do is to adjust x/y
> depending on the x/y of the update area.
> 
> Here's a patch, can you check if it works for you?
> 
>   Tomi
> 

