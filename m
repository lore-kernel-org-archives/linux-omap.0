From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: Current state of AM33xx patches
Date: Mon, 02 Jul 2012 14:56:39 +0200
Message-ID: <4FF19A87.4040602@visionsystems.de>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com> <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com> <4FE9A00B.6010908@ti.com> <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com> <4FEC7394.9030208@gmail.com> <4FEDB37C.4070604@visionsystems.de> <79CD15C6BA57404B839C016229A409A83EA5FC0F@DBDE01.ent.ti.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:53556 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab2GBM46 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 08:56:58 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5FC0F@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Daniel Mack <zonque@gmail.com>, "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>

Am 29.06.2012 19:43, schrieb Hiremath, Vaibhav:
> On Fri, Jun 29, 2012 at 19:24:04, Yegor Yefremov wrote:
>> Am 28.06.2012 17:09, schrieb Daniel Mack:
>>> On 27.06.2012 14:13, Hiremath, Vaibhav wrote:
>>>
>>>> Just to clarify from AM335x perspective,
>>>>
>>>> In case of AM335x, since the patches and complete BasePort support is still
>>>> not present in the Mainline (neither in Linus's tree not in linux-omap), you 
>>>> need to use my Repo (https://github.com/hvaibhav: Closely follows linux-
>>>> omap/master) in order to test something on BeagleBone platform.
>>> Great, that is the information I've been looking for.
>>>
>>> Your am335x-upstream-staging branch works for me on a custom AM335x
>>> based board using a custom DT config.
>>>
>>> I'll dig through the sources and come back once I know which parts are
>>> missing.
>> Do you have LCD screen attached? I need a functioning framebuffer driver. So far if I start x-server I get various errors:
>>
>> (EE) FBDEV(0): internal error: miCreateDefColormap failed in FBDevScreenInit()
>>
> Did you get a chance to dig on this? Do you have further level of details 
> from driver perspective? Which IOCTL is failing here? What is return value?

Sorry for the noise. The driver is working now. It was a software issue introduced by the latest Buildroot version. But the FB_BLANK patch is still valid, it removes nasty warnings.

Best regards,
Yegor

