From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2 0/2] OMAP: DSS2: Fix DSS core init fail path
Date: Mon, 10 May 2010 10:01:32 +0300
Message-ID: <1273474892.2305.5.camel@tubuntu.research.nokia.com>
References: <1273219659.1978.144.camel@tubuntu.research.nokia.com>
	 <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58862 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab0EJHB5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 03:01:57 -0400
In-Reply-To: <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nikula Jani.1 (EXT-Nixu/Helsinki)" <ext-jani.1.nikula@nokia.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2010-05-07 at 11:58 +0200, Nikula Jani.1 (EXT-Nixu/Helsinki)
wrote:
> Hi -
> 
> These patches fix the broken DSS omap_dss_probe() fail path, reported by Kevin
> Hilman [1].

Thanks, looks good. Applied to my DSS tree.

 Tomi


