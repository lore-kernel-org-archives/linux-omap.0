From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from
 the driver
Date: Tue, 19 Mar 2013 12:03:33 +0530
Message-ID: <514806BD.2090808@ti.com>
References: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com> <87sj4rqa7r.fsf@linaro.org> <5124EF59.5080206@ti.com> <51419A3D.1000703@ti.com> <20130319001105.GA13449@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59465 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988Ab3CSGcA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 02:32:00 -0400
In-Reply-To: <20130319001105.GA13449@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Hilman <khilman@linaro.org>, linux-omap@vger.kernel.org, rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

On Tuesday 19 March 2013 05:41 AM, Greg Kroah-Hartman wrote:
> On Thu, Mar 14, 2013 at 03:07:01PM +0530, Santosh Shilimkar wrote:
>> (Looping Greg KH.)
>>
>> Greg,
>>

[..]

>>>
>> Sorry for not CC'ing first place
>> The subject patch is part of the series which cleans up the slave
>> idle handling from OMAP serial driver. It will be best to queue
>> it along with rest of the patches with your ack on $subject patch.
>>
>> Here is the updated version which also removed the hooks
>> from 'linux/platform_data/serial-omap.h' as per Kevin suggestion.
>>
>> >From 92916b8e0d895962c88fefbf99284967a4b94426 Mon Sep 17 00:00:00 2001
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Date: Fri, 15 Feb 2013 15:50:37 +0530
>> Subject: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from the
>>  driver
>>
>> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
>> so remove the hackery from the driver.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
>> Signed-off-by: Rajendra nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
Thanks Greg !!

Regards,
Santosh
