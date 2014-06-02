From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC] OMAP DT i2c aliases
Date: Mon, 2 Jun 2014 11:19:46 -0500
Message-ID: <538CA422.8000504@ti.com>
References: <538B3877.70304@gmail.com> <538C9B62.9090404@ti.com> <538CA04C.1070509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52019 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880AbaFBQTx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jun 2014 12:19:53 -0400
In-Reply-To: <538CA04C.1070509@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, sre@kernel.org

On Mon 02 Jun 2014 11:03:24 AM CDT, Ivaylo Dimitrov wrote:
[...]
>>> 0,1 and 2. I've already send a patch https://lkml.org/lkml/2014/6/1/49
>>> that will allow me to fix that from board .dts, but I was wondering if
>>> it is the correct way, or ids should be changed in omap3.dtsi for all
>>> omap devices.
>>
>> Should'nt we retain 0,1,2 as indexing to make this consistent for all
>> SoCs?
>>
>>
>
> I think this is the most sane thing, esp if the "alias replace" patch
> gets accepted(thus allowing us to workaround the problems on N900 and
> N9/50), however I wanted to hear from you on the matter. Esp that
> indexing is different with legacy boot compared to DT boot.

I think that slipped my check list unfortunately. :( But then, if we 
think that it is just n900 that is impacted, then I wonder if we can 
override the alias? just wondering..

--
Regards,
Nishanth Menon

