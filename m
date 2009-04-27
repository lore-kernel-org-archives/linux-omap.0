From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 0/2] I2C: OMAP: spurious IRQ fixes
Date: Mon, 27 Apr 2009 14:56:57 +0300
Message-ID: <49F59D89.3030008@nokia.com>
References: <20090426042504.31316.68357.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48757 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbZD0L5S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 07:57:18 -0400
In-Reply-To: <20090426042504.31316.68357.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

Paul Walmsley wrote:
> It seems to work: under constant I2C load, no spurious IRQ messages
> showed up after several hours of testing.  (Without these patches,
> spurious IRQs usually show up in a few minutes.)  Some of the code has
> also been cleaned up.
> 
> Any feedback on how this series works for others is appreciated.
> 
> Tested on N800, Beagle and 3430SDP.

With these patches I'm getting receive overruns quite easily on rx51 when doing large reads from TWL4030 RTC.

A.
