From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP3: Lock DPLL5 at boot
Date: Wed, 9 Sep 2009 21:52:07 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9C307DD@dbde02.ent.ti.com>
References: <1252418056-5994-1-git-send-email-gadiyar@ti.com>
 <alpine.DEB.2.00.0909090939420.8657@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41620 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685AbZIIQWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 12:22:17 -0400
In-Reply-To: <alpine.DEB.2.00.0909090939420.8657@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>


Paul

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul
>Walmsley
>Sent: Wednesday, September 09, 2009 10:43 AM
>To: Gadiyar, Anand
>Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; Cousson, Benoit
>Subject: Re: [PATCH] OMAP3: Lock DPLL5 at boot
>
>On Tue, 8 Sep 2009, Anand Gadiyar wrote:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> OMAP3: Lock DPLL5 at boot
>>
>> Lock DPLL5 at 120MHz at boot. The USBHOST 120MHz f-clock and
>> USBTLL f-clock are the only users of this DPLL, and 120MHz is
>> is the only recommended rate for these clocks.
>>
>> With this patch, the 60 MHz ULPI clock is generated correctly.
>>
>> Tested on an OMAP3430 SDP.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> ---
>> Incorporated all 3 comments by Paul and Benoit. Updated
>> $SUBJECT to reflect the change.
>
>Thanks for the changes, I will queue this in a for-next branch for .33.

Is this for .33 or .32? 

>
>
>- Paul
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

