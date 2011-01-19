From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: Add basic support for 720MHz part
Date: Wed, 19 Jan 2011 15:49:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024847405A@dbde02.ent.ti.com>
References: <1295336995-15831-1-git-send-email-premi@ti.com>
 <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net>
 <4D35C47D.6000102@ti.com> <b8bd13a9f9b383c7db6af63e1aa984be@mail.gmail.com>
 <4F6B1267-93B8-4698-9880-376076825598@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40131 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab1ASKTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 05:19:14 -0500
In-Reply-To: <4F6B1267-93B8-4698-9880-376076825598@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, l-o List <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Koen Kooi [mailto:koen@dominion.thruhere.net] 
> Sent: Tuesday, January 18, 2011 11:47 PM
> To: Sripathy, Vishwanath
> Cc: Menon, Nishanth; Premi, Sanjeev; l-o List; Gopinath, Thara
> Subject: Re: [PATCH] omap3: Add basic support for 720MHz part

[snip]...[snip]

> The TRM[1] chickens out with the OPP definitions:

Refer to page 122 of the OMAP3503 datasheet for the OPP definitions:
http://www.ti.com/litv/pdf/sprs505f

The nominal voltage for both (VDD1) OPP5 and OPP6 is 1.35V.

~sanjeev
