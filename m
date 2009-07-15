From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Wed, 15 Jul 2009 17:37:46 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202957C7DBD@dlee06.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AFE@dlee06.ent.ti.com>
 <4A5D136D.8030701@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202957C7C3A@dlee06.ent.ti.com>
 <4A5E4D7A.6010706@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202957C7DB5@dlee06.ent.ti.com>
 <4A5E57C5.6000600@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202957C7DB9@dlee06.ent.ti.com>
 <4A5E58CA.3030206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42111 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963AbZGOWht convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 18:37:49 -0400
In-Reply-To: <4A5E58CA.3030206@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Nishant,

AFAIK, the time between XRDY/XDR and setting of XUDF bit is not deterministic, it depends on the I2C bus speed but I am not sure if we can translate the speed into a fixed count number which we can use as a timeout limit. In that case we need to make a balanced assumption of the count value so that we don't fall in the timeout case under normal operation.

May be someone can give a pointer here.

Regards
Moiz Sonasath


-----Original Message-----
From: Menon, Nishanth 
Sent: Wednesday, July 15, 2009 5:32 PM
To: Sonasath, Moiz
Cc: linux-omap@vger.kernel.org; Kamat, Nishant; Paul Walmsley; Pandita, Vikram
Subject: Re: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153

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
