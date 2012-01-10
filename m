From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 09/10] arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
Date: Tue, 10 Jan 2012 11:09:05 +0100
Message-ID: <4F0C0E41.1020405@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com> <1323439361-1647-10-git-send-email-b-cousson@ti.com> <CAOZdJXU9w1O69ZgNEmgUZfezXEyn1JTyZxgmmLXAb3-mtJLnOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39942 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab2AJKJZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jan 2012 05:09:25 -0500
In-Reply-To: <CAOZdJXU9w1O69ZgNEmgUZfezXEyn1JTyZxgmmLXAb3-mtJLnOA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 1/10/2012 12:24 AM, Tabi Timur-B04825 wrote:
> On Fri, Dec 9, 2011 at 8:02 AM, Benoit Cousson<b-cousson@ti.com>  wrote:
>>
>> +       eeprom@50 {
>> +               compatible = "ti,eeprom";
>> +               reg =<0x50>;
>> +       };
>
> Why is this "ti,"?  For EDID, isn't the I2C device actually on the
> monitor itself, and DVI cable just connects to the I2C bus?

Yes, in fact I didn't know what to put here, since I do not know what 
kind of eeprom the monitor will use.

And then I realized that the i2c driver is using the compatible name 
without the prefix, so any prefix can be used there...
OK, that's maybe not a very valid reason... but I did not find any 
better prefix at that time:-)

> The reason I ask is that I'm trying to do the same thing for a PowerPC
> board.  I need to defined an EDID I2C node.

Well, this seems to be generic i2c eeprom, so maybe a "ddc," prefix or 
"edid," will be a little bit better.

If later, we want to access that node from the display driver, we can 
just add a phandle to the node's label: "edid-eeprom: eeprom@50:"

Regards,
Benoit

