From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC part1/2 merge v4][PATCH 00/11] omap2/3/4: uart4 fixes +
 zoom2/3 changes
Date: Fri, 12 Mar 2010 09:34:26 -0800
Message-ID: <20100312173425.GI2900@atomide.com>
References: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
 <A24693684029E5489D1D202277BE894453FB179F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60353 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab0CLRdH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 12:33:07 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894453FB179F@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aguirre, Sergio <saaguirre@ti.com> [100312 09:18]:
> From: Aguirre, Sergio
> Sent: Wednesday, March 10, 2010 6:14 PM
> > Hi,
> > 
> > This is v4 of my serial work series merge found here: [1].
> > 
> > And it's meant to be applied on top of Thomas's patch: [2]

<snip>
 
> 
> Tony,
> 
> Should I take out the new code, and just send you the fixes necessary to boot the zoom3, without adding uart4 support?

Yes please. The series looks good to me, but is also a bit intrusive
for the -rc series :) So please split it into fixes for 2.6.34 -rc,
and new code for 2.6.35 merge window. I got the [2] below already
queued.

Regards,

Tony

> <snip>
> 
> > [1] http://marc.info/?l=linux-omap&m=126815136710361&w=2
> > [2] http://marc.info/?l=linux-kernel&m=126709078514087&w=2
