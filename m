From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 10/15] usb: musb: Don't set d+ high before enable for 2430
 glue layer
Date: Sat, 14 May 2016 16:30:32 +0300
Message-ID: <99ff5bff-e2f4-3137-2854-81d7b4b14bce@cogentembedded.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-11-git-send-email-tony@atomide.com>
 <20160513210334.GC1665@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160513210334.GC1665@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 5/14/2016 12:03 AM, Bin Liu wrote:

>> At least 2430 glue layer pulls d+ high on start up even if there are
>> no gadgets configured. This is bad at least for anything using a separate
>> battery charger chip as it can confuse the charger detection.
>>
>> Let's fix the issue by getting rid of omap2430_musb_set_mode() and only
>
> By doing so, you lost the feature of switching mode from sysfs, I am not
> sure if there is anyone using it though, still, it is a regression.

    BTW, set_mode() implemented in the OMAP glue always seemed bogus to me.
Instead of forcing host/gadget/OTG modes, it sets the Session bit...

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
