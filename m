From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Thu, 10 Nov 2016 22:34:07 +0100
Message-ID: <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd> <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20161110202910.GE28832@amd>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 11/10/2016 09:29 PM, Pavel Machek wrote:
> On Thu 2016-11-10 10:55:37, Tony Lindgren wrote:
>> * Pavel Machek <pavel@ucw.cz> [161110 09:29]:
>>> Hi!
>>>
>>>>>>> Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
>>>>>>> the sysfs brightness attr for changes.") breaks runtime PM for me.
>>>>>>>
>>>>>>> On my omap dm3730 based test system, idle power consumption is over 70
>>>>>>> times higher now with this patch! It goes from about 6mW for the core
>>>>>>> system to over 440mW during idle meaning there's some busy timer now
>>>>>>> active.
>>>>>>>
>>>>>>> Reverting this patch fixes the issue. Any ideas?
>>>
>>> Are you using any LED that toggles with high frequency? Like perhaps
>>> LED that is lit when CPU is active?
>>
>> Yeah one of them seems to have cpu0 as the default trigger.
>
> Aha. Its quite obvious we don't want to notify sysfs each time that
> one is toggled, right?
>
> IMO brightness should display max brightness for the trigger, as Hans
> suggested, anything else is madness for trigger such as cpu activity.

Are you suggesting that we should revert changes introduced
by below patch?

commit 29d76dfa29fe22583aefddccda0bc56aa81035dc
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Tue Mar 18 09:47:48 2008 +0000

     leds: Add support to leds with readable status

     Some led hardware allows drivers to query the led state, and this patch
     adds a hook to let the led class take advantage of that information 
when
     available.

     Without this functionality, when access to the led hardware is not
     exclusive (i.e. firmware or hardware might change its state behind the
     kernel's back), reality goes out of sync with the led class' idea 
of what
     the led is doing, which is annoying at best.

     Behaviour for drivers that do not or cannot read the led status is
     unchanged.

     Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
     Signed-off-by: Richard Purdie <rpurdie@rpsys.net>


-- 
Best regards,
Jacek Anaszewski
