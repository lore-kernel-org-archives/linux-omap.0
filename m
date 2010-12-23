From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Last OMAP4 hwmod data cleanup for 2.6.38
Date: Thu, 23 Dec 2010 15:02:31 +0100
Message-ID: <4D135677.1080200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42285 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681Ab0LWOCj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 09:02:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, kevin Hilman <khilman@deeprootsystems.com>

Hi Tony,

The merge of both SDMA series from Manju and SR series from Thara 
changed the expected order of the hwmod data structures for OMAP4.
In order to have a clean base for 2.6.38, and to avoid starting 2.6.39 
with a cleanup patch again, I'd like to fix that right now.
Even if, I do agree, this is not a big deal.

I squeezed the 3 original small fixes I did (SDMA, SR and alignment) 
into one to avoid overloading your mailbox 2 days before Xmas.

The patch will be available here, based on omap-for-linus.
git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_fixes

It should not affect any functionality, and it is boot tested on 
OMAP4430/sdp.

Thanks,
Benoit
