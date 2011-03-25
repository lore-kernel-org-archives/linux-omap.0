From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: VC: add SoC-specific op for PMIC register addresses
Date: Fri, 25 Mar 2011 07:22:35 -0700
Message-ID: <87vcz7wa8k.fsf@ti.com>
References: <87lj04xe2t.fsf@ti.com>
	<1301011795-6754-2-git-send-email-khilman@ti.com>
	<7160431ff9b8190947a0b0473d7b74ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:43741 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753006Ab1CYOXD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 10:23:03 -0400
Received: by pvg7 with SMTP id 7so144933pvg.9
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 07:22:38 -0700 (PDT)
In-Reply-To: <7160431ff9b8190947a0b0473d7b74ad@mail.gmail.com> (Vishwanath
	Sripathy's message of "Fri, 25 Mar 2011 15:01:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Friday, March 25, 2011 5:40 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Paul Walmsely; Benoit Cousson
>> Subject: [PATCH] OMAP2+: VC: add SoC-specific op for PMIC register
>> addresses
>>
>> Add a new SoC-specific operation for setting PMIC register addresses
>> in the VC for the voltage configuration register and command
>> configuration register.
>>
>> Some PMICs use a single register for voltage configuration and
>> on/retention/off commands, others use separate registers.  This patch
>> adds a VC operation for setting these registers.  The voltage
>> configuration register is required, and the command register may
>> optionally be zero, meaning it is not used.  The command register
>> address is only written to the VC if it is non-zero.
>
> What about PRM_VC_VAL_BYPASS register? If a PMIC is connected via only
> sr-i2c, then PMIC can be configured only via this register. Shouldn't it
> be abstracted as part of this patch or patch series?

Yes.

So far this series just splits out the setting of the slave address and
the PMIC register addresses.  Once we are happy with this approach
(hence the RFC patches) I will continue splitting out the other
functionality in a similar way.

Kevin

 
