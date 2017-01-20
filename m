From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 5/5] usb: musb: da8xx: Add a primary support of PM
 runtime
Date: Fri, 20 Jan 2017 11:10:55 +0530
Message-ID: <92f32014-c20c-0afb-bfd8-b75fdb4faba6@ti.com>
References: <20170119140835.18981-1-abailon@baylibre.com>
 <20170119140835.18981-6-abailon@baylibre.com>
 <6287b54d-c5ed-dc2d-2077-3eaa4a4e7d4a@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6287b54d-c5ed-dc2d-2077-3eaa4a4e7d4a-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 19 January 2017 10:12 PM, Sergei Shtylyov wrote:
> On 01/19/2017 05:08 PM, Alexandre Bailon wrote:
> 
>> Currently, DA8xx doesn't support PM runtime.
>> In addition, the glue driver is managing the clock itself.
>> But the CPPI DMA needs to manage this clock too.
>> Add support to PM runtime and use the callback to enable / disable
>> the clock.
> 
>    I think this sentence is stale now....

And please clarify what you mean by "DA8xx doesn't support PM runtime."
because we do have drivers using PM runtime being used on DA8xx.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
