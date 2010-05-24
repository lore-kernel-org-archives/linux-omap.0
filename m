From: Scott Ellis <scott@jumpnowtek.com>
Subject: Re: [PATCH 3/6] SPI omap2_mcspi.c: Use appropriate clock divider
 value
Date: Mon, 24 May 2010 10:31:56 -0400
Message-ID: <1274711516.2888.16.camel@quad>
References: <1268407315.14445.52.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:3664 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab0EXOcB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 May 2010 10:32:01 -0400
In-Reply-To: <1268407315.14445.52.camel@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Please disregard this patch.

PaulM from TI responded,

"It appears that this is a documentation error. The module does support
all 16 divide values for the CLKD field"

http://e2e.ti.com/support/dsp/omap_applications_processors/f/42/p/38754/142276.aspx#142276


