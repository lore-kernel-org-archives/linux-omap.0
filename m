From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 07/11] OMAP3: PM: Adding T2 enabling of smartreflex support
Date: Wed, 29 Sep 2010 16:16:06 -0700
Message-ID: <87r5gcqgy1.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-8-git-send-email-thara@ti.com>
	<87aan19zt4.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035E1739F6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54841 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0I2XQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 19:16:09 -0400
Received: by pxi10 with SMTP id 10so321078pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 16:16:09 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035E1739F6@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Wed, 29 Sep 2010 20:11:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> This patch adds support in the twl4030 driver to hook up
>>>> the API enabling smartreflex support on PMIC side with the
>>>> smartreflex driver. Without this the OMAP smartreflex modules
>>>> will not function.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>
>>>This one should be a separate patch with a subject something like
>>>
>>>     mfd: twl4030: add SmartReflex support
>>>
>>>and the changelog should indicate its dependency on this SR/voltage
>>>series.
>
> Do you mean to say this patch should not be a part of this series at all ??
>

Yes, as it will need to be merged via the mfd tree once the SR core is
merged.

Kevin
