From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Tue, 16 Nov 2010 12:37:51 -0800
Message-ID: <20101116203751.GG9264@atomide.com>
References: <1289849261-29767-2-git-send-email-nm@ti.com>
 <20101116122128.5c6cc050@surf>
 <4CE2710A.3010804@ti.com>
 <20101116134220.1bb818c0@surf>
 <4CE2A1DA.3020203@ti.com>
 <20101116165039.7e6b8e16@surf>
 <8762vxjlbs.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52207 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab0KPUiC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 15:38:02 -0500
Content-Disposition: inline
In-Reply-To: <8762vxjlbs.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [101116 08:06]:
> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:
> 
> > On Tue, 16 Nov 2010 09:23:06 -0600
> > Nishanth Menon <nm@ti.com> wrote:
> >
> >> my initial implementation had forced board files to call the 
> >> opp_init_table, then changed that here:
> >> http://marc.info/?l=linux-omap&m=127431810922704&w=2
> >> Kevin seemed happy with the change here:
> >> http://marc.info/?l=linux-omap&m=127507237109393&w=2
> >
> > Ok, if Kevin is happy with this solution, fair enough. Sorry for the
> > noise, and thanks for your answers.
> 
> Yes, I'm not a big fan of the init function called multiple times
> either, but I really want to minimize what board files have to do.
> 
> Historically, we tend to add all the init functions to every board file,
> and this is getting cumbersome to understand and maintain.  What we need
> is for common code to take care of sensible defaults for all boards, and
> then only boards with non-default behavior have to have custom code.

Yeah. The initial comment from Thomas with data in .h file should
be fixed though.

Tony
