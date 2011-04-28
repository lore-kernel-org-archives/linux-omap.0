From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap2plus: GPIO cleanup mach-omap2/*
Date: Thu, 28 Apr 2011 10:17:03 +0300
Message-ID: <4DB9146F.2080002@compulab.co.il>
References: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>	<20110427140129.GH3755@atomide.com> <BANLkTik4qvrYBs4O90c8ZekW6ULh1tRxEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:50831
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754245Ab1D1HRJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Apr 2011 03:17:09 -0400
In-Reply-To: <BANLkTik4qvrYBs4O90c8ZekW6ULh1tRxEA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/27/11 18:58, Grazvydas Ignotas wrote:

> On Wed, Apr 27, 2011 at 5:01 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Igor Grinberg <grinberg@compulab.co.il> [110427 02:02]:
>>> use gpio_request_<one|array>() instead of multiple gpiolib calls,
>>> remove unneeded variables, etc.
>> Great :)
> I think this does conflict with Mike's "omap: cleanup board files"
> series though.

Yep, as I've stated in the description ;)

I've started working on this before Mike submitted his series and now
I want to get some responses before any rebase work is done.

-- 
Regards,
Igor.

