From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: Patch[0/2]:DSPBRIDGE: Excessive u32 Cleanup
Date: Thu, 18 Feb 2010 13:46:31 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0130EBC2DF@dlee02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044D71B418@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47303 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041Ab0BRTqe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 14:46:34 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1IJkXoi001894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 13:46:33 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o1IJkXZj011393
	for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 13:46:33 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o1IJkXuu001430
	for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 13:46:33 -0600 (CST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044D71B418@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hebbar, Shivananda
> Sent: Thursday, February 18, 2010 9:24 PM
> To: linux-omap
> Subject: Patch[0/2]:DSPBRIDGE: Excessive u32 Cleanup
> 
> These patches remove excessive u32 type and replaces it with the Normal C
> types.
What is the motivation of this change?
> 
> Shivananda Hebbar (2)
> 
> DSPBRIDGE: Excessive u32 Cleanup (u32->short int)
You are changing the signedness a) u16 might be a better option here. b) it might be enough to use short.

> DSPBRIDGE: Excessive u32 Cleanup (u32->int)
Why is this needed? u32 is a standard kernel usage and you are changing the signedness of it's usage.

 [...]
Regards,
Nishanth Menon

