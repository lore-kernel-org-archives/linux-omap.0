From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 02/12] omap: mcbsp: Remove rx_/tx_word_length variables
Date: Thu, 7 Jul 2011 12:08:39 -0700
Message-ID: <20110707190838.GO5783@atomide.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
 <1309510356-27147-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55952 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755380Ab1GGTIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 15:08:42 -0400
Content-Disposition: inline
In-Reply-To: <1309510356-27147-3-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Jarkko Nikula <jhnikula@gmail.com> [110701 01:48]:
> These variables got unused after ("omap: mcbsp: Drop in-driver transfer
> support") but was noticed only afterwards.

I'll queue this and the one after this into cleanup.

Regards,

Tony
