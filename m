From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 14:01:14 -0200
Message-ID: <CAOMZO5BrGcffzd2YBrF6YQTs7X38RuniYhm010fpLMnigecnTw@mail.gmail.com>
References: <20130131030203.GA8374@quad.lixom.net>
	<alpine.LFD.2.02.1301302312030.6300@xanadu.home>
	<20130131092024.GN2637@n2100.arm.linux.org.uk>
	<20130131104044.GO2637@n2100.arm.linux.org.uk>
	<510A6877.9080307@ti.com>
	<20130131130437.GP2637@n2100.arm.linux.org.uk>
	<510A78E1.8010308@ti.com>
	<20130131141320.GQ2637@n2100.arm.linux.org.uk>
	<20130131141635.GR2637@n2100.arm.linux.org.uk>
	<510A7D9F.7040507@ti.com>
	<20130131142758.GS2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:35116 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab3AaQBQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 11:01:16 -0500
Received: by mail-vb0-f52.google.com with SMTP id fa15so1818934vbb.39
        for <linux-omap@vger.kernel.org>; Thu, 31 Jan 2013 08:01:16 -0800 (PST)
In-Reply-To: <20130131142758.GS2637@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, arm@kernel.org, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 31, 2013 at 12:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> too.  It also looks like Versatile Express support _can't_ be disabled in
> a multiplatform kernel, which is ludicrous.

Should we go with this approach?
https://patchwork.kernel.org/patch/1774521/
