From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] Common mechanism to identify Si revision
Date: Wed, 23 Sep 2009 09:50:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDA2CB44@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD60FFF2@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0909100325360.3024@utopia.booyaka.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD7D0D97@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0909190840190.15679@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56056 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbZIWEUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 00:20:53 -0400
In-Reply-To: <alpine.DEB.2.00.0909190840190.15679@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Saturday, September 19, 2009 8:12 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [RFC] Common mechanism to identify Si revision
> 
> 
> Hello Sanjeev,
> 
> another question.  I have heard that on OMAP4, some chip 
> versions will not 
> be identified with an ES revision number.  How to handle those?

I am not aware of OMAP4 plans. I believe there *has* to be a mechanism - though possibly not as simple as reading specific bit pattern to makeout differences. This can be used to update a "soft ES" version in the omap_revision.

~sanjeev

> 
> 
> - Paul
> 
> 