From: Aneesh V <aneesh@ti.com>
Subject: Re: [PATCH 0/8] Add TI EMIF SDRAM controller driver
Date: Fri, 09 Mar 2012 09:29:36 +0530
Message-ID: <4F598028.5020509@ti.com>
References: <1331222065-3579-1-git-send-email-aneesh@ti.com> <20120308205944.GB16644@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:52135 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756473Ab2CID7n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 22:59:43 -0500
Received: by mail-iy0-f180.google.com with SMTP id e36so1645712iag.25
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 19:59:42 -0800 (PST)
In-Reply-To: <20120308205944.GB16644@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Friday 09 March 2012 02:29 AM, Greg KH wrote:
> On Thu, Mar 08, 2012 at 09:24:17PM +0530, Aneesh V wrote:
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
>> - Temperature alert configuration and handling of temperature
>>    alerts, if any for LPDDR2 devices
>>    * temperature alert is based on periodic polling of MR4 mode
>>      register in DDR devices automatically performed by hardware
>>    * timings are de-rated and brought back to nominal when
>>      temperature raises and falls respectively
>> - Cache of calculated register values to avoid re-calculating
>>    them
>>
>> The driver will need some minor updates when it is eventually
>> integrated with Dynamic Voltage and Frequency Scaling (DVFS).
>> This can not be done now as DVFS support is not available in
>> the mainline yet.
>
> What will need to be updated in it?  The userspace interface or
> something else?

The driver will need to register notifiers with regulator framework and
clock framework respectively for voltage and frequency notifications.
Also a hook will be needed for initiating the hardware sequence for
updating the AC timings. This process is under the control of Power
Reset and Clock Management(PRCM) module of OMAP.

>
> Why not wait until that code is accepted, it should be going into 3.4,
> right?

As Paul mentioned Core DVFS may take longer time. Besides, EMIF driver
is a pre-requisite for correct functioning of Core DVFS.

thanks,
Aneesh
