From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 15/28] OMAP4: HWMOD: Modify DSS opt clocks
Date: Wed, 15 Jun 2011 14:23:47 +0300
Message-ID: <1308137027.1974.39.camel@deskari>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307627810-3768-16-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41263 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754850Ab1FOLXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 07:23:53 -0400
In-Reply-To: <1307627810-3768-16-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-fbdev@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

On Thu, 2011-06-09 at 16:56 +0300, Tomi Valkeinen wrote:
> Add missing DSS optional clocks to HWMOD data for OMAP4xxx.
> 
> Add HWMOD_CONTROL_OPT_CLKS_IN_RESET flag for dispc to fix dispc reset.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Benoit (and/or Paul/Kevin), can you ack this and the other HWMOD
patches, or give comments?

 Tomi


