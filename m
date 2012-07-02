From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 07/29] mfd: omap-usb: use clk_prepare_enable and clk_disable_unprepare
Date: Mon, 02 Jul 2012 16:46:21 +0530
Message-ID: <4FF18305.2020301@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com> <1339678038-23082-8-git-send-email-rnayak@ti.com> <20120702111850.GC22065@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:34456 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751402Ab2GBLQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 07:16:41 -0400
Received: by obqv19 with SMTP id v19so3869149obq.2
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 04:16:26 -0700 (PDT)
In-Reply-To: <20120702111850.GC22065@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Samuel,

On Monday 02 July 2012 04:48 PM, Samuel Ortiz wrote:
> Hi Rajendra,
>
> On Thu, Jun 14, 2012 at 06:16:56PM +0530, Rajendra Nayak wrote:
>> As we move to Common clk framework use clk_prepare_enable()
>> instead of clk_enable() and similarly clk_disable_unprepare()
>> instead of clk_disable()
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Cc: Samuel Ortiz<sameo@linux.intel.com>
>> ---
>>   drivers/mfd/omap-usb-host.c |   28 ++++++++++++++--------------
>>   1 files changed, 14 insertions(+), 14 deletions(-)
> Patch applied, many thanks.

Sorry, I was asked to base these changes on top of work done by
Keshava [1], to split the driver, which is still under review/not
pulled.
I am waiting for those to settle to repost these changes.
Can you please drop this one for now?
Sorry for the confusion.

regards,
Rajendra

[1] http://permalink.gmane.org/gmane.linux.ports.arm.omap/79306

>
> Cheers,
> Samuel.
>

