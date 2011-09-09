From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 11/25] OMAP: Add Secure HAL and monitor mode API infrastructure.
Date: Fri, 09 Sep 2011 09:52:30 +0530
Message-ID: <4E699486.2080504@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-12-git-send-email-santosh.shilimkar@ti.com> <CAORVsuX5ovK2X8cMGijywAAhOB+ymDze1SzgzVWV2hnZYcswAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37377 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752138Ab1IIEWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 00:22:37 -0400
Received: by mail-gw0-f53.google.com with SMTP id 20so949852gwj.40
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 21:22:36 -0700 (PDT)
In-Reply-To: <CAORVsuX5ovK2X8cMGijywAAhOB+ymDze1SzgzVWV2hnZYcswAQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com

On Friday 09 September 2011 12:28 AM, Jean Pihet wrote:
> Santosh,
>
> On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> On OMAP secure/emulation devices, certain APIs are exported by secure
>> code. Add an infrastructure so that relevant operations on secure
>> devices can be implemented using it.
>>
>> While at this, omap44xx-smc.S to omap-smc.S since the common APIs
>> can be used on other OMAP's too.
> 'move' or 'rename' is missing in the sentence.
>
Yep. Will fix it.

Regards
Santosh
