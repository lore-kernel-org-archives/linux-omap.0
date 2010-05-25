From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [pm-wip/uart][PATCH 2/6] Serial: Add UART4 hwmod data.
Date: Tue, 25 May 2010 06:10:52 -0500
Message-ID: <A24693684029E5489D1D202277BE8944537B8E99@dlee02.ent.ti.com>
References: <47872.192.168.10.88.1274362704.squirrel@dbdmail.itg.ti.com>
	<87y6fcerz1.fsf@deeprootsystems.com>
	<17f301cafb40$2bc91e80$LocalHost@wipblrx0100947A>,<87r5l0u9m2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34775 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab0EYLK5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 07:10:57 -0400
In-Reply-To: <87r5l0u9m2.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: Kevin Hilman [khilman@deeprootsystems.com]
> Sent: Monday, May 24, 2010 7:07 PM
> To: Raja, Govindraj; Aguirre, Sergio
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [pm-wip/uart][PATCH 2/6] Serial: Add UART4 hwmod data.
> 
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>  not in my 
> > This happening because we are missing these patches:
> >
> > https://patchwork.kernel.org/patch/84748/
> > https://patchwork.kernel.org/patch/84749/
> > https://patchwork.kernel.org/patch/84755/
> > https://patchwork.kernel.org/patch/84750/
> >
> > Not part of LO yet.
> >
> > But we need these patches for uart4 support for 3630.
> 
> Ah, OK.  I thought these had been merged already.
> 
> Looks like these need to be refreshed/resubmitted for l-o.  Sergio?
> 

Ah, I forgot about resubmitting these for the merge window.

Got dragged for this last weeks into high priority work and have abandoned them a little bit. :/

I'm in a business trip at this point and I don't have access to the 3630SDP to try this.

You can either wait for me to go back and test them, or I can just send them, and somebody else can
help me out re-vaidating them, once i rebase and resend.

Does that sound ok?

Regards,
Sergio

> Kevin
> 