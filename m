From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 3/4] omap: move detection of NAND CS to common-board-devices
Date: Wed, 04 May 2011 09:38:33 +0300
Message-ID: <4DC0F469.9030406@compulab.co.il>
References: <cover.1303682352.git.mike@compulab.co.il> <e2d77d1e885e6878ffbc9bf9dcf0b2dbea2b5d1f.1303682352.git.mike@compulab.co.il> <724FD998-C5DC-4C36-911B-52037F6D4323@linuxhacker.ru> <44342B2F-34C0-490C-91B8-96A9EA683F9B@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:42510
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752075Ab1EDGii (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 02:38:38 -0400
In-Reply-To: <44342B2F-34C0-490C-91B8-96A9EA683F9B@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/04/11 07:10, Oleg Drokin wrote:
> Ok, so here's a simple patch to save everyone trouble, I guess.
> 
> Though on the other hand I can imagine that perhaps including this generic common-board-devices.c
> might not be desirable for people that don't use anything from that file.

Since the common-board-devices.c has TWL initialization I doubt there would a
board that does not use it at all...

> Would it be a better idea to split it to a file-per-feature?

Splitting the common-board-devices into a file-per-feature will diminish its
added value, IMO.
We can either continue to use #ifdef CONFIG_SOMETHING in both
common-board-devices.[ch] as your fix proposes or just drop #ifdefs and inlines
from the header.
Tony, what is your preference?

-- 
Sincerely yours,
Mike.
