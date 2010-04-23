From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v4 1/1] Registering sgx device and it's platform data
Date: Fri, 23 Apr 2010 21:46:07 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304D9C665@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044E1EB744@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1004230943370.29720@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40629 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805Ab0DWQQS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 12:16:18 -0400
In-Reply-To: <alpine.DEB.2.00.1004230943370.29720@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Agarwal, Preshit" <preshit.agarwal@ti.com>, "Azizoglu, Cemil" <c-azizoglu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Pais, Allen" <allen.pais@ti.com>, "Gunn, Kevin" <kgunn@ti.com>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Paul Walmsley
>Sent: Friday, April 23, 2010 10:45 AM
>To: Agarwal, Preshit
>Cc: linux-omap@vger.kernel.org; felipe.balbi@nokia.com; Pais, Allen
>Subject: Re: [PATCH v4 1/1] Registering sgx device and it's platform data
>
>On Thu, 22 Apr 2010, Agarwal, Preshit wrote:
>
>> In this patch SGX powervr_device is registered with it's platform
>specific
>> data to provide information about setting constraint through
>> omap_pm_set_min_bus_tput.
>> This patch removes the requirement of EXPORT_SYMBOL for the same
>function.
>>
>> Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
>
>Reviewed-by: Paul Walmsley <paul@pwsan.com>
>
>That's the right way to pass these function pointers.

Just to keep you posted, effort is happening on TI android kernel(.32) on integrating the sgx driver parts [1].

With user space still being non-GPL, not clear on the amount of functionality that can be enabled in upstream kernel.

But a good start though to converge on the out-of-tree gaps !!

Regards,
Vikram

[1] Internal tree references for sgx driver:
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=f33345b97ad528e8093cc4f865570a17024bbf85
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=d9a3d7884c05fb310ff3d937e846202843c7c437
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=bf6accefac104660ea9b8fc5e1a782a97793692e

>
>
>- Paul
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
