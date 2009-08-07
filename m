From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: PM: UART not resuming from OFF mode
Date: Fri, 7 Aug 2009 11:49:16 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A57ACAC@dlee02.ent.ti.com>
References: <4A7BEC0A.9030909@nokia.com> <87k51f4mto.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56580 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272AbZHGQpf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 12:45:35 -0400
In-Reply-To: <87k51f4mto.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, August 07, 2009 11:21 AM
> To: Roger Quadros
> Cc: linux-omap@vger.kernel.org
> Subject: Re: PM: UART not resuming from OFF mode
> 
> Roger Quadros <ext-roger.quadros@nokia.com> writes:
> 
> >  I'm facing this strange problem since some days. I have 3 identical
> > boards using OMAP3430 ES3.1 and I'm using Kevin's PM
> > tree. http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
> pm.git;a=shortlog;h=pm
> >
> > The problem is that UART3 fails to operate correctly after OFF mode on
> > _two_ of the boards but works on one. It seems to receive characters
> > but 0 only. So characters do not show up on terminal.
> >
> > Is anybody experiencing similar problems with UART and off mode on your
> boards?
> 
> Is this after suspend-to-OFF or OFF-while-idle?
> 
> I've experienced this with UART1 on SDP ES3.0, but according to
> Rajendra it didn't happen on SDP ES3.1 (I don't currently have any
> ES3.1 hardware) :(
> 
> Are all of yours ES3.1 ?

Could it be related to board encryption type (GP, EMU, HS)?

I'm not an expert on the topic, but I'm just throwing possible variants...

Regards,
Sergio
> 
> I haven't tracked it further since I only saw it on my SDP with UART1
> and not on any other board.
> 
> Kevin
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

