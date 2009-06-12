From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Which directory should OMAP-L137/L138's code in ?
Date: Fri, 12 Jun 2009 16:16:20 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00378B66E47@dbde02.ent.ti.com>
References: <4A32264F.6050609@windriver.com>
 <20090612103200.GB7060@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51967 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293AbZFLKq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 06:46:29 -0400
In-Reply-To: <20090612103200.GB7060@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "stanley.miao" <stanley.miao@windriver.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
> Lindgren
> Sent: Friday, June 12, 2009 4:02 PM
> To: stanley.miao; Kevin Hilman
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Which directory should OMAP-L137/L138's code in ?
> 
> * stanley.miao <stanley.miao@windriver.com> [090612 02:53]:
> > I am developing on the board OMAP-L137/L138, which is similar with
> > Davinci series board.  Should I put its platform file in the directory
> > arch/arm/mach-davinci ? or create a new direcory arch/arch/mach-L1xx for
> > it ?
> >
> > Any suggestions ?
> 
> If it uses DaVinci core code to me it sounds like it should be under
> mach-davinci. Kevin?
> 

The TI code for OMAP L 13x is part of mach-davinci. And the platform specific patches to be submitted to Davinci mailing list for upstream submissions.

Regards,
Khasim
