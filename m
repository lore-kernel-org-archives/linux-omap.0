From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 0/2] OMAPDSS: small fixes for 3.3 rc
Date: Thu, 01 Mar 2012 05:38:27 +0000
Message-ID: <4F4F0B53.9010402@gmx.de>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:54331 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752899Ab2CAFir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 00:38:47 -0500
In-Reply-To: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On 02/29/2012 08:48 AM, Tomi Valkeinen wrote:
> Hi,
> 
> Two small fixes for omapdss.

Applied both.


Thanks,

Florian Tobias Schandinat

> 
> Florian, if the patches are ok, I guess it's easier if you just apply these
> patches from email, instead of me sending a pull request?
> 
>  Tomi
> 
> Tomi Valkeinen (2):
>   OMAPDSS: panel-dvi: Add Kconfig dependency on I2C
>   OMAPDSS: APPLY: make ovl_enable/disable synchronous
> 
>  drivers/video/omap2/displays/Kconfig |    2 +-
>  drivers/video/omap2/dss/apply.c      |    6 ++++++
>  2 files changed, 7 insertions(+), 1 deletions(-)
> 

