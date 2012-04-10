From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC] dt: export of_have_populated_dt
Date: Tue, 10 Apr 2012 18:29:45 +0200
Message-ID: <4F845FF9.5080005@ti.com>
References: <1334070672-11252-1-git-send-email-balajitk@ti.com> <4F845D99.7020705@ti.com> <87y5q3v9pd.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43015 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755616Ab2DJQaM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 12:30:12 -0400
In-Reply-To: <87y5q3v9pd.fsf@laptop.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, robherring2@gmail.com
Cc: Balaji T K <balajitk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, rnayak@ti.com, bigeasy@linutronix.de

Hi Chris,

On 4/10/2012 6:21 PM, Chris Ball wrote:
> Hi,
>
> On Tue, Apr 10 2012, Cousson, Benoit wrote:
>> Hi Balaji,
>>
>> On 4/10/2012 5:11 PM, Balaji T K wrote:
>>> If of_have_populated_dt is called from module, build fails with "allnodes"
>>> undefined error, so remove inline and export of_have_populated_dt.
>>
>> Is this function really called from the MMC driver?
>
> ~/git/linux % git grep of_have_populated_dt drivers/
> drivers/gpio/gpio-samsung.c:    if (!of_have_populated_dt())
> drivers/mmc/host/omap_hsmmc.c:  if (of_have_populated_dt()&&  !vdd)
> drivers/mmc/host/omap_hsmmc.c:                   (!of_have_populated_dt())) {

Gosh, twice... I should be in a wrong branch :-(

Then the next question to Rob...

Rob,
Does it make sense to use that in the driver? So far I was using that 
only in the arch code to make the difference between the DT boot and the 
non-DT boot.

I guess that a driver should rely on of_match_device or non-NULL 
device_node to figure out that?

Thanks,
Benoit
