From: Afzal Mohammed <x0148406@ti.com>
Subject: Re: [PATCH 0/4] OMAP-GPMC generic timing migration
Date: Fri, 19 Oct 2012 21:04:31 +0530
Message-ID: <50817307.50509@ti.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56948 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910Ab2JSPep (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Oct 2012 11:34:45 -0400
In-Reply-To: <5076B166.2020006@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Daniel,

On Thursday 11 October 2012 05:15 PM, Daniel Mack wrote:

> Could you tell me which patches I need on top of soon-to-be-3.7-rc1? I
> would like to augment this to make GPMC attached NAND probable in DT, in
> case this is still an open topic.

In case you can help on making gpmc nand dt probable, please
proceed. I would be on vacation next week, may be we can
discuss after I am back.

am335x based boards like beagle bone should be booting on
l-o master and it has gpmc header cleanup changes with
minimal driver support.

As I don't have the sufficient time to explain in detail, some
pointers. Discussion between us [1] hopefully explains it in brief.
It would be like peripherals connected to gpmc being represented
as child nodes in dt. gpmc driver probably in probe would have to
invoke of_platform_populate to create child nodes (for devices like
nand). And driver would have to be enhanced to configure gpmc
based on information passed through dt for each child nodes.
Or roughly have a dt equivalent of driver as in [2].

One issue would be the memory resource creation by gpmc
driver and which has to be provided to client resource data.
And a decision has to be taken whether a generic routine is
going to be used or initially a custom routine invocation
based on child compatible fields would be sufficient.

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg74397.html
[2] git://gitorious.org/x0148406-public/linux-kernel tags/gpmc-drv-v6
