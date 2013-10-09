From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/5] ARM: OMAP2+: hwmod: cleanup HWMOD_INIT_NO_RESET
 usage
Date: Wed, 9 Oct 2013 14:55:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310091455020.30199@utopia.booyaka.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com> <1381313521-10422-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41805 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab3JIOzW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 10:55:22 -0400
In-Reply-To: <1381313521-10422-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

On Wed, 9 Oct 2013, Rajendra Nayak wrote:

> For modules/IPs/hwmods which do not have
> -1- sys->class->reset()
> and
> -2- hardreset lines
> and
> -3- No way to do an ocp reset (no sysc control)
> the flag 'HWMOD_INIT_NO_RESET' is not much useful.
> 
> Cleanup all such instances across various hwmod data files.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued.


- Paul
