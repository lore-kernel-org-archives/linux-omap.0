From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC part1/2 merge v4][PATCH 00/11] omap2/3/4: uart4 fixes +
 zoom2/3 changes
Date: Fri, 12 Mar 2010 11:44:57 -0600
Message-ID: <A24693684029E5489D1D202277BE894453FB17FB@dlee02.ent.ti.com>
References: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
 <A24693684029E5489D1D202277BE894453FB179F@dlee02.ent.ti.com>
 <20100312173425.GI2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47579 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab0CLRpH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 12:45:07 -0500
In-Reply-To: <20100312173425.GI2900@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, March 12, 2010 11:34 AM
> To: Aguirre, Sergio
> Cc: Kevin Hilman; Pandita, Vikram; Paul Walmsley; Felipe Balbi; linux-
> omap@vger.kernel.org
> Subject: Re: [RFC part1/2 merge v4][PATCH 00/11] omap2/3/4: uart4 fixes +
> zoom2/3 changes
> 
> * Aguirre, Sergio <saaguirre@ti.com> [100312 09:18]:
> > From: Aguirre, Sergio
> > Sent: Wednesday, March 10, 2010 6:14 PM
> > > Hi,
> > >
> > > This is v4 of my serial work series merge found here: [1].
> > >
> > > And it's meant to be applied on top of Thomas's patch: [2]
> 
> <snip>
> 
> >
> > Tony,
> >
> > Should I take out the new code, and just send you the fixes necessary to
> boot the zoom3, without adding uart4 support?
> 
> Yes please. The series looks good to me, but is also a bit intrusive
> for the -rc series :) So please split it into fixes for 2.6.34 -rc,
> and new code for 2.6.35 merge window. I got the [2] below already
> queued.

Ok, so, I'll just drop patches 4, 5, 6, 7 then test and resend.

Regards,
Sergio

> 
> Regards,
> 
> Tony
> 
> > <snip>
> >
> > > [1] http://marc.info/?l=linux-omap&m=126815136710361&w=2
> > > [2] http://marc.info/?l=linux-kernel&m=126709078514087&w=2
