From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH] HSMMC: mmc_omap_irq: Do not expect cmd/data to be
 non-null when CC/TC occurs
Date: Wed, 8 Apr 2009 20:43:50 +0200
Message-ID: <20090408204350.3b675823@mjolnir.ossman.eu>
References: <49DC5DD8.2070208@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:47288 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbZDHSnz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Apr 2009 14:43:55 -0400
In-Reply-To: <49DC5DD8.2070208@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@nokia.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Wed, 08 Apr 2009 11:18:32 +0300
Adrian Hunter <adrian.hunter@nokia.com> wrote:

> From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> 
> With spurious interrupt cmd can be null even when we have CC
> set in irq status.
> 
> Fixes: NB#106295 - prevent potential kernel crash in the MMC driver
> 
> Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---

Queued.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org
  TigerVNC, core developer          http://www.tigervnc.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
