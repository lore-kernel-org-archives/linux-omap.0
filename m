From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] arm: dts: AM57XX: Correct the thermal thresholds
Date: Mon, 15 Feb 2016 09:49:53 -0600
Message-ID: <56C1F3A1.4080709@ti.com>
References: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
 <20160209220901.GC28102@localhost.localdomain> <56BA6530.4030102@ti.com>
 <20160212222347.GO19432@atomide.com>
 <CAGo_u6r8-LJBWWrew0fV50Q+JnCxDj9PD57+9NoDm5TqCWL=jw@mail.gmail.com>
 <20160212224129.GP19432@atomide.com> <56C153A3.3030508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C153A3.3030508@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, dt list <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kumar Gala <galak@codeaurora.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

On 02/14/2016 10:27 PM, Keerthy wrote:
> 
> 
> On Saturday 13 February 2016 04:11 AM, Tony Lindgren wrote:
>> * Nishanth Menon <nm@ti.com> [160212 14:32]:
>>> On Fri, Feb 12, 2016 at 4:23 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>> * Nishanth Menon <nm@ti.com> [160209 14:17]:
>>>>> On 02/09/2016 04:09 PM, Eduardo Valentin wrote:
>>>>>> On Mon, Feb 08, 2016 at 03:15:05PM +0530, Keerthy wrote:
>>>>>>> The thermal threholds for am57xx are different from that of dra7.
>>>>>>> Correcting the thresholds for the same.
>>>>>>>
>>>>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Depends on: https://lkml.org/lkml/2016/2/8/90
>>>>>>>
>>>>>>>   arch/arm/boot/dts/am57xx-beagle-x15.dts | 24 ++++++++++++++++++++++++
>>>>>>>   1 file changed, 24 insertions(+)
>>>>>>>
>>>>>>> Index: linux/arch/arm/boot/dts/am57xx-beagle-x15.dts
>>>>>>> ===================================================================
>>>>>>> --- linux.orig/arch/arm/boot/dts/am57xx-beagle-x15.dts     2016-02-08 14:57:05.514959101 +0530
>>>>>>> +++ linux/arch/arm/boot/dts/am57xx-beagle-x15.dts  2016-02-08 14:57:05.510959168 +0530
>>>>>>
>>>>>> Sorry, did not bother to check, but is this the only user of am57xx?
>>>>>
>>>>> we will have AM57xx-IDK as well coming down the line. we already have
>>>>> arch/arm/boot/dts/am57xx-cl-som-am57x.dts
>>>>> arch/arm/boot/dts/am57xx-sbc-am57x.dts - not really sure what grade of
>>>>> silicon are used in cl-SOM and sbc boards.
>>>>
>>>> Hmm can this one wait for v4.6 or is it critical for v4.5-rc
>>>> cycle?
>>>
>>> personally, I'd like to NAK this patch -> lack of reference
>>> documentation, and guidance for various AM57xx boards in a generic
>>> patch should probably be followed IMHO.
>>
>> OK let's wait for that then.
> 
> OK. I will send a v2 with better documentation.



This data is in the AM572x datasheet:
http://www.ti.com/lit/ds/symlink/am5728.pdf

Table 5-3 in the current version contains the maximum junction
temperatures.

this indicates that there are "Commercial" and "extended" -> we may
need to introduce just 2 dtsis -> am57xx-commercial and
am57xx-extended and reuse those based on the part on the board. just a
suggestion..


-- 
Regards,
Nishanth Menon
