From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 5/6] ARM: OMAP4: hwmod_data: Do not get DSP out of
 reset at boot time
Date: Tue, 28 Feb 2012 03:31:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202280330140.11716@utopia.booyaka.com>
References: <1330096546-20477-1-git-send-email-t-kristo@ti.com> <1330096546-20477-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39771 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964944Ab2B1KbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 05:31:05 -0500
In-Reply-To: <1330096546-20477-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi

On Fri, 24 Feb 2012, Tero Kristo wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> With no driver handling DSP, if brought out of reset, it stays
> active and does not assert standby. This leads to IVAHD powerdomain not
> transitioning and hence preventing chip retention.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Please test this series:

   http://marc.info/?l=linux-omap&m=133040749621183&w=2

in lieu of this patch.


- Paul
