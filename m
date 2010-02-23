From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RESEND] [PATCH 1/5] omap2/3/4: mailbox: remove compiler warning
Date: Mon, 22 Feb 2010 18:05:50 -0600
Message-ID: <4B831BDE.3070703@ti.com>
References: <2C1563023E232C49B9F505633D57C2DA2640F2C540@dlee04.ent.ti.com> <4B8319D6.8080909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33571 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab0BWAFx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Feb 2010 19:05:53 -0500
In-Reply-To: <4B8319D6.8080909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 2/22/2010 5:57 PM, Ramirez Luna, Omar wrote:
>
> why not moving omap_mbox_unregister to the block containing the ifdefs?
> at least you won't be adding an ifdef and if(cpu_xx)
>

i take this back... both statements are needed because of previous 
registration.

- omar
