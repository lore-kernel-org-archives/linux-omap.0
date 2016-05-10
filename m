From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 4/5] usb: dwc3: omap: Pass VBUS and ID events
 transparently
Date: Tue, 10 May 2016 13:13:10 +0300
Message-ID: <5731B436.6020801@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
 <1462873919-20532-5-git-send-email-rogerq@ti.com>
 <87d1oui6eh.fsf@linux.intel.com> <5731B155.6010109@ti.com>
 <871t5ai5ye.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871t5ai5ye.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/05/16 13:05, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>> On 10/05/16 12:55, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>> Don't make any decisions regarding VBUS session based on ID
>>>> status. That is best left to the OTG core.
>>>>
>>>> Pass ID and VBUS events independent of each other so that OTG
>>>> core knows exactly what to do.
>>>>
>>>> This makes dual-role with extcon work with OTG irq on OMAP platforms.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>
>>> I have a feeling this will regress OMAP5432 uEVM. Did you test with that
>>> board ?
>>>
>>
>> Yes. Any specific test case you would like me to test?
>> For now I'm just doing enumeration with g_zero.
> 
> IIRC OMAP5 uEVM didn't have separate VBUS and ID GPIOs. How are you
> handling that case ?
> 
It comes from the PMIC, extcon-palmas.c.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
