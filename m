From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: USB and SD performance issue
Date: Tue, 3 Feb 2009 17:07:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02F542051E@dbde02.ent.ti.com>
References: <780A8A94-6815-4EB3-9303-FBF79F65510A@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37138 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbZBCLhi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 06:37:38 -0500
In-Reply-To: <780A8A94-6815-4EB3-9303-FBF79F65510A@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, Remith Ravi <remith@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Tuesday, February 03, 2009 5:05 PM
> To: Remith Ravi
> Cc: linux-omap@vger.kernel.org
> Subject: Re: USB and SD performance issue
> 
> 
> Op 3 feb 2009, om 12:16 heeft Remith Ravi het volgende geschreven:
> 
> > Hello,
> >
> > Recently I have done a performance comparison of OMAP3 'USB 
> OTG Host'
> > and 'SD' drivers on different Linux Kernels.
> > The performance of latest git kernel is less comparing to 
> 2.6.22 TI  
> > kernel.
> > Could some one please explain me what cause this performance  
> > difference?
> >
> > The performance is calculated by doing data transfer between RAM and
> > the storage device (using 'time' command).
> >
> > The performance details are given below.
> >
> > 1) 2.6.29-rc2 kernel
> > USB OTG (Host)         Read (4.2 MB/s)		Write 
> (2.6 MB/s)	
> > SD Card                     Read (3.88 MB/s)		
> Write (3.1 MB/s)
> >
> > 2) 2.6.28 kernel
> > USB OTG (Host)         error		                error	
> > SD Card                     Read  (4.2 MB/s)		
> Write (3.27 MB/s)
> >
> > 3) 2.6.22 TI kernel
> > USB OTG (Host)         Read (5.4MB/s)		Write 
> (6.14MB/s)	
> > SD Card                      Read (6.7MB/s)		Write (6.43MB/s)
> 
> I get this with 2.6.28:
> 
> root@omap3evm:~# hdparm -t /dev/mmcblk0
> /dev/mmcblk0:
>   Timing buffered disk reads:   42 MB in  3.10 seconds =  13.53 MB/sec
> 
> root@beagleboard:~# hdparm -t /dev/mmcblk0
> /dev/mmcblk0:
>   Timing buffered disk reads:   44 MB in  3.13 seconds =  14.04 MB/sec
> 
> regards,
> 
> Koen
> 

What does `hdparm -tT /dev/mmcblk0` give?

- Anand
