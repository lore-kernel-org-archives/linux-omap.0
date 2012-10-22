From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/4] OMAP-GPMC generic timing migration
Date: Mon, 22 Oct 2012 21:51:41 +0200
Message-ID: <5085A3CD.7020700@gmail.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com> <50817307.50509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48588 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab2JVTvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 15:51:50 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1237212bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 12:51:49 -0700 (PDT)
In-Reply-To: <50817307.50509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <x0148406@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, linux-arm-kernel@lists.infradead.org

On 19.10.2012 17:34, Afzal Mohammed wrote:
> Hi Daniel,
> 
> On Thursday 11 October 2012 05:15 PM, Daniel Mack wrote:
> 
>> Could you tell me which patches I need on top of soon-to-be-3.7-rc1? I
>> would like to augment this to make GPMC attached NAND probable in DT, in
>> case this is still an open topic.
> 
> In case you can help on making gpmc nand dt probable, please
> proceed. I would be on vacation next week, may be we can
> discuss after I am back.

Enjoy your vacation :)

> am335x based boards like beagle bone should be booting on
> l-o master and it has gpmc header cleanup changes with
> minimal driver support.
> 
> As I don't have the sufficient time to explain in detail, some
> pointers. Discussion between us [1] hopefully explains it in brief.
> It would be like peripherals connected to gpmc being represented
> as child nodes in dt. gpmc driver probably in probe would have to
> invoke of_platform_populate to create child nodes (for devices like
> nand). And driver would have to be enhanced to configure gpmc
> based on information passed through dt for each child nodes.
> Or roughly have a dt equivalent of driver as in [2].

Hmm, not sure if I follow all your thought here, but I cooked up
something that is straight-forward and works well for me. I'll post them
now, so we at least have a base for discussions ...


Daniel

