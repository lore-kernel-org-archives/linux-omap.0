From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC] OMAP DT i2c aliases
Date: Mon, 2 Jun 2014 10:42:26 -0500
Message-ID: <538C9B62.9090404@ti.com>
References: <538B3877.70304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50247 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbaFBPmc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jun 2014 11:42:32 -0400
In-Reply-To: <538B3877.70304@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, sre@kernel.org

On 06/01/2014 09:28 AM, Ivaylo Dimitrov wrote:
> Hi,
> 
> patch https://lkml.org/lkml/2013/10/16/744 fixes DT i2c bus ids in case 
> of deferred probe and assigns id 0,1 and 2 for i2c buses 1,2 and 3. 
> Unfortunately, this breaks Maemo userspace on N900, where board code (in 
> case of legacy boot) assigns ids 1, 2 and 3, but with DT boot ids are 

ughh.. missed that :(

> 0,1 and 2. I've already send a patch https://lkml.org/lkml/2014/6/1/49 
> that will allow me to fix that from board .dts, but I was wondering if 
> it is the correct way, or ids should be changed in omap3.dtsi for all 
> omap devices.

Should'nt we retain 0,1,2 as indexing to make this consistent for all
SoCs?


-- 
Regards,
Nishanth Menon
