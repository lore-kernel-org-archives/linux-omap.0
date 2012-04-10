From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC] dt: export of_have_populated_dt
Date: Tue, 10 Apr 2012 12:20:27 -0500
Message-ID: <4F846BDB.8020805@gmail.com>
References: <1334070672-11252-1-git-send-email-balajitk@ti.com> <4F845D99.7020705@ti.com> <87y5q3v9pd.fsf@laptop.org> <4F845FF9.5080005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34467 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2DJRUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 13:20:31 -0400
Received: by obbtb18 with SMTP id tb18so37322obb.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 10:20:30 -0700 (PDT)
In-Reply-To: <4F845FF9.5080005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, rnayak@ti.com, bigeasy@linutronix.de

On 04/10/2012 11:29 AM, Cousson, Benoit wrote:
> Hi Chris,
> 
> On 4/10/2012 6:21 PM, Chris Ball wrote:
>> Hi,
>>
>> On Tue, Apr 10 2012, Cousson, Benoit wrote:
>>> Hi Balaji,
>>>
>>> On 4/10/2012 5:11 PM, Balaji T K wrote:
>>>> If of_have_populated_dt is called from module, build fails with
>>>> "allnodes"
>>>> undefined error, so remove inline and export of_have_populated_dt.
>>>
>>> Is this function really called from the MMC driver?
>>
>> ~/git/linux % git grep of_have_populated_dt drivers/
>> drivers/gpio/gpio-samsung.c:    if (!of_have_populated_dt())
>> drivers/mmc/host/omap_hsmmc.c:  if (of_have_populated_dt()&&  !vdd)
>> drivers/mmc/host/omap_hsmmc.c:                  
>> (!of_have_populated_dt())) {
> 
> Gosh, twice... I should be in a wrong branch :-(
> 
> Then the next question to Rob...
> 
> Rob,
> Does it make sense to use that in the driver? So far I was using that
> only in the arch code to make the difference between the DT boot and the
> non-DT boot.
> 
> I guess that a driver should rely on of_match_device or non-NULL
> device_node to figure out that?
> 

Agreed. of_match_device or device_node ptr check is the right approach.

Rob

> Thanks,
> Benoit

