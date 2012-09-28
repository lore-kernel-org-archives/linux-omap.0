From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 0/7] ARM: OMAP2+: Add device-tree support for timers
Date: Fri, 28 Sep 2012 17:17:03 -0500
Message-ID: <506621DF.20508@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com> <505A7E0B.30709@ti.com> <20120920235309.GO28835@atomide.com> <5063330E.3000203@ti.com> <5065F19E.5020708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33594 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758465Ab2I1WRM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 18:17:12 -0400
In-Reply-To: <5065F19E.5020708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 09/28/2012 01:51 PM, Vaibhav Hiremath wrote:

[snip]

> Jon,
> 
> Sorry for delayed response, But I tried using your omap_test application
> to validate this patch series, but it is failing for me.
> 
> How did you test it? Are you running same test application at your end?
> 
> I am debugging this issue, i just thought I should tell you this before
> its too late.

By the way, I have not seen any such issues on OMAP2/3/4 and so this
appears to be specific to AM335x. So I would not be too concerned, we
just need to understand why interrupts on some timers are not working on
the AM335x. Probably a configuration issue some where and that can
always be fixed separately.

Cheers
Jon
