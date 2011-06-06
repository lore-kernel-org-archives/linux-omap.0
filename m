From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2 to use REGULATOR_SUPPLY
Date: Mon, 6 Jun 2011 13:36:49 -0400
Message-ID: <275EC3C2-501A-4EC4-BFCB-81DBABA49822@linuxhacker.ru>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru> <1307342762-25363-2-git-send-email-green@linuxhacker.ru> <20110606092126.GG18731@legolas.emea.dhcp.ti.com> <EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru> <20110606171326.GK12242@legolas.emea.dhcp.ti.com> <547324C9-4B76-410E-86E6-092D062C95AB@linuxhacker.ru> <20110606172832.GM12242@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:37984 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab1FFRhM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jun 2011 13:37:12 -0400
In-Reply-To: <20110606172832.GM12242@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Rapoport <mike@compulab.co.il>, Nishant Kamat <nskamat@ti.com>, Steve Sakoman <steve@sakoman.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hello!

On Jun 6, 2011, at 1:28 PM, Felipe Balbi wrote:

>> Ok, I get the idea. Do you think it would be best to convert every supply
>> definition to an array then just in case?
> I think that while you're doing this big conversion, why not ?

Well, ok then. I'll redo this patch.

Bye,
    Oleg
