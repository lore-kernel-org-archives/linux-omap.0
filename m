From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: stable kernel version
Date: Mon, 19 Oct 2009 19:54:30 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA174DCE@dbde02.ent.ti.com>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com>
 <4AD60CEE.8000204@tzi.de> <20091014193324.GK12700@atomide.com>
 <4AD88BBD.9010602@tzi.de> <20091016154051.GE12576@atomide.com>
 <4ADC7476.9090208@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34520 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755629AbZJSOZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 10:25:17 -0400
In-Reply-To: <4ADC7476.9090208@tzi.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janosch Machowinski <scotch@tzi.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Janosch
>Machowinski
>Sent: Monday, October 19, 2009 9:15 AM
>To: linux-omap@vger.kernel.org
>Subject: Re: stable kernel version
>
>
>> Can you try it with the omap-debug branch, and enable
>> the CONFIG_DEBUG_LL option in your .config?
>>
>> Tony
>>
>This time I got some debug output, looks like
>it crashed somewhere in the USB Code.
>Deactivating the USB suspend option didn't help.
>Any ideas how to debug this further / fix it ?
>
>Attached you'll finde the debug output and my
>kernel config.

Here's the problem:
<3>HS USB OTG: no transceiver configured
<3>musb_hdrc musb_hdrc: musb_init_controller failed with status -19

Depending on your board, you will have to define the transceiver for MUSB.
It could be TWL4030 or NO-transceiver...

Drivers -> USB -> (last options) *** OTG and related infrastructure ***

Or do u want to disable USB to start with !!

>Regards
>    Janosch
