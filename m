From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP2: OMAPFB: Fix invalid bpp for PAL and NTSC modes
Date: Mon, 26 Jul 2010 11:21:24 +0300
Message-ID: <1280132484.2427.14.camel@tubuntu.research.nokia.com>
References: <4c477948.cf7d0e0a.2929.ffffaefe@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17513 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab0GZIVi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jul 2010 04:21:38 -0400
In-Reply-To: <4c477948.cf7d0e0a.2929.ffffaefe@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, "tj@kernel.org" <tj@kernel.org>

On Thu, 2010-07-22 at 00:40 +0200, ext Maurus Cuelenaere wrote:
> omapfb_mode_to_timings() sets the bpp to 0 when bootarg omapfb.mode is set to
> either "pal" or "ntsc". This patch corrects this by setting the bpp to 24, as
> would be done if omapdss_default_get_recommended_bpp() would be called

Thanks, applied to my tree.

 Tomi


