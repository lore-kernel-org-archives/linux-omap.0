From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [Patch 1/2] OMAP2PLUS: DSS2: Add dss_opt_clk_roles in pdata
Date: Mon, 28 Feb 2011 11:23:42 +0200
Message-ID: <1298885022.9809.18.camel@deskari>
References: <1298622470-10558-1-git-send-email-sumit.semwal@ti.com>
	 <1298622470-10558-2-git-send-email-sumit.semwal@ti.com>
	 <1298884249.9809.8.camel@deskari>
	 <AANLkTi=oAcua0z3Bwb4Yq-Xoj=2R5RXgDR+KnuJ77qkT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49317 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab1B1JXp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 04:23:45 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S9Njd9022318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 03:23:45 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1S9NixL018999
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 03:23:44 -0600 (CST)
In-Reply-To: <AANLkTi=oAcua0z3Bwb4Yq-Xoj=2R5RXgDR+KnuJ77qkT@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Semwal, Sumit" <sumit.semwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

On Mon, 2011-02-28 at 03:17 -0600, Semwal, Sumit wrote:
> Hi Tomi,
> 
> On Mon, Feb 28, 2011 at 2:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

<snip>

> > And is there even need to create clk_roles array. If I'm not mistaken,
> > the only use for this data is for the opt_clock_available() function. We
> > could just have an opt_clock_available() function pointer in the
> > omap_display_platform_data, and the function itself would be in
> > display.c. And the function could use the original hwmod data.
> Ok, but in that case, we do the same hwmod lookup everytime, is it?

Yes. I have no idea if hwmod lookup is heavy or not. But:

> That may not be so bad though, considering we check that very rarely
> [in dsshw_probe=>dss_get_clocks() path].

Yep, we do it once (if we're not unloading & loading modules). So I
don't think it matters. But if you want, you could do
omap_hwmod_lookup("dss_core") in omap_display_init(), and store the
return value somewhere.

 Tomi


