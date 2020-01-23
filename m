From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/20] ARM: omap2plus: Drop unneeded select of
 MIGHT_HAVE_CACHE_L2X0
Date: Thu, 23 Jan 2020 08:09:35 -0800
Message-ID: <20200123160935.GY5885@atomide.com>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
 <20200121103722.1781-15-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52066 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAWQJj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 23 Jan 2020 11:09:39 -0500
Content-Disposition: inline
In-Reply-To: <20200121103722.1781-15-geert+renesas@glider.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

* Geert Uytterhoeven <geert+renesas@glider.be> [200121 10:38]:
> Support for TI AM43x SoCs depends on ARCH_MULTI_V7, which selects
> ARCH_MULTI_V6_V7.
> As the latter selects MIGHT_HAVE_CACHE_L2X0, there is no need for
> SOC_AM43XX to select MIGHT_HAVE_CACHE_L2X0.

Acked-by: Tony Lindgren <tony@atomide.com>
