From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/2] Added board-3630.c file.
Date: Wed, 28 Oct 2009 17:10:36 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AD6DA01@dlee02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0C012AC22851@dlee02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE1C8@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA36ED28@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AD6D92C@dlee02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA36ED5A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37763 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875AbZJ1WKe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 18:10:34 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9SMAcH8013546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 17:10:38 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9SMAcqT006839
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 17:10:38 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9SMAc6w008299
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 17:10:38 -0500 (CDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA36ED5A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Taliaferro, Steve" <staliaferro@ti.com>


> From: Pandita, Vikram
> Sent: Wednesday, October 28, 2009 11:39 PM
[...]
> I was making that list already. Good to see you thinking on same lines.
> However your list does not match with mine and I tried to confirm the
> changes looking at h/w.
Thanks for correcting my list.. it was mostly off the top of my head list..

> Here is the list, in the order of impact:
> 
> 
> Peripheral    zoom2    zoom3    sdp3630
> Ethernet	  A		A	  B **(may not be same)
> NOR		  n/a	     n/a	  B ** different
> Onenand	  n/a	     n/a	  B ** diffferent
> HDMI          A         A       B **(Need to verify: not there on i2c3)
> NAND          A         A       A (same nand)
> SDRAM         A         A       A (same sdram)
Correction      A         B       B (sdram is now 512Meg)

> Keypad        A         A       A (same twl)
> Camera        A         A       A (same sensor can be mounted: can check
> further)
> LCD Display   A         A       A (same wvga display)
> Power         A         A       A (same chip level)
> Audio         A         A       A (its the same)
> Voltage resources??			(not sure what you mean?)
Vaux resources etc... mostly deltas in terms of which twl resource drives what device.. are the maps exactly the same? Are the power scripts for suspend/resume/reset etc the same?

> LEDs          A         A       B (LEDs are board specific, can reside in
> separate board file)
> OPPs          A         A       A (same chip feature)
> 
> 
[...]


Regards,
Nishanth Menon
