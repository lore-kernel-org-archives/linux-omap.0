From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 11/11] dmaengine: cppi41: Fix teardown warnings
Date: Tue, 10 Jan 2017 12:11:39 +0100
Message-ID: <0bbd7f2b-0a15-de55-e054-958bfea048fe@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
 <20170109160656.3470-12-abailon@baylibre.com>
 <72228045-8c2d-3ea4-3fbb-00477b47a80b@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <72228045-8c2d-3ea4-3fbb-00477b47a80b-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/09/2017 07:46 PM, Sergei Shtylyov wrote:
> On 01/09/2017 07:06 PM, Alexandre Bailon wrote:
> 
>> During the teardown of a RX channel, because there is only one
>> completion queue available for RX channel, descriptor of another
>> channel may be popped which will cause 2 warnings:
>> - the first one because we popped a wrong descriptor
>>   (neither the channel's descriptor, neither the teardown descriptor).
> 
>    Neither ... nor.
> 
>> - the second one happen during the teardown of another channel,
>>   because we can't find the channel descriptor
>>   (that is, the one that caused the first warning).
>> Use the teardown queue as completion queue during the teardown.
> 
>    Hm, what's a teardown queue? I don't remember this documented...
> memory fade is always possible tho... :-)
I guess your memory is right :-)
There is no teardown queue. Though, we have to "allocate" an unassigned
queue and populate it with free teardown descriptors.
And when we are doing the teardown, we can select the queue to use for
completion. In the driver, we have to configure both of them.

Best regards,
Alexandre
> 
>> Note that fix doesn't fix all the teardown warnings:
>> I still get some when I run some corner case.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> [...]
> 
> MBR, Sergei
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
