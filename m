From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
Date: Tue, 27 Mar 2012 10:31:56 -0500
Message-ID: <4F71DD6C.5010305@ti.com>
References: <1332484600-21947-1-git-send-email-afzal@ti.com> <4F6D0569.6080203@ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317BB895@DBDE01.ent.ti.com> <4F70AA82.3000204@ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317BD6E2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33032 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754421Ab2C0PcG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 11:32:06 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317BD6E2@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Afzal,

On 3/27/2012 0:12, Mohammed, Afzal wrote:
> Hi Jon,
>
> On Mon, Mar 26, 2012 at 23:12:26, Hunter, Jon wrote:
>> Also, I don't see where the gpmc_child->res and gpmc_child->num_res are
>> actually used. Are these needed?
>
> These are for the peripheral resources not in control of GPMC, like
> gpio irq. These are copied in gpmc_create_child.

Right, I see they are copied during gpmc_create_child. However, I don't 
see where they are initialised before that. The function 
gpmc_setup_child is only initialising gpmc_res and gpmc_num_res and not 
res and num_res. So I still don't see who is initialising these before 
they are copied.

>>> Gpmc_device_data is dedicated to each CS, gpmc_pdata is required
>>> at least to inform driver about clock rate.
>>
>> Ok, understood! So the struct gpmc_device_pdata only has a single
>> chip-select entry and so looking at the code you will have multiple
>> instances of this structure of a gpmc device that uses more than one
>> chip-select. Any reason you did it this way and not have a single pdata
>> struct for each device defining all chip-selects it uses?
>
> When coding started, multiple CS for a peripheral was not taken into
> consideration, later handling multiple CS was incorporated making it
> this way. But your suggestion seems better to me, will see if code can
> modified accordingly in later patch series (v2 already sent)

Ok great. I will wait for your v3.

>>
>>> Generally, as the change involved moving a lot of code, seems more reviews
>>> are on those than the actual changes than what I intended to get reviewed,
>>> next patch series will be modified not to move existing code, hence some
>>> of your suggested changes may not be present in it, probably those to be
>>> done as another cleanup patch.
>>
>> Yes I understand. However, it is a good opportunity to clean some of
>> this up even if it is existing code :-)
>
> Ok

I see you did not incorporate any clean-up in v2. Do you want me to send 
you some patches to include?

Cheers
Jon
