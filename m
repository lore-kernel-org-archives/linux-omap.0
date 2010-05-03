From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 03 May 2010 09:07:23 +0300 (EEST)
Message-ID: <20100503.090723.48519047.Hiroshi.DOYU@nokia.com>
References: <1272815071-2827-1-git-send-email-ohad@wizery.com>
	<1272815071-2827-5-git-send-email-ohad@wizery.com>
	<20100503.083036.59656495.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32521 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab0ECGHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:07:32 -0400
In-Reply-To: <20100503.083036.59656495.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 03 May 2010 08:30:36 +0300 (EEST)

> Hi Ohad,
> 
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: [PATCH v2 4/4] omap: mailbox: convert block api to kfifo
> Date: Sun, 2 May 2010 17:44:31 +0200
> 
>> The underlying buffering implementation of mailbox
>> is converted from block API to kfifo due to the simplicity
>> and speed of kfifo.
>> 
>> The default size of the kfifo buffer is set to 256 bytes.
>> This value is configurable at compile time (via
>> CONFIG_OMAP_MBOX_KFIFO_SIZE), and can be changed at
>> runtime (via the omap_kfifo_size module parameter).
> 
> mbox_kfifo_size?

It may be also nice if there's some checking of 'mbox_kfifo_size % 4 == 0' along with 'CONFIG_OMAP_MBOX_KFIFO_SIZE % 4 == 0'?

> 
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> ---
>> If you want, you can also reach me at < ohadb at ti dot com >.
>> 
>>  arch/arm/plat-omap/Kconfig                |    9 +++
>>  arch/arm/plat-omap/include/plat/mailbox.h |    4 +-
>>  arch/arm/plat-omap/mailbox.c              |  107 +++++++++++++----------------
>>  3 files changed, 58 insertions(+), 62 deletions(-)
