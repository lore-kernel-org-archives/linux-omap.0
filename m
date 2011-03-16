From: Andy Green <andy@warmcat.com>
Subject: Re: [PATCH 3 00/18] I2C: OMAP1: OMAP2+: I2C fixes, removal of	cpu_is...
 from driver
Date: Wed, 16 Mar 2011 07:22:58 +0000
Message-ID: <4D806552.5040701@linaro.org>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com> <20110315222813.GL7258@atomide.com>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57852 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab1CPHXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 03:23:02 -0400
Received: by wya21 with SMTP id 21so1342978wya.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 00:23:00 -0700 (PDT)
In-Reply-To: <20110315222813.GL7258@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/15/2011 10:28 PM, Somebody in the thread at some point said:
> Hi,
>
> * Andy Green<andy@warmcat.com>  [110315 12:53]:
>> The following series removes cpu_...() usage completely from the
>> omap-i2c driver by having decisions about functional implementation
>> choices in the SoC held in cpu-specific hwmod tables that are
>> already established, or for OMAP1 where there is no hwmod, set at
>> OMAP1-specific i2c bus addition time.
>
> You should send this to the i2c list with Ben Cc'd.

Done... sorry for the fumble.  Ben is already CC'd, sorry for spamming 
his mailbox too.

-Andy
