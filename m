From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH] iommu: fix end address of vm area comparation in
 alloc_iovm_area
Date: Tue, 17 Aug 2010 01:08:04 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CA4D894D@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CA4D8949@dlee06.ent.ti.com>
	<496565EC904933469F292DDA3F1663E602CA4D894C@dlee06.ent.ti.com>,<20100817.082706.39158708.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100817.082706.39158708.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
List-Id: linux-omap@vger.kernel.org


>From: Hiroshi DOYU [Hiroshi.DOYU@nokia.com]
>Sent: Tuesday, August 17, 2010 12:27 AM
>To: Guzman Lugo, Fernando
>Cc: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org; Kanigeri=
, Hari
>Subject: Re: [PATCH] iommu: fix end address of vm area comparation in =
alloc_iovm_area
>
>From: "ext Guzman Lugo, Fernando" <fernando.lugo@ti.com>
>Subject: RE: [PATCH] iommu: fix end address of vm area comparation in =
alloc_iovm_area
>Date: Tue, 17 Aug 2010 06:48:14 +0200
>
>> From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel=
=2Eorg] On Behalf Of Guzman Lugo, Fernando [fernando.lugo@ti.com]
>> Sent: Monday, August 16, 2010 10:51 PM
>> To: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Hiroshi.DOYO@nokia.com; Kanigeri, Hari
>> Subject: [PATCH] iommu: fix end address of vm area comparation in al=
loc_iovm_area
>>
>> From cc48c0adaee97c8385a356aefa5b64a51818b4fd Mon Sep 17 00:00:00 20=
01
>> From: Fernando Guzman Lugo <x0095840@ti.com>
>> Date: Mon, 16 Aug 2010 22:28:24 -0500
>> Subject: [PATCH] iommu: fix end address of vm area comparation in al=
loc_iovm_area
>>
>> End address of the vm area is =93start + bytes -1=94,
>> not =93start + byte=94. This patch fixes that issue by doing
>> an inclusive comparison with tmp->da_start. This issue
>> was preventing allocate an area of size exactly the same
>> than the free area. I did no change the value of da_end
>> of each vm area because it is used to get area size in
>> several places.
>
>Ok for me. Is this patch against the latest?

not it isn't, but I don't think it could have issues applying. However =
I will resend it, base against the latest and include you ack.

Regards,
=46ernando.
