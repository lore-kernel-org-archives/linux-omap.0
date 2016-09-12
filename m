From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: reduce panel backlight PWM
 frequency to 83Hz
Date: Mon, 12 Sep 2016 17:03:32 +0200
Message-ID: <a7975f8d-e2e2-6554-4bab-af8c00dc9252@baylibre.com>
References: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com>
 <20160910031736.xwnepaoifpedqfbr@squirrel.local>
 <57D40F2C.7000805@baylibre.com> <20160912104155.267876a2.drivshin@awxrd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160912104155.267876a2.drivshin-WHIoityCHfoAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Rivshin <drivshin-WHIoityCHfoAvxtiuMwx3w@public.gmane.org>
Cc: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/12/2016 04:41 PM, David Rivshin wrote:
> On Sat, 10 Sep 2016 15:48:28 +0200
> Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> 
>> Le 10/09/2016 05:17, Matthijs van Duin a écrit :
>>> On Mon, Sep 05, 2016 at 11:16:38AM +0200, H. Nikolaus Schaller wrote:  
>>>> This helps to get 100% intensity closer to "always on".
[...]
>>> }
>>>
>>> At the time I used a scope to check the exact behaviour of dmtimer pwm
>>> on a dm814x.  My notes mention (when pwm enabled):
>>> 	match < reload	output on continuous
>>> 	match == reload	output on 1 cycle, off period-1 cycles
>>> 	match == -2	output on period-1 cycles, off 1 cycle
>>> 	match == -1	output freezes
>>>
>>> Hope this helps  
>>
>> Hi,
>>
>> I think these corner cases should definitely be handled in the dmtimer driver.
> 
> Do you mean to modify the dmtimer driver itself, or the pwm-omap-dmtimer 
> driver?
> 
> IIRC from the last time I was in the pwm-omap-dmtimer driver, it seemed to 
> me that the 0% and 100% cases could/should be handled as simple special 
> cases there. I think the dmtimer driver itself has the necessary API to the 
> HW, but I'd need to re-familiarize myself with it to remember the details 
> of what I was thinking. 
> 
> Actually, I did mention some thoughts on this a previous thread where
> Adam Ford was using pwm-omap-dmtimer for a backlight:
>  http://www.spinics.net/lists/linux-omap/msg126006.html
> So it may be as simple as using PWM_OMAP_DMTIMER_TRIGGER_NONE and passing 
> def_on according to whether 0 or 100% duty were requested (and polarity).

Yes it's exactly what I was talking about.

> 
> 
>>
>> I'll try to post a fix to handle these, thanks for the original code dump.
>>
>>>
>>> Matthijs
>>>   
>>
>> Neil

Thanks,
Neil

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
