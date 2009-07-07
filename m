From: "Fischer Steven-P27614" <Steven.Fischer@motorola.com>
Subject: RE: DSS2 Video Overlay Scaling Patch
Date: Tue, 7 Jul 2009 09:04:35 -0400
Message-ID: <84FF2D40FEDEB74A98203E6EA01A4E1C059446CD@de01exm63.ds.mot.com>
References: <84FF2D40FEDEB74A98203E6EA01A4E1C059446C7@de01exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:32772 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118AbZGGNE4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 09:04:56 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate5.mot.com (8.14.3/8.14.3) with ESMTP id n67D4wZH016196
	for <linux-omap@vger.kernel.org>; Tue, 7 Jul 2009 06:04:58 -0700 (MST)
Received: from az10vts04.mot.com (il27vts04.cig.mot.com [10.17.196.88])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n67D4wVQ004908
	for <linux-omap@vger.kernel.org>; Tue, 7 Jul 2009 08:04:58 -0500 (CDT)
Received: from de01exm63.ds.mot.com (de01exm63.am.mot.com [10.176.8.108])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n67D4vjD004894
	for <linux-omap@vger.kernel.org>; Tue, 7 Jul 2009 08:04:58 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <84FF2D40FEDEB74A98203E6EA01A4E1C059446C7@de01exm63.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Sorry, missed the subject line.

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Fischer
Steven-P27614
Sent: Tuesday, July 07, 2009 7:54 AM
To: linux-omap@vger.kernel.org
Subject: 

All,
 
The DSS2 code base seems to inadvertently prevent downscaling of video
overlay frames.  Attached is my attempt at a patch to resolve this
issue.
 
As I gather from the code, there is an attempt to limit the overlay
output frame size (x, y, outw, outh) to the managers updated window
(mc->x, mc->y, mc->w, mc->h).  The problem is that the input frame size
(w & h) is being used to instead of the output frame size (outw, outh).
Due to this, when the input frame size is large than the output frame
size, the input frame is being cropped, thus no downscaling occurs.  My
patch corrects this issue and also attempts to properly scale the input
frame size if indeed the output frame is cropped.
 
In my particular case, the output frame size is never cropped, so I have
not explicitly tested these equations, but I believe they are
mathematically correct.
 
With this patch overlay downscaling is functional.
 
Steve.
