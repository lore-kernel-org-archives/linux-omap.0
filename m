From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [RFCv2 2/2] AM35x: voltage: Basic initialization
Date: Thu, 17 Mar 2011 14:12:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103171410320.16852@utopia.booyaka.com>
References: <1300260723-19422-1-git-send-email-premi@ti.com> <1300260723-19422-3-git-send-email-premi@ti.com> <bde3ae98096e759b8baae09ffbe7c226@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024C308046@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C308088@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55558 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab1CQUMY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Mar 2011 16:12:24 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C308088@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, khilman@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Thu, 17 Mar 2011, Premi, Sanjeev wrote:

> >      The things, however, get stuck in HWMOD again when the parent of
> 
> [sp] Being more specific:
>      The parent here refers to "parent" vdd i.e. "vdd_name".
> 
> ~sanjeev
> 
> >      omap3xxx_l3_main_hwmod is set as "core". Changing this causes
> >      another cascade of changes leading to almost duplicating 
> > the complete
> >      hwmod structure for AM35x.

There shouldn't be any vdd_name entries set in the hwmod data.  That 
struct omap_hwmod field will be removed.

Instead, voltage domain data should be associated with the powerdomain.  

Kevin has patches for some of this forthcoming.


- Paul
