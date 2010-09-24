From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: Query on clock naming conventions in clockxxxx_data.c
Date: Fri, 24 Sep 2010 08:40:42 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E5F6223DA@dlee03.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870311A2F3F2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33414 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab0IXNkm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 09:40:42 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8ODegi6016607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 08:40:42 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o8ODefp7015923
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 08:40:41 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8ODefII001735
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 08:40:41 -0500 (CDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870311A2F3F2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

Archit,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Taneja, Archit
> Sent: Friday, September 24, 2010 7:41 AM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Guruswamy, Senthilvadivu
> Subject: Query on clock naming conventions in clockxxxx_data.c
> 
> Hi,
> 
> I had a couple of queries regarding the clock structures in the
> clockxxxx_data.c files:
> 
> -I have seen that the name of the structure itself explains the name of
> the clock as
> given in the TRM.
> -The member "name" also tries to mimic the clock name.
> 
> The drivers get the clock struct using the "name" member in the clk_get()
> api. Is it
> okay if we can change the "name" member to a more generic string. So that
> the driver
> code stays more generic?
> 
> For example, the SYS_CLK which comes into DSS is called "dss2_alwon_fck"
> on omap3 and
> "dss_sys_clk" on omap4. This will make our driver need to have cpu_is_omap
> checks while
> calling clk_get().
> 

I guess migrating to hwmod should resolve the issue you mentioned.

Thank you,
Best regards,
Hari
