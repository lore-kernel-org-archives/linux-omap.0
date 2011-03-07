From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: FEATURES: DSI PLL parameter cleanup
Date: Mon, 7 Mar 2011 11:55:02 +0200
Message-ID: <1299491702.2281.152.camel@deskari>
References: <1299236625-1057-1-git-send-email-archit@ti.com>
	 <1299484471.2281.50.camel@deskari>  <4D74A2BF.3050908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32907 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533Ab1CGJzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 04:55:07 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p279t7Hq000672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 03:55:07 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p279t6Da029165
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 03:55:06 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p279t6XP027417
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 03:55:06 -0600 (CST)
In-Reply-To: <4D74A2BF.3050908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-03-07 at 03:17 -0600, Taneja, Archit wrote:
> Hi,
> 
> On Monday 07 March 2011 01:24 PM, Valkeinen, Tomi wrote:
> > On Fri, 2011-03-04 at 05:03 -0600, Taneja, Archit wrote:
> >> The DSI PLL parameters (regm, regn, regm_dispc, regm_dsi, fint) have different
> >> fields and also different Max values on OMAP3 and OMAP4. Use dss features to
> >> calculate the register fields and Max values based on current OMAP revision
> >>
> >> Also, introduce a new function in dss_features "dss_feat_get_param_range" which
> >> returns the maximum and minimum values supported by the parameter for
> >> the current OMAP revision.
> >
> > See comment about "also" in the last mail =). You are introducing a new
> > kind of dss feature as a sidenote. I think it should clearly be a
> > separate patch.
> >
> > <snip>
> >
> >> +void dss_feat_get_param_range(enum dss_range_param param, int *min, int *max)
> >> +{
> >> +	*min = omap_current_dss_features->dss_params[param].min;
> >> +	*max = omap_current_dss_features->dss_params[param].max;
> >
> > This isn't right. Here you're using the param as index, but in the param
> > array itself the param is just part of the struct. So it's just luck
> > that the index is correct.
> 
> The param part of the struct is just for readability, and possibly more 
> thorough checking for later on.
> 
> The index isn't correct by luck, its mainly because during defining the 
> array, we fill it up in the sequence in which the enum is defined.

Well, by reading the code nothing tells the reader that the ordering is
important, he has to guess it. One could easily add a new item in wrong
way, and it would be very difficult to notice.

<snip>

> >
> > Could something like this work:
> >
> > unsigned long dss_feat_get_param_min(enum dss_range_param param);
> > unsigned long dss_feat_get_param_max(enum dss_range_param param);
> >
> 
> I agree. Should we remove the max_dss_fck patch since we are moving to 
> this approach?

Hmm. I guess it would cause a bit too many conflicts. I can check it
later if it's easy to remove, but for now let's just build on top of it.

 Tomi


