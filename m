From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [PATCH] OMAP3: PM: PRCM interrupt: Fix warning "MPU wakeup but
 no wakeup sources"
Date: Fri, 19 Nov 2010 16:27:28 +0200
Message-ID: <1290176848.15533.18.camel@eowin>
References: <1290165993-23847-1-git-send-email-ext-madhusudhan.1.gowda@nokia.com>
	 ,<20101119114727.GM2329@legolas.emea.dhcp.ti.com>
	 <090FE800A758CA439B2752C082AC3DEF0666E2AB0B@NOK-EUMSG-06.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40523 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab0KSO1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 09:27:07 -0500
In-Reply-To: <090FE800A758CA439B2752C082AC3DEF0666E2AB0B@NOK-EUMSG-06.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-madhusudhan.1.gowda@nokia.com
Cc: balbi@ti.com, linux-omap@vger.kernel.org, paul@pwsan.com

Hi,

(please read elinux.org/Netiquette :-)

On Fri, 2010-11-19 at 14:53 +0100, ext-madhusudhan.1.gowda@nokia.com
wrote:
> Yes Balbi. I will incorporate your comments.
> WARN(!c && (ct == 1), "prcm: WARNING: PRCM indicated "
>         "MPU wakeup but no wakeup sources "
>         "are marked\n");
> 
> would do it? Then you don't need the extra if ().

btw, the message is a bit redundant. PRCM appears twice.

-- 
balbi

