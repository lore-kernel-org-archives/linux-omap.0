From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/2] OMAP: DSS2: Fix DSS core init fail path
Date: Fri, 07 May 2010 11:07:39 +0300
Message-ID: <1273219659.1978.144.camel@tubuntu.research.nokia.com>
References: <cover.1273146321.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30454 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab0EGIIM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 04:08:12 -0400
In-Reply-To: <cover.1273146321.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nikula Jani.1 (EXT-Nixu/Helsinki)" <ext-jani.1.nikula@nokia.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 2010-05-06 at 13:59 +0200, Nikula Jani.1 (EXT-Nixu/Helsinki)
wrote:
> Hi -
> 
> These patches fix the broken DSS omap_dss_probe() fail path, reported by Kevin
> Hilman [1].
> 
> Kevin, could you please check this with your setup too? It would be much
> appreciated.
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27112.html

Jani, I just noticed that this conflicts with the following patch in my
for-next branch:

commit 36b33efe80eb07e3447107c2bdba3c674c10a41a
Author: Roger Quadros <roger.quadros@nokia.com>
Date:   Wed Mar 17 13:35:19 2010 +0100

    OMAP: DSS2: Add Kconfig option for DPI display type
    
    This allows us to disable DPI on systems that do not have it
    
    Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Can you rebase the patches on top of my for-next branch?

 Tomi


