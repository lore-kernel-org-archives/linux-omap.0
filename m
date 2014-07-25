From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp
 interface lists
Date: Fri, 25 Jul 2014 10:44:10 -0500
Message-ID: <CAGo_u6qGYzndVDHxjkoBgfV+adw1FXbhBfRxVPQV2jYq5gt0gA@mail.gmail.com>
References: <1405499774-19770-1-git-send-email-lokeshvutla@ti.com>
	<1405499774-19770-3-git-send-email-lokeshvutla@ti.com>
	<53CE9652.4080304@ti.com>
	<53D276A0.3070800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:41140 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761122AbaGYPoL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jul 2014 11:44:11 -0400
In-Reply-To: <53D276A0.3070800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>

On Fri, Jul 25, 2014 at 10:24 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>
> After looking closely into it, I realized that currently its the same logic of what you are
> suggesting.  If there is no error from registering common lists then only go for registering the
> Soc specific lists.
> Do you still want me to go ahead and make this change?


Sure. Ok with me at least.

-- 
---
Regards,
Nishanth Menon
