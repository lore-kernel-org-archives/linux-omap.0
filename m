From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Add support for OMAP3 EVM
Date: Tue, 25 Nov 2008 13:21:20 +0200
Message-ID: <20081125132120.1d740c04.jarkko.nikula@nokia.com>
References: <1227591577-23414-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52084 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYKYLWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 06:22:13 -0500
In-Reply-To: <1227591577-23414-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, ext Misael Lopez Cruz <mesak82@gmail.com>

On Tue, 25 Nov 2008 11:09:37 +0530
"ext Anuj Aggarwal" <anuj.aggarwal@ti.com> wrote:

> This patch adds ALSA SoC support for OMAP3 EVM using TWL4030 audio codec.
> 
I don't know about audio connections in all of these OMAP2 & OMAP3 EVM's
& SDP's but would it be jsut possible to re-use
sound/soc/omap/omap3beagle.c?

Or if those EVM's & SDP's can route TWL4030 audio connections more
flexible than Beagle but somewhat similar manner, then probably have one
single machine driver for all EVM's?

Otherwise it doesn't make very much sense to have n similar machine
drivers where only functions and variable names differ.


Jarkko
