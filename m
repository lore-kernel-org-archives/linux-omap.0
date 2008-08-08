From: David Brownell <david-b@pacbell.net>
Subject: Re: HS USB errors on OMAP3530
Date: Thu, 7 Aug 2008 19:25:48 -0700
Message-ID: <200808071925.48816.david-b@pacbell.net>
References: <1f11a5490808071135i3ac8e5dfl4076c21c5296d254@mail.gmail.com> <200808071238.30983.david-b@pacbell.net> <1f11a5490808071823w49964e5l3be66767a8383228@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:46839 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755233AbYHHCZu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 22:25:50 -0400
In-Reply-To: <1f11a5490808071823w49964e5l3be66767a8383228@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: linux-omap@vger.kernel.org

On Thursday 07 August 2008, Ashwin Bihari wrote:
> I did use a Total Phase Beagle 480USB protocol analyzer when this
> issue first manifested, but there is nothing that jumped out at me as
> a possible error or glitch. It just looks like the transactions just
> stopped mid-way without any rhyme or reason.

Why don't you post such a log, ideally with matching Linux kernel
log data.  Maybe something would jump out to other folk.  :)


> I've noticed this issue with a couple of HS flash drives, as well as,
> a FS CD-ROM drive.
> 
> Would the "let SET_ADDRESS settle" change only affect the initial
> detection? My initial insertion of device works great,

Good.


> the errors I 
> showed are after I do a read of a large amount of data from the Flash
> drive and essentially wedge something in the USB stream.

What I'd like to establish is whether this is a case of the flash
drive flaking out (that does happen on low end hardware!) or else
there's something wrong on the Linux side.

- Dave

