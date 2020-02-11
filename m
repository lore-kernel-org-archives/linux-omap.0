From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: dts: am437x-gp/epos-evm: drop unused panel
 timings
Date: Tue, 11 Feb 2020 12:01:31 +0200
Message-ID: <b39e52f1-3e73-5f26-6206-0956cf482631@ti.com>
References: <20191114093950.4101-1-tomi.valkeinen@ti.com>
 <20191114093950.4101-3-tomi.valkeinen@ti.com>
 <20191202130459.GH4929@pendragon.ideasonboard.com>
 <20191211165331.GC43123@atomide.com>
 <45dae8f7-2f5e-6948-5a05-dc8a09ace1fa@ti.com>
 <20191212203550.GB4892@pendragon.ideasonboard.com>
 <add3d8af-6977-68e6-fb77-2fa748c4714a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <add3d8af-6977-68e6-fb77-2fa748c4714a-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 13/01/2020 14:01, Tomi Valkeinen wrote:
> On 12/12/2019 22:35, Laurent Pinchart wrote:
>> Hi Tomi,
>>
>> On Thu, Dec 12, 2019 at 11:37:51AM +0200, Tomi Valkeinen wrote:
>>> On 11/12/2019 18:53, Tony Lindgren wrote:
>>>> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [191202 13:05]:
>>>>> Hi Tomi,
>>>>>
>>>>> Thank you for the patch.
>>>>>
>>>>> On Thu, Nov 14, 2019 at 11:39:49AM +0200, Tomi Valkeinen wrote:
>>>>>> panel-simple now handled panel osd070t1718-19ts, and we no longer need
>>>>>> the panel timings in the DT file. So remove them.
>>>>>
>>>>> Should you in that case drop the panel-dpi compatible string too, as the
>>>>> panel-dpi bindings require panel timings in DT ?
>>>>
>>>> Yeah sounds like if panel-dpi is no longer usable for this device it
>>>> should be dropped from the compatible list.
>>>
>>> Ok, I agree.
>>>
>>> Looking at the dts files, panel-dpi is used in a bunch of boards. But
>>> we even have 3 dts files with panel-dpi, without the detailed panel
>>> model in compatible...
>>>
>>> Fixing those will break the compatibility with old dtbs and new
>>> kernel, unless we add timings-from-dt to a panel driver that handles
>>> panel-dpi.
>>
>> I know, and I don't have a perfect answer for this :-( I don't see a
>> third option, it's either breaking DT backward compatibility or adding
>> timings parsing to a panel driver (either a new panel-dpi driver or to
>> panel-simple). What's your preferred option ?
> 
> Hmm, I just realized that changing these will break omapfb. It relies on panel-dpi and timings from 
> DT...

If no one objects, I think we should just drop the timings from the .dts, and say that these boards 
are no longer supported with omapfb. I don't think there's much point in trying to keep omapfb 
working fine for boards that are fully supported by omapdrm.

Hopefully soon (in five years? =) we can say that omapdrm supports all the boards, and we can 
deprecate omapfb.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
