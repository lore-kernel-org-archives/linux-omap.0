From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 3/4] Serial: Avoid using hwmod lookup using name string
Date: Fri, 04 Jun 2010 08:37:39 -0700
Message-ID: <87vd9yolks.fsf@deeprootsystems.com>
References: <53451.192.168.10.88.1275659037.squirrel@dbdmail.itg.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03232DA920@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51743 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab0FDPhm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 11:37:42 -0400
Received: by pwj5 with SMTP id 5so48234pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Jun 2010 08:37:42 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03232DA920@dbde02.ent.ti.com> (Thara Gopinath's message of "Fri\, 4 Jun 2010 19\:48\:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Gopinath, Thara" <thara@ti.com> writes:

>>>
>>>-		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
>>>-		if (WARN_ON(!uart))
>>>-			return;
>>>+	/*
>>>+	 * NOTE: omap_hwmod_init() has not yet been called,
>>>+	 *       so no hwmod functions will work yet.
>>>+	 */
>>>
>>>-		uart->oh = oh;
>>>-		uart->num = i++;
>>>-		list_add_tail(&uart->node, &uart_list);
>>>-		num_uarts++;
>>>+	/*
>>>+	 * During UART early init, device need to be probed
>>>+	 * to determine SoC specific init before omap_device
>>>+	 * is ready.  Therefore, don't allow idle here
>>>+	 */
>
> You have two comment blocks back to back. Either make it into one block or put the first block appropriately above the intended code.

The latter please.

Kevin
