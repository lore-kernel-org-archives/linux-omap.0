From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5] gpio/omap: fix off-mode bug: clear debounce settings
 on free/reset
Date: Fri, 26 Oct 2012 16:42:24 -0500
Message-ID: <508B03C0.3080404@ti.com>
References: <1351279564-4591-1-git-send-email-jon-hunter@ti.com> <874nlhhqxt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41420 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933923Ab2JZVmc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Oct 2012 17:42:32 -0400
In-Reply-To: <874nlhhqxt.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, Grazvydas Ignotas <notasas@gmail.com>


On 10/26/2012 04:19 PM, Kevin Hilman wrote:
> Jon Hunter <jon-hunter@ti.com> writes:
> 
>> This change was originally titled "gpio/omap: fix off-mode bug: clear debounce
>> clock enable mask on free/reset". The title has been updated slightly to
>> reflect (what should be) the final fix.
> 
> nit: this kind of thing should typically go after the '---' since it's
> useful reviewers/maintainers but not necessarily in the permanant git
> history.

Thanks for the tip.

Linus, let me know if I should resend.

Cheers
Jon
