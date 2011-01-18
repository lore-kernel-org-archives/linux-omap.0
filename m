From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if doing so
 would reset an active clockdomain
Date: Tue, 18 Jan 2011 14:52:41 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101181452120.13225@utopia.booyaka.com>
References: <1295344109-7056-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41143 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1ARVwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 16:52:42 -0500
In-Reply-To: <1295344109-7056-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Tue, 18 Jan 2011, Tero Kristo wrote:

> On OMAP3 SoCs, if the CORE powerdomain enters off-mode, many other
> parts of the chip will be reset.  If those parts of the chip are busy,
> the reset will disrupt them, causing unpredictable and generally
> undesirable results.
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks Tero.

Reviewed-by: Paul Walmsley <paul@pwsan.com>

Kevin, do you want to take this one?


- Paul
