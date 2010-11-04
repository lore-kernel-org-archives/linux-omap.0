From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 06/13] OMAP3: DMA: hwmod: add system DMA
Date: Thu, 04 Nov 2010 11:48:20 -0400
Message-ID: <1288885700.27306.22.camel@localhost>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	 <1288099513-1854-7-git-send-email-manjugk@ti.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E9402DC03B4C3@dbde02.ent.ti.com>
	 <4CD2368D.50107@ti.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E9402DC03B7B4@dbde02.ent.ti.com>
	 <4CD2A765.404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64832 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab0KDPsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 11:48:23 -0400
Received: by pvb32 with SMTP id 32so587074pvb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Nov 2010 08:48:22 -0700 (PDT)
In-Reply-To: <4CD2A765.404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-11-04 at 08:30 -0400, Cousson, Benoit wrote:

[...]

> >>> Any better suggestion to handle this issue?
> >>
> >> Well, yes, use HWMOD_NO_IDLEST and remove idlest_reg_id&
> >> idlest_idle_bit entries in the omap2 structure.
> >>
> >> ST_SDMA is the standby status of the SDMA, but there is no
> >> idle status
> >> on that IP, so you cannot do anything.
> >> The standby will just reflect the activity of the master port of
> the
> >> DMA, but it will give you no information about the slave port
> >> and thus
> >> we do not have any module ready information.
> >
> > Thanks for the feedback.
> >
> > This change is introduced as per kevin's review comment at:
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34278.html
> 
> Well this register is confusing, because he uses the same naming 
> convention but with a difference meaning:
> 
> ST_SDMA: System DMA standby status.
> - 0x0: System DMA is active.
> - 0x1: System DMA is in standby mode.
> 
> > I am ok to use "HWMOD_NO_IDLEST" if kevin also agrees

I agree.

> He will... Otherwise I will throw him into the New England Aquarium
> like Linus :-) 

...if he tried, I think he would end up in the fish tank before me. ;)

Kevin




