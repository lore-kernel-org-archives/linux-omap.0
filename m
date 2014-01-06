From: Nishanth Menon <nm@ti.com>
Subject: Re: omap4 and cpufreq
Date: Mon, 6 Jan 2014 16:02:08 -0600
Message-ID: <52CB27E0.6080408@ti.com>
References: <CAGhQ9Vzx-WyCHUurK-2vxS0i_T3SCGGnhq3FfKGhGzbMCeYAqA@mail.gmail.com>	<52CAD9C2.2020307@ti.com> <CAGhQ9Vy1mja7-F0a4v9gBQ5naPmRoxNv6GZgjqZ30dhVfD7q8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40495 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699AbaAFWCN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jan 2014 17:02:13 -0500
In-Reply-To: <CAGhQ9Vy1mja7-F0a4v9gBQ5naPmRoxNv6GZgjqZ30dhVfD7q8w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-omap@vger.kernel.org

On 01/06/2014 03:51 PM, Joachim Eastwood wrote:
> On 6 January 2014 17:28, Nishanth Menon <nm@ti.com> wrote:
>> On 01/01/2014 04:37 PM, Joachim Eastwood wrote:
[...]
>>> I assume this would work but I don't have a 4430 board to test it on.
>>> Unsure about voltage range, but at least 1.0 to 1.4V covers the operation
>>> points for cpu in omap443xx.dtsi.
>> This will not work. 6030 does not allow voltage to be set over i2c1,
>> needs voltage controller/processor to work.
> 
> Well, it allows the LDO regulators to be changed over i2c, but I guess
> the SMPS regulators are different.

yes, they are different control paths. To give a relative history:

(OMAP3)TWL5030 -> we can control SMPS from either i2c1 OR i2c_SR by
flipping a control bit - but only one path at a time.
(OMAP4)TWL6030 -> only i2c_SR control allowed for SMPS
(OMAP5)Palmas family -> we can control using i2c1 or i2c_SR -> so no
real need for using voltage controller for SMPS.

that said, it is necessary to use SR path to ensure that AVS also
functions. which requires on OMAP4,3 to use i2c_SR.

> 
> 
> 
> Anyways, thanks for the information and bugzilla link with links to
> the patch postings on the mailing list.

Glad to be of help.

-- 
Regards,
Nishanth Menon
