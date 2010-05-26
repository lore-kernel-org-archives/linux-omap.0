From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH V2] misc : ROHM BH1780GLI Ambient light sensor Driver
Date: Wed, 26 May 2010 16:42:18 +0530 (IST)
Message-ID: <23686.10.24.255.18.1274872338.squirrel@dbdmail.itg.ti.com>
References: <39216.10.24.255.17.1274699066.squirrel@dbdmail.itg.ti.com>
    <4428.10.24.255.17.1274862635.squirrel@dbdmail.itg.ti.com>
    <4BFCEC43.3080205@jic23.retrosnub.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42959 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083Ab0EZLMi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 May 2010 07:12:38 -0400
In-Reply-To: <4BFCEC43.3080205@jic23.retrosnub.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kernel@jic23.retrosnub.co.uk

----- Original Message -----
From: "Jonathan Cameron"
> On 05/26/10 09:30, Hemanth V wrote:
>>> From: Hemanth V <hemanthv@ti.com>
>>> Date: Fri, 21 May 2010 15:52:03 +0530
>>> Subject: [PATCH] misc: ROHM BH1780GLI Ambient light sensor Driver
>>>
>>> This patch adds support for ROHM BH1780GLI Ambient light sensor.
>>>
>>> BH1780 supports I2C interface. Driver supports read/update of power state and
>>> read of lux value (through SYSFS). Writing value 3 to power_state enables the
>>> sensor and current lux value could be read.
>>>
>> Jonathan, Daniel
>>
>> If there are no more comments, do you know howto push this to linus tree.

> It's in misc, so send a copy (with reference back to review thread)
> to Andrew Morton <akpm@linux-foundation.org>
>
> Andrew tends to pick things up eventually for lkml, but he'll notice
> it quicker if you cc him in on relevant emails!
>

Andrew,

Could you pull the patch listed in https://patchwork.kernel.org/patch/101860/

This is version 2 of the patch. Review comments and discussion are listed part
of https://patchwork.kernel.org/patch/101396/

Thanks
Hemanth


