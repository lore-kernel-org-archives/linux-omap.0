From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC] omap: hwspinlock: Added hwspinlock driver
Date: Sun, 27 Jun 2010 12:28:47 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D9E40C@dbde02.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167E8@dbde02.ent.ti.com>,<F39349C6FA641B4A831B7BF4EBF4D4E14728E5B3@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38848 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab0F0G65 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Jun 2010 02:58:57 -0400
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E14728E5B3@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

( Using Web-mail so please excuse me for the email format)
________________________________________
From: Que, Simon
Sent: Friday, June 25, 2010 3:31 PM
To: Shilimkar, Santosh; linux-omap@vger.kernel.org
Cc: Kanigeri, Hari; Ohad Ben-Cohen
Subject: RE: [RFC] omap: hwspinlock: Added hwspinlock driver

>Santosh,

>> This reservation KCONFIG isn't necessary. HWSPINLOCK IP is not really for
>> very generic use
>> but specific usages where you need to protect the data between independent
>> softwares
>>running on different masters.
>>For other Linux only side software even with dual core, kernel spinlock
>>library
>>is sufficient.

>We will consider this.
>> Are you building this for all OMAP's ??

>>Move this base address to plat/omap44xx.h and use it from there

>>" OMAP2_L4_IO_ADDRESS" this should not be used anymore. Rather, use
>>"ioremap and readl/writel"

>Good points, we'll implement these.

>> Why do you have two files ? This IP is not part of OMAP1 and all the code
>> can
>> go in mach-omap and can be exported from there.

>Are you suggesting we use a library approach instead of a driver approach?  We want to make this expandable in the future.  If something in the underlying hardware changes with OMAP5, OMAP6, etc, we only need to update the device >initialization file.  The driver can remain unchanged.

No I am not suggesting the library approach. What you have done is correct except that "you should just make it as early platform driver" using HWMOD. This
isn't so difficult considering you have already created a platform driver. Only the initializations part will change. HW spin-lock doesn't have any direct clock control
so it's even simpler.

Regards
Santosh

