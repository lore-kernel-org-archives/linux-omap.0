From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH 2/2] OMAP: remove OMAP_TAG_UART
Date: Fri, 07 Aug 2009 16:27:53 +0300
Message-ID: <4A7C2BD9.9050500@nokia.com>
References: <20090807051516.4787.36125.stgit@tikku>	<20090807051650.4787.84433.stgit@tikku>	<FCCFB4CDC6E5564B9182F639FC35608702F5988C18@dbde02.ent.ti.com> <87tz0kma8y.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47490 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786AbZHGN23 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 09:28:29 -0400
In-Reply-To: <87tz0kma8y.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kalle Valo <kalle.valo@iki.fi>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Kalle Valo wrote:
> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
> 
>>> Omap tags are deprecrated and convert all OMAP_TAG_UART cases to use
>>> omap_uart_platform_data instead.
>>>
>>> Tested on rx51 and n8x0. Compile tested on omap_osk_5912.
>>>
>>> Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
>> Any plans to remove OMAP_TAG_LCD
> 
> I don't have any plans, but I don't know about others.
> 

I'm working on getting rid off OMAP_TAG_LCD. Will post a patch soon.

-roger
