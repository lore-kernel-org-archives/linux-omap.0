From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v6 0/7] ARM: OMAP2+: PM: introduce the power domains
 functional states
Date: Thu, 13 Sep 2012 09:04:59 +0200
Message-ID: <CAORVsuVZ5AnsN9HYoXntMcF2Yc4VM3Mwk2bQBiGnV0=kdpMYfA@mail.gmail.com>
References: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
	<87har2rc9q.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34814 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab2IMHFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 03:05:01 -0400
Received: by lbbgj3 with SMTP id gj3so1732881lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 00:05:00 -0700 (PDT)
In-Reply-To: <87har2rc9q.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Jean Pihet <j-pihet@ti.com>

On Thu, Sep 13, 2012 at 2:34 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Here is a re-spin after some comments and suggestions after review
>> and discussions.
>>
>> Implement the functional states for the power domains:
>> - unify the API to use the functional states. The new API
>>   consists of the pwrdm_set*_fpwrst and pwrdm_read*_fpwrst
>>   functions and is the API to use to control the power domains
>>   power and logic states,
>> - reorganize the powerdomain API in internal and external parts,
>>   in powerdomain.h [1]
>> - protect the power domain state change by a lock in the
>>   functions that read and set the powerdomains next functional state,
>> - introduce the functional states for power domains power states and
>>   logic power states [2], and the conversion functions between the
>>   functional and internal states. The conversion functions are
>>   lightweight and generic. The power domains allowed states [3] are
>>   defined in the pwrsts and pwrsts_logic_ret fields of the struct
>>   powerdomain,
>> - program the logic power state of power domains from the functional
>>   states, in pwrdm_set*_fpwrst
>> - convert the OMAP2/3/4 PM code to use the updated API,
>> - provide the power domains statistics by functional states,
>> - provide ftrace tracepoints with the functional state,
>> - provide error logs in critical code, which makes the development
>>   easier.
>
> I just gave this series a round of PM testing.  I tested retention
> and off in idle & suspend, with and without CPUidle on 3430/n900,
> 3530/Overo, 3730/OveroSTORM, 3730/Beagle-xM and 4430/Panda (though only
> MPU/CPU ret/off is supported for OMAP4 in mainline.)
>
> All PM tests passed with flying colors.  Nice!
Great!

Thanks a lot Kevin for testing

Jean

>
> Kevin
