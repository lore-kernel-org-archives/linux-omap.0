From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 8/8] OMAP3: powerdomain data: add wake-up latency
 figures
Date: Mon, 10 Oct 2011 16:52:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110101652290.5205@utopia.booyaka.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com> <1316622258-3892-1-git-send-email-j-pihet@ti.com> <1316622258-3892-9-git-send-email-j-pihet@ti.com> <alpine.DEB.2.00.1110062215270.4611@utopia.booyaka.com> <CAORVsuX2PUubPzO3mWTaO0Lg6Mdog8wjDY6hm93qheMwoz27CA@mail.gmail.com>
 <alpine.DEB.2.00.1110101636470.5205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49639 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab1JJWwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 18:52:55 -0400
In-Reply-To: <alpine.DEB.2.00.1110101636470.5205@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Mon, 10 Oct 2011, Paul Walmsley wrote:

> OK.  sys_offmode only applies to OFF mode.  Voltage scaling can also occur 
> during RETENTION and INACTIVE ("sleep").  So were these results with 
> retention and voltage scaling disabled?

This last sentence should have read:

So were these results with retention and sleep voltage scaling disabled?

- Paul
