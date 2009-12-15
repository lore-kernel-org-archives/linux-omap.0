From: "Lohithakshan, Ranjith" <ranjithl@ti.com>
Subject: RE: [PATCH v2] AM35xx: Clock table updates for AM3505/17
Date: Tue, 15 Dec 2009 09:20:08 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC240189@dbde02.ent.ti.com>
References: <1258437308-29289-1-git-send-email-ranjithl@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BC14218A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0912141307330.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45287 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbZLODuR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 22:50:17 -0500
In-Reply-To: <alpine.DEB.2.00.0912141307330.12561@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "tony@atomide.com" <tony@atomide.com>

Thanks Paul.

I will test these on AM3517 EVM and let you know the results.

 - Ranjith 

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Tuesday, December 15, 2009 1:42 AM
> To: Lohithakshan, Ranjith
> Cc: linux-omap@vger.kernel.org; Sripathy, Vishwanath; tony@atomide.com
> Subject: RE: [PATCH v2] AM35xx: Clock table updates for AM3505/17
> 
> Hi Ranjith,
> 
> I regret the delay -
> 
> On Mon, 14 Dec 2009, Lohithakshan, Ranjith wrote:
> 
> > Where does this patch stand in your queue? If there are no 
> further comments,
> > can this one be taken up on for-next?
> 
> I've updated this patch for the new .33 clock file layout.  
> The job needed 
> to be done by hand, and I don't have a Sitara board, so, 
> could you test 
> the updated patches out?  If they work okay for you, and are 
> aligned with 
> what Vishwanath needs for 36xx, then I will queue them for 
> the .34 merge 
> window.
> 
> 
> - Paul
> 