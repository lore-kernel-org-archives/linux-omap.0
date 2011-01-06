From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Errors when building for omap4 only
Date: Thu, 6 Jan 2011 19:25:34 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248201A31@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302482019D4@dbde02.ent.ti.com>
 <568127b70200733a61aa8c358fb49292@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49880 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab1AFNzm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 08:55:42 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p06Dtd61003231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 6 Jan 2011 07:55:41 -0600
In-Reply-To: <568127b70200733a61aa8c358fb49292@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Thursday, January 06, 2011 7:19 PM
> To: Premi, Sanjeev; linux-omap Mailing List
> Subject: RE: Errors when building for omap4 only
> 
> Sanjeev,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> > Sent: Thursday, January 06, 2011 6:18 PM
> > To: linux-omap Mailing List
> > Subject: Errors when building for omap4 only
> >
> > Hi all,
> >
> > I was trying to build OMAP4 only kernel from the linux-omap master.
> > Came across few failures caused by exclusion of OMAP3/3 specific
> > code via #ifdef.
> >
> These are addressed already. You could look at below series
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41712.html
> 

Great! I missed the series.

Question (after quick browse): Don't addition stubs add too many strings to the code?

~sanjeev