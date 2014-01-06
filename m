From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: omap4 and cpufreq
Date: Mon, 6 Jan 2014 23:24:09 +0100
Message-ID: <CAGhQ9VztnCPWpyN-yMkjLMPuW3Nk1PR5mEzVdjaAKbmwkW+3Lg@mail.gmail.com>
References: <CAGhQ9Vzx-WyCHUurK-2vxS0i_T3SCGGnhq3FfKGhGzbMCeYAqA@mail.gmail.com>
	<52CAD9C2.2020307@ti.com>
	<CAGhQ9Vy1mja7-F0a4v9gBQ5naPmRoxNv6GZgjqZ30dhVfD7q8w@mail.gmail.com>
	<52CB27E0.6080408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:42025 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaAFWYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jan 2014 17:24:10 -0500
Received: by mail-vb0-f47.google.com with SMTP id m10so3311895vbh.34
        for <linux-omap@vger.kernel.org>; Mon, 06 Jan 2014 14:24:09 -0800 (PST)
In-Reply-To: <52CB27E0.6080408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org

On 6 January 2014 23:02, Nishanth Menon <nm@ti.com> wrote:
> On 01/06/2014 03:51 PM, Joachim Eastwood wrote:
>> On 6 January 2014 17:28, Nishanth Menon <nm@ti.com> wrote:
>>> On 01/01/2014 04:37 PM, Joachim Eastwood wrote:
> [...]
>>>> I assume this would work but I don't have a 4430 board to test it on.
>>>> Unsure about voltage range, but at least 1.0 to 1.4V covers the operation
>>>> points for cpu in omap443xx.dtsi.
>>> This will not work. 6030 does not allow voltage to be set over i2c1,
>>> needs voltage controller/processor to work.
>>
>> Well, it allows the LDO regulators to be changed over i2c, but I guess
>> the SMPS regulators are different.
>
> yes, they are different control paths. To give a relative history:
>
> (OMAP3)TWL5030 -> we can control SMPS from either i2c1 OR i2c_SR by
> flipping a control bit - but only one path at a time.
> (OMAP4)TWL6030 -> only i2c_SR control allowed for SMPS
> (OMAP5)Palmas family -> we can control using i2c1 or i2c_SR -> so no
> real need for using voltage controller for SMPS.
>
> that said, it is necessary to use SR path to ensure that AVS also
> functions. which requires on OMAP4,3 to use i2c_SR.

I see.

Just one question regarding the tps63261 on 4460.
What good is the gpio pin most boards have connected to the tps
regulator (vsel1) when it can be controlled with i2c_SR?

I have seen the pin being used in the u-boot code. So is it just for
initial boot or would Linux also use it as well?

>>
>> Anyways, thanks for the information and bugzilla link with links to
>> the patch postings on the mailing list.
>
> Glad to be of help.

Thanks a lot.

I'll go read up on all the patches you posted.

Good luck with the upstreaming effort :)

regards
Joachim Eastwood
