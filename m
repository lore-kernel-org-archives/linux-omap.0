From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Mon, 7 Mar 2011 20:50:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C0E5D33@dbde02.ent.ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
 <1298483913-20344-4-git-send-email-premi@ti.com>
 <6356620acee7ee78af7da3906b0ea78a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49600 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab1CGPUu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 10:20:50 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p27FKliF006761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 09:20:49 -0600
In-Reply-To: <6356620acee7ee78af7da3906b0ea78a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Sripathy, Vishwanath
> Sent: Thursday, February 24, 2011 3:35 PM
> To: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: RE: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
> 
> Sanjeev,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Sanjeev Premi
> > Sent: Wednesday, February 23, 2011 11:29 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Sanjeev Premi
> > Subject: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
> >
> > Add glue logic to hook-up AM35x processors
> > with TPS65023.
> It seems that you are not really using Voltage layer for any interaction
> with TPS65023 as you are not using VP and VC. Then what is the purpose of
> registering this PMIC with Voltage layer. I fail to understand the purpose
> of this patch series.

[sp] Then, can you suggest how do I get the AM35x EVM to boot? Given the
     current limitation of all voltage related data being "extracted" from
     the voltage layer - which expects only TWLx0y0 PMICs.

> 
> Vishwa
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>

