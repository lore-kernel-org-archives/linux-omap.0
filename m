From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 2a/5 v2] ARM: OMAP1: select clock rate by CPU type
Date: Thu, 1 Dec 2011 11:10:11 +0100
Message-ID: <201112011110.11476.jkrzyszt@tis.icnet.pl>
References: <20111128174508.GO31337@atomide.com> <1322686675-26855-1-git-send-email-jkrzyszt@tis.icnet.pl> <20111130222837.GR31337@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:44396 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab1LAKLG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Dec 2011 05:11:06 -0500
In-Reply-To: <20111130222837.GR31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wednesday 30 of November 2011 at 23:28:38, Tony Lindgren wrote:
> 
> We should also now be able to remove all the CONFIG_OMAP_ARM_XXXMHZ options
> too, right?

Right, but then, perhaps the initial version of patch 2a/5, which 
already started removing them, from omap1_defconfig for now, then going 
into the right direction while unblocking another regression fix (3/5), 
_is_ a good candidate for an rc fix?

Thanks,
Janusz
