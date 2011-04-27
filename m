From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] arm: omap2plus: GPIO cleanup mach-omap2/*
Date: Wed, 27 Apr 2011 18:58:28 +0300
Message-ID: <BANLkTik4qvrYBs4O90c8ZekW6ULh1tRxEA@mail.gmail.com>
References: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>
	<20110427140129.GH3755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47450 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab1D0P63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 11:58:29 -0400
Received: by vws1 with SMTP id 1so1418351vws.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 08:58:28 -0700 (PDT)
In-Reply-To: <20110427140129.GH3755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Apr 27, 2011 at 5:01 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [110427 02:02]:
>> use gpio_request_<one|array>() instead of multiple gpiolib calls,
>> remove unneeded variables, etc.
>
> Great :)

I think this does conflict with Mike's "omap: cleanup board files"
series though.
