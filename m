From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [PATCH] OMAP: GPIO: Avoid generating extra IRQs
Date: Wed, 5 Aug 2009 16:41:06 +0200
Message-ID: <1FFEF31EBAA4F64B80D33027D4297760047F6AECFD@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1246602393-8812-1-git-send-email-ext-eero.nurkkala@nokia.com>,<20090805131703.GG7374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27921 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934278AbZHEOpm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:45:42 -0400
In-Reply-To: <20090805131703.GG7374@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org


>>               l ^= bank->saved_datain;
>>               l &= bank->non_wakeup_gpios;
>> -             if (l) {
>> +
>> +             /*
>> +              * No need to generate IRQs for the rising edge for gpio IRQs
>> +              * configured with falling edge only; and vice versa.
>> +              */
>> +             gen0 = l & bank->saved_fallingdetect;
>> +             gen0 &= bank->saved_datain;
>> +
>> +             gen1 = l & bank->saved_risingdetect;
>> +             gen1 &= ~(bank->saved_datain);
>> +

> Is the gen0 &= correct or should it also clear the bits?

What do you mean, eg, what bits should be cleared?

gen0 = (bit has changed) and is falling_edge
gen0 &= (the bit has changed) is falling edge and former state was "HIGH"
(transition from HIGH to LOW has occurred)

for rising edge, needed is LOW to HIGH transition.

- Eero