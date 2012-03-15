From: Aneesh V <aneesh@ti.com>
Subject: Re: [PATCH v2 0/7] Add TI EMIF SDRAM controller driver
Date: Fri, 16 Mar 2012 01:31:15 +0530
Message-ID: <4F624A8B.7040407@ti.com>
References: <1331835457-5390-1-git-send-email-aneesh@ti.com> <20120315190444.GE11142@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41146 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031929Ab2COUBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 16:01:23 -0400
Received: by mail-pz0-f42.google.com with SMTP id g27so5224526dan.15
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 13:01:23 -0700 (PDT)
In-Reply-To: <20120315190444.GE11142@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 16 March 2012 12:34 AM, Greg KH wrote:
> On Thu, Mar 15, 2012 at 11:47:30PM +0530, Aneesh V wrote:
>> Add a driver for the EMIF SDRAM controller used in TI SoCs
>>
>> EMIF is an SDRAM controller that supports, based on its revision,
>> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
>> for LPDDR2.
>>
>> The driver supports the following features:
>> - Calculates the DDR AC timing parameters to be set in EMIF
>>    registers using data from the device data-sheets and based
>>    on the DDR frequency. If data from data-sheets is not available
>>    default timing values from the JEDEC spec are used. These
>>    will be safe, but not necessarily optimal
>> - API for changing timings during DVFS or at boot-up
>
> Is this a kernel/user API, or just an in-kernel API?

That's just an in-kernel API or more precisely callbacks to be
registered for DDR frequency change events.

thanks,
Aneesh
