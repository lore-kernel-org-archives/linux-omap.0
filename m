From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Tue, 13 Aug 2013 11:30:40 -0700
Message-ID: <CA+Bv8Xbg9v4zRy-EJPsxwCdwpSy50V8SjwQfmAvVxiCR=6mYBw@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-3-git-send-email-d-gerlach@ti.com>
	<5203A0BC.8060205@ti.com>
	<5203C457.80301@ti.com>
	<20130809051146.GB7656@atomide.com>
	<52055733.70808@ti.com>
	<87y586pvkq.fsf@kernel.org>
	<5209565C.7090508@ti.com>
	<87d2phpsu1.fsf@kernel.org>
	<520A4BE7.7090603@ti.com>
	<87wqnplg1n.fsf@kernel.org>
	<520A785C.3000304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:33139 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757453Ab3HMSal (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 14:30:41 -0400
Received: by mail-qa0-f42.google.com with SMTP id bv4so503076qab.1
        for <linux-omap@vger.kernel.org>; Tue, 13 Aug 2013 11:30:40 -0700 (PDT)
In-Reply-To: <520A785C.3000304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

>>> ARM world is also moving towards that by standardizing some of these
>>> through (read PSCI) and thats the way to go in general.
>>
>> Agreed, but I'm not sure (yet) about enforcing PSCI on legacy platforms
>> that don't support it natively.  Are you saying that the AM33xx firmware
>> should be converted to be PSCI compliant?  Admittedly, I haven't read
>> the PSCI spec closely, but I'm wondering if the current role splitting
>> between MPU and M3 fits well with PSCI.
>>
> I didn't mean for the AM3XXX specifically because its current job is rather
> very limited. i.e suspend. My concern is that IPC is not viewed as
> an option for power management controllers like M3 which can abstract
> all the hardware gory details and export a simpled interface for OS
> in form of PSCI/ACPI.

The IPC between the M3 and the A8 on the am335x is just a pair of
notification mechanisms (one from the A8, mailbox, and one from the
M3, sev) and a set of 8 32 bit registers. The 8 32 bit registers are
just a scratchpad and have no access rules or functionality beyond
being a scratchpad. How complicated do we want to make this?
