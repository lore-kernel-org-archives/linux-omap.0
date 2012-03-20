From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 0/3] SPI updates
Date: Tue, 20 Mar 2012 22:12:46 +0530
Message-ID: <4F68B386.9050307@ti.com>
References: <1332239389-1897-1-git-send-email-shubhrajyoti@ti.com> <20120320162019.33AC83E2834@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:49278 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750953Ab2CTQm6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 12:42:58 -0400
Received: by mail-pz0-f45.google.com with SMTP id p14so286064dad.4
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 09:42:57 -0700 (PDT)
In-Reply-To: <20120320162019.33AC83E2834@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general@lists.sourceforge.net, Shubhrajyoti@ponder.secretlab.ca, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 20 March 2012 09:50 PM, Grant Likely wrote:
> On Tue, 20 Mar 2012 15:59:46 +0530, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
>> The patch series does the following cleanups
>> - Converts the spi to module_platform_driver
>> - Use the devm functions so that the freeing need not 
>>   be done in the driver.
>>
>> This is also available through
>> git     : git://gitorious.org/linus-tree/linus-tree.git
>> branch  : spi
>>
>>
>> Felipe Balbi (2):
>>   spi: omap2-mcspi: make it behave as a module
>>   spi: omap2-mcspi: convert to module_platform_driver
>>
>> Shubhrajyoti D (1):
>>   spi: omap2-mcspi: use devm_* functions
>>
>>  drivers/spi/spi-omap2-mcspi.c |   46 ++++++++---------------------------------
>>  1 files changed, 9 insertions(+), 37 deletions(-)
> Merged for v3.5 (it's too late for v3.4)
>
> g.
Thanks Grant.

