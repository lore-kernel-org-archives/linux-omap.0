From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 2/10] OPP layer and additional cleanups.
Date: Thu, 07 Jan 2010 18:25:10 +0530
Message-ID: <4B45D9AE.1040502@ti.com>
References: <1262266149.20175.178.camel@boson> <4B4266F3.5000501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58393 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab0AGMzR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 07:55:17 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o07CtDZB003930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 06:55:16 -0600
In-Reply-To: <4B4266F3.5000501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Menon, Nishanth wrote:
> >
> > Could you please start using git format-patch -s -M -o to generate patches?
> >
> > And you exposed struct omap_opp back to the public defeating the
> > previous work  :(

Exposing struct omap_opp is ok. In fact I need this for adding/deleting and
getting a handle on a particular OPP. My actual intent is to have the
book-keeping done only in OPP layer. Now you just need to search by saying
find_opp_by_freq(OPP_MPU, required_freq, flags /* flag will define the search
criteria */);

> >
> > mostly I like what you are trying to do here, but just not exactly what
> > you are doing  :(

Please let me know how to improvise this.

