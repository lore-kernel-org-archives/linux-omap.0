From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
Date: Wed, 19 Feb 2014 17:53:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402191752590.8777@utopia.booyaka.com>
References: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41958 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbaBSRxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 12:53:44 -0500
In-Reply-To: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Illia Smyrnov <illia.smyrnov@globallogic.com>
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, grygorii.strashko@ti.comrogerq@ti.com

On Wed, 5 Feb 2014, Illia Smyrnov wrote:

> Commit 313a76e (ARM: OMAP2+: hwmod: Fix SOFTRESET logic) introduced
> softreset bit cleaning right after set one. It is caused L3 error for
> OMAP4 ISS because ISS register write occurs when ISS reset process is in
> progress. Avoid this situation by cleaning softreset bit later, when reset
> process is successfully finished.
> 
> Signed-off-by: Illia Smyrnov <illia.smyrnov@globallogic.com>

Thanks, queued for v3.14-rc with notations from Grygorii and Roger.


- Paul
