From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/13] OMAP: Introduce API to return a device list
 associated with a voltage domain
Date: Fri, 27 Aug 2010 17:54:03 -0700
Message-ID: <1282956843.11841.107.camel@localhost>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	 <1282130412-12027-5-git-send-email-thara@ti.com>
	 <87y6brblt3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51276 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab0H1AyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 20:54:19 -0400
Received: by gyd8 with SMTP id 8so1341319gyd.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 17:54:19 -0700 (PDT)
In-Reply-To: <87y6brblt3.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

On Fri, 2010-08-27 at 17:52 -0700, Kevin Hilman wrote:
> Thara Gopinath <thara@ti.com> writes:
> 
> > This patch adds an API in the opp layer that
> > can be used by the voltage layer to get a list of all the
> > scalable devices belonging to a particular voltage domain.
> > This API is to be typically called only once by the voltage
> > layer per voltage domain instance and the device list should
> > be stored. This approach makes it easy during dvfs to scale
> > all the devices associated with a voltage domain and then
> > scale the voltage domain.
> >
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> 
> I think this should be done in two steps.
> 
> During init, each OPP

oops, ignore this part.  pushed send too soon.  Only comments below are
relevant.

Kevin

