From: Nishanth Menon <nm@ti.com>
Subject: Re: [pandaboard] omap-aes L3 standard error
Date: Tue, 3 Dec 2013 19:45:52 -0600
Message-ID: <529E8950.4030209@ti.com>
References: <529E47B5.60900@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37805 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146Ab3LDBpz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Dec 2013 20:45:55 -0500
In-Reply-To: <529E47B5.60900@math.uni-bielefeld.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-omap@vger.kernel.org

On 12/03/2013 03:05 PM, Tobias Jakobi wrote:
> Hello,
> 
> here a newly introduced one:
> https://bugzilla.kernel.org/show_bug.cgi?id=66441

[1] solves the issue

However, digging further, the root of the crash starts here:
"platform 4b501000.aes: Cannot lookup hwmod 'aes'"
with this, the following happens:
a) omap_device does not register a pm_domain (since it cannot find
hwmod entry).
b) driver does not know about (a), does a pm_runtime_get_sync which
never fails
c) tries to read the revision register (as part of probe) without clock.
generates the issue mentioned above.


Now, there are three issues here:
a) hwmod entries are not present -> this is addressed in [1]
b) omap_device pm_domain is not handled - fixed in [2]
c) aes driver needs to handle error case when pm_runtime_get_sync
fails. addressed in [3].

[1] http://marc.info/?l=linux-kernel&m=138541593010221&w=2 +
http://marc.info/?l=linux-kernel&m=138541603810300&w=2

[2] https://patchwork.kernel.org/patch/3280531/
[3] https://patchwork.kernel.org/patch/3280571/

-- 
Regards,
Nishanth Menon
