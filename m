From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv4 8/8] ARM: OMAP3: do not delete per_clkdm autodeps during idle
Date: Tue, 16 Oct 2012 17:39:00 -0700
Message-ID: <877gqqlyor.fsf@deeprootsystems.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	<1342189185-5306-9-git-send-email-t-kristo@ti.com>
	<alpine.DEB.2.00.1209182156330.4747@utopia.booyaka.com>
	<alpine.DEB.2.00.1209182241400.4747@utopia.booyaka.com>
	<87k3vpek28.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1210160603390.9767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62564 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab2JQAis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 20:38:48 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so6521734pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Oct 2012 17:38:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210160603390.9767@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 16 Oct 2012 07:29:21 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> Here's an updated version of this one, with the erratum coverage expanded 
> to include OMAP34xx/35xx.
>
> I think this one can replace Tero's "[PATCHv6 06/11] ARM: OMAP: 
> clockdomain: add support for preventing autodep delete" and "[PATCHv6 
> 07/11] ARM: OMAP3: do not delete per_clkdm autodeps during idle".  Tero, 
> please let us know if you feel otherwise.
>
> The patch seems to pass testing on 37xx.  Was not able to really test it 
> on 35xx due to PM regressions in v3.7-rc1.

With workarounds for some of the other regressions, this passes ret/off
idle/suspend tests on 3530/Overo, 3730/OveroSTORM and 3730/Beagle-xM.  

Queueing for v3.7-rc.

Thanks,

Kevin
