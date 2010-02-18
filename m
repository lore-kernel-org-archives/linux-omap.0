From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: RE: Patch[0/2]:DSPBRIDGE: Excessive u32 Cleanup
Date: Fri, 19 Feb 2010 01:40:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044D71B420@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044D71B418@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C0130EBC2DF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45992 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758442Ab0BRUKJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 15:10:09 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1IKA42k018207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 14:10:07 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o1IKA3Q4001970
	for <linux-omap@vger.kernel.org>; Fri, 19 Feb 2010 01:40:03 +0530 (IST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C0130EBC2DF@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, February 18, 2010 1:47 PM
> To: Hebbar, Shivananda; linux-omap
> Subject: RE: Patch[0/2]:DSPBRIDGE: Excessive u32 Cleanup
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap- 
> > owner@vger.kernel.org] On Behalf Of Hebbar, Shivananda
> > Sent: Thursday, February 18, 2010 9:24 PM
> > To: linux-omap
> > Subject: Patch[0/2]:DSPBRIDGE: Excessive u32 Cleanup
> > 
> > These patches remove excessive u32 type and replaces it with the 
> > Normal C types.
> What is the motivation of this change?

Sometime back ,there was comment on excessive u32ypes used in bridge.

http://marc.info/?l=linux-omap&m=123998339213416&w=2

> > 
> > Shivananda Hebbar (2)
> > 
> > DSPBRIDGE: Excessive u32 Cleanup (u32->short int)
> You are changing the signedness a) u16 might be a better 
> option here. b) it might be enough to use short.
> 
> > DSPBRIDGE: Excessive u32 Cleanup (u32->int)
> Why is this needed? u32 is a standard kernel usage and you 
> are changing the signedness of it's usage
> 
>  [...]

--Shivananda
> 
> 