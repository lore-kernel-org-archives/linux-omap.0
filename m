From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH] OMAP3: PM: 2 new entries in SDRC table for Qimonda
 HYB18M512160AF-6
Date: Thu, 4 Jun 2009 17:26:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030587250F@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0906021834050.31531@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60136 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbZFDL4y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 07:56:54 -0400
In-Reply-To: <alpine.DEB.2.00.0906021834050.31531@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ok.. thanks. I just saw this missing in the PM branch and
hence posted this. 

>-----Original Message-----
>From: Paul Walmsley [mailto:paul@pwsan.com] 
>Sent: Wednesday, June 03, 2009 6:06 AM
>To: Nayak, Rajendra
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] OMAP3: PM: 2 new entries in SDRC table 
>for Qimonda HYB18M512160AF-6
>
>Hello Rajendra,
>
>On Mon, 1 Jun 2009, Rajendra Nayak wrote:
>
>> This patch adds 2 more entries for new SDRC clock rates
>> (166000000 and 83000000) in the sdrc params table for
>> Qimonda HYB18M512160AF-6 sdram part.
>> Without this CORE dvfs is broken on the 3430SDP as
>> omap2_sdrc_get_params() call in the dvfs sequence
>> always return 'rate not found'
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
>Commit ID c82881eac1c6999abd768c548ad196c1973d3a55 on l-o master has 
>resolved this.
>
>
>- Paul
>
>