From: Kevin Hilman <khilman@ti.com>
Subject: Re: AM3517 boot failure
Date: Tue, 08 May 2012 06:50:35 -0700
Message-ID: <87pqaesrx0.fsf@ti.com>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
	<4F8FC572.80406@compulab.co.il>
	<alpine.DEB.2.00.1205072349540.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:46285 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754116Ab2EHNuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 09:50:21 -0400
Received: by dady13 with SMTP id y13so2936367dad.5
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 06:50:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205072349540.9984@utopia.booyaka.com> (Paul
	Walmsley's message of "Mon, 7 May 2012 23:50:27 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Thu, 19 Apr 2012, Igor Grinberg wrote:
>
>> IMO this can be seen on any AM35xx based board with EMAC, or am I mistaken?
>
> Just tested this on a 3517EVM and the same problem is there too.

Does adding nohlt on the cmdline make a difference?

The AM35x has known wakeup limitations, and nohlt would at least avoid
WFI to see if it's the wakeup problems that are the root cause here.

Kevin

