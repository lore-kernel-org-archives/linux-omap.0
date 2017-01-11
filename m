From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: da850: Add the cppi41 dma node
Date: Wed, 11 Jan 2017 15:19:42 +0530
Message-ID: <38cb3979-0399-b5d3-890a-5c33cb097c3d@ti.com>
References: <20170109162449.5012-1-abailon@baylibre.com>
 <20170109162449.5012-2-abailon@baylibre.com>
 <811adb6b-00e4-bbc4-d6f5-7bf3ba85ab63@cogentembedded.com>
 <885f6118-16e8-2386-3016-6056d3259ad9@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <885f6118-16e8-2386-3016-6056d3259ad9-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 January 2017 07:15 PM, Alexandre Bailon wrote:
> On 01/09/2017 07:26 PM, Sergei Shtylyov wrote:

>>> +                0x201000 0x1000
>>> +                0x202000 0x1000
>>> +                0x204000 0x4000>;
>>> +            reg-names = "glue", "controller",
>>> +                    "scheduler", "queuemgr";
>>> +            interrupts = <58>;
>>> +            interrupt-names = "glue";
>>> +            #dma-cells = <2>;
>>> +            #dma-channels = <4>;
>>> +            #dma-requests = <256>;
>>> +            status = "disabled";
>>
>>    Why disabled? It doesn't use any external pins...

> Will fix it.

Please keep it disabled. See the other thread on this.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
