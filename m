From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/4] ARM: OMAP: Move set_globals initialization to
 happen in init_early
Date: Fri, 7 Oct 2011 07:54:04 -0700
Message-ID: <20111007145403.GG6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005014044.GZ6324@atomide.com>
 <alpine.LFD.2.02.1110042150190.9106@xanadu.home>
 <20111006013656.GG6324@atomide.com>
 <4E8EA2A4.5070301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51673 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab1JGOyK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 10:54:10 -0400
Content-Disposition: inline
In-Reply-To: <4E8EA2A4.5070301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111006 23:22]:
> The changes looks fine to me. Though the ugly hard-coding
> is back with it, it's a step towards generic_io, so hopefully
> it won't have to stay for long time.

Nico please correct me if I'm wrong, but I think that with
generic map_io we have static mappings in place after map_io,
and then ioremap should work for the static mappings right
after map_io except without the need for __arch_ioremap.

Regards,

Tony
