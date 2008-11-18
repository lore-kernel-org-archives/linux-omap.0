From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM: Check in set_pwrdm_state that target state
 is supported by pwrdm v2
Date: Tue, 18 Nov 2008 11:27:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811181126460.21683@utopia.booyaka.com>
References: <alpine.DEB.2.00.0811142026040.16502@utopia.booyaka.com> <1226909881-12415-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33061 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbYKRS1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 13:27:03 -0500
In-Reply-To: <1226909881-12415-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon, 17 Nov 2008, Jouni Hogander wrote:

> Check that wanted sleep state is supported by powerdomain. If it is
> not supported, then use next lowest supported state.
> 
> Check also on suspend that state of pwrdm was lower or equal.
> 
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>



- Paul
