From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: omap5: build opp4xxx_data.c
Date: Tue, 25 Jun 2013 18:43:32 -0400
Message-ID: <51CA1D14.4070600@ti.com>
References: <201306212229.54238.arnd@arndb.de> <20130621204250.GA16139@kahuna> <alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com> <51C9F595.3060609@ti.com> <20130625195751.GA6529@kahuna> <51C9F993.6050109@ti.com> <CAGo_u6rQG7h2aPSErwKR1H7PYE5QdxXU3Dd5z13-rPkbVtkcUw@mail.gmail.com> <51C9FC97.1020502@ti.com> <87a9mducye.fsf@linaro.org> <51CA0498.9010506@ti.com> <20130625223636.GA4455@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37945 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab3FYWoD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jun 2013 18:44:03 -0400
In-Reply-To: <20130625223636.GA4455@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, "J, KEERTHY" <j-keerthy@ti.com>

On Tuesday 25 June 2013 06:36 PM, Nishanth Menon wrote:
> On 16:59-20130625, Santosh Shilimkar wrote:
>> On Tuesday 25 June 2013 04:56 PM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> On Tuesday 25 June 2013 04:17 PM, Nishanth Menon wrote:
>>>>> On Tue, Jun 25, 2013 at 3:12 PM, Santosh Shilimkar
>>>>> <santosh.shilimkar@ti.com> wrote:
>>>>>>
>>>>>> Well having voltage data in voltage domain was not my decision ;-)
>>>>>> Instead of creating another set of dummy data, I just used what
>>>>>> is out there(OMAP4) with clear comment that data needs to be updated.
>>>>>> I don't see any problem in this considering we have devices booting
>>>>>> and working nicely for OMAP5
>>>>> I really wish the OMAP5 devices(the latest ones from Fab) I have would
>>>>> like to function at OMAP4 configurations! Unfortunately the devices
>>>>> tend to follow the data manual for OMAP5.
>>>>> *if* there is no need for it to boot, I suggest removing it.
>>>>>
>>>> I don't understand you. For OMAP5, that data without voltage
>>>> controller support doesn't do anything bad. Since there was some
>>>> dependency of voltage domain association whit PD's, I have to keep
>>>> that. I never claimed that OMAP4 settings would work for OMAP5
>>>> in absolute terms.
>>>>
>>>> Feel free to post a patch with right data which you seems to have.
>>>> I don't mind you removing that data as long as the device
>>>> continues to boot. Patch welcome.
>>>
>>> Thanks to Rajendra's cleanup, I don't think we need dummy data anymore:
>>>
>>>    http://marc.info/?l=linux-omap&m=137147503827947&w=2
>>>
>>> That series is queued for v3.11.
>>>
>> I knew the series but wasn't sure about it getting queued up
>> for 3.11. Nice to see the dependency is getting removed.
> 
> Anyways, I tried booting up a kernel built on linux-next-20130625
> with omap2plus_defconfig and [1] on OMAP5uEVM and all I see is:
> Importing environment from mmc0 ...
> reading //zImage
> 4030024 bytes read in 198 ms (19.4 MiB/s)
> reading //omap5-uevm.dtb
> 17729 bytes read in 16 ms (1.1 MiB/s)
> [..]
> ## Flattened Device Tree blob at 80f80000
> Booting using the fdt blob at 0x80f80000
> Using Device Tree in place at 80f80000, end 80f87540
> 
> Starting kernel ...
> 
> If someone can point me to a functional base, it'd be nice, or if there
> is a known pending fix, it'd be better..
> Taking http://marc.info/?l=linux-omap&m=136984555408516&w=2 and rebasing
> on linux next tag resulted practically in NOP. 
> 
As mentioned in the cover-letter, you are probably missing the clock data.
------------
That means for the boot, one clock data patch needs to be applied.
It is available on my git tree in 'out_of_tree/omap5_clk_data' branch.
---------------------------------------

Regards,
Santosh


