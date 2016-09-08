From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Thu, 8 Sep 2016 09:20:28 -0500
Message-ID: <7a5e1cd7-1dbf-0288-066e-5cd3b108f092@ti.com>
References: <20160829223542.18871-1-tony@atomide.com>
 <57C74306.9020901@gmail.com> <20160831214151.wzq7y54xxs2qj422@atomide.com>
 <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 09/08/2016 08:38 AM, Rob Herring wrote:
> On Wed, Aug 31, 2016 at 4:41 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
[...]
>>> It is unfortunate that Linux has adopted the practice of overloading status
>>> to determine whether a piece of hardware exists or does not exist.  This
>>> is extremely useful for the way we structure the .dts and .dtsi files but
>>> should have used a new property name.  We are stuck with that choice of
>>> using the status property for two purposes, first the state of a device,
>>> and secondly the hardware description of existing or not existing.
>
> I don't agree. Generally, disabled means the h/w is there, but don't
> use it. There may be some cases where the hardware doesn't exist for
> the convenience of having a single dts, but that's the exception.
>

Minor point here: when SoCs are manufactured, even though the silicon 
die may have a hardware block, it is completely efused out based on 
paper spin. in effect such a hardware block "does not exist". The 
number of such paper spins are not exception cases, but rather 
standard for SoC vendors - maintaining dts per paper spin is just too 
impossible to maintain (DRA7 as an example maintains a single 
dra7.dtsi as the root for all paper spins.. the variations if 
maintained as seperate dts might infact end up being larger in number 
than all the dts we have in arch/arm/boot/dts) - typically as an soc 
vendor pushes a specific SoC to multiple markets, this tends to be a norm.

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
