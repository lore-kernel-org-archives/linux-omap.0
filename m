From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] RX51: Add SDRAM init
Date: Thu, 12 Nov 2009 15:47:44 -0800
Message-ID: <87pr7ns3tr.fsf@deeprootsystems.com>
References: <1256647181-18983-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:51090 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbZKLXrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 18:47:42 -0500
Received: by pzk1 with SMTP id 1so903704pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 15:47:47 -0800 (PST)
In-Reply-To: <1256647181-18983-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Tue\, 27 Oct 2009 14\:39\:41 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> This patch adds board specific SDRAM init for RX51. This patch is a
> collaboration of work from following people:
>
> Juha Yrjola: Original code
> Lauri Leukkunen: Port to RX51
> Tero Kristo: Support for multiple OPP:s, merge of patches
> Samu Onkalo: Fixed SDRAM parameters according to specs
> Kalle Jokiniemi: A fix for rounding error
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Cc: Samu Onkalo <samu.p.onkalo@nokia.com>
> Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> Cc: Juha Yrjola <juha.yrjola@solidboot.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

I've had a hacked version of this in the PM branch for while now.
This one can go into l-o master and I'll drop mine from the PM branch.

Kevin
