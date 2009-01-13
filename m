From: "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>
Subject: Re: [REVIEW PATCH 08/14] OMAP: CAM: Add ISP Core
Date: Tue, 13 Jan 2009 10:16:08 +0200
Message-ID: <200901131016.09247.tuukka.o.toivonen@nokia.com>
References: <A24693684029E5489D1D202277BE894416429BCC@dlee02.ent.ti.com> <200901130834.16645.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59012 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbZAMIQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 03:16:26 -0500
In-Reply-To: <200901130834.16645.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hans Verkuil <hverkuil@xs4all.nl>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>

On Tuesday 13 January 2009 09:34:16 ext Hans Verkuil wrote:
> second entry rather than the third. There are more devices that can 
> choose between color and B&W, but this is the first device I know of 
> that can do sepia. Having B&W as the second entry makes it easier for 

Actually OMAP3 ISP can do pretty much arbitrary matrix operations
on colors, so normal, B&W, and sepia and very special cases. :)

> > > > +#ifdef TERM_RESISTOR
> > >
> > > What is this define? It doesn't seem to be documented.
> >
> > This define is to enable/disable an OMAP34xx internal resistor for
> > CSIb (CCP2) camera port.
> >
> > A comment along its declaration should be enough?
> 
> Yes. But shouldn't this be a module option, perhaps? Up to you, I'm just 
> wondering.

Rather it should be somehow specified in board file. When one connects
camera module to the OMAP3, he can choose to either use OMAP3 internal
resistor (and specify its strength), or solder an external resistor
on the CCP2 bus. Machine specific board file should specify how the camera
module is connected to the camera port, thus it should describe
what kind of OMAP3 internal resistor is required.

- Tuukka
