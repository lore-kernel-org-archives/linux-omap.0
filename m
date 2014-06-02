From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [RFC] OMAP DT i2c aliases
Date: Mon, 02 Jun 2014 19:03:24 +0300
Message-ID: <538CA04C.1070509@gmail.com>
References: <538B3877.70304@gmail.com> <538C9B62.9090404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35473 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbaFBQD2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2014 12:03:28 -0400
Received: by mail-wg0-f45.google.com with SMTP id m15so5280089wgh.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Jun 2014 09:03:27 -0700 (PDT)
In-Reply-To: <538C9B62.9090404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, sre@kernel.org



On  2.06.2014 18:42, Nishanth Menon wrote:
> On 06/01/2014 09:28 AM, Ivaylo Dimitrov wrote:
>> Hi,
>>
>> patch https://lkml.org/lkml/2013/10/16/744 fixes DT i2c bus ids in case
>> of deferred probe and assigns id 0,1 and 2 for i2c buses 1,2 and 3.
>> Unfortunately, this breaks Maemo userspace on N900, where board code (in
>> case of legacy boot) assigns ids 1, 2 and 3, but with DT boot ids are
>
> ughh.. missed that :(
>
>> 0,1 and 2. I've already send a patch https://lkml.org/lkml/2014/6/1/49
>> that will allow me to fix that from board .dts, but I was wondering if
>> it is the correct way, or ids should be changed in omap3.dtsi for all
>> omap devices.
>
> Should'nt we retain 0,1,2 as indexing to make this consistent for all
> SoCs?
>
>

I think this is the most sane thing, esp if the "alias replace" patch 
gets accepted(thus allowing us to workaround the problems on N900 and 
N9/50), however I wanted to hear from you on the matter. Esp that 
indexing is different with legacy boot compared to DT boot.
