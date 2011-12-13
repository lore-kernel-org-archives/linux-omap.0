From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 1/8] ARM: OMAP2+: hwmod: Add API to enable IO ring
 wakeup.
Date: Tue, 13 Dec 2011 13:51:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112131350530.12046@utopia.booyaka.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com> <1323713733-13115-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33320 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab1LMUvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 15:51:32 -0500
In-Reply-To: <1323713733-13115-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "R, Govindraj" <govindraj.raja@ti.com>

Hi Tero

On Mon, 12 Dec 2011, Tero Kristo wrote:

> From: R, Govindraj <govindraj.raja@ti.com>
> 
> Add API to enable IO pad wakeup capability based on mux dynamic pad and
> wake_up enable flag available from hwmod_mux initialization.
> 
> Use the wakeup_enable flag and enable wakeup capability
> for the given pads. Wakeup capability will be enabled/disabled
> during hwmod idle transition based on whether wakeup_flag is
> set or cleared.
> 
> Map the enable/disable pad wakeup API's to hwmod_wakeup_enable/disable.
> 
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Since you're in the submitter chain for these patches, I'll need your 
Signed-off-by on this patch and the next one.  Okay to add it?


- Paul
