From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Wed, 15 Jul 2009 17:31:38 -0500
Message-ID: <4A5E58CA.3030206@ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AFE@dlee06.ent.ti.com> <4A5D136D.8030701@ti.com> <CD8CC2B65FEE304DA95744A5472698F202957C7C3A@dlee06.ent.ti.com> <4A5E4D7A.6010706@ti.com> <CD8CC2B65FEE304DA95744A5472698F202957C7DB5@dlee06.ent.ti.com> <4A5E57C5.6000600@ti.com> <CD8CC2B65FEE304DA95744A5472698F202957C7DB9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53918 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477AbZGOWbp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jul 2009 18:31:45 -0400
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202957C7DB9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Sonasath, Moiz had written, on 07/15/2009 05:29 PM, the following:
> 
> I am also not sure, if the count=100; value will be enough time for the XUDF
 > to be set. If not then it will keep running into timeout errors.
> 
Do you mean we need a delay for checking again? that should be easy to 
incorporate - what kind of delay are we speaking of here? do you have a 
count requirement for handling this? it is essentially the time b/w XRDY 
to XUNDF.. this should be deterministic rt?

Regards,
Nishanth Menon
