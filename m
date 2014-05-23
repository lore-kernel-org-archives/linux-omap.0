From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 00/16] OMAP: GPMC: Restructure OMAP GPMC driver (NAND)
 : DT binding change proposal
Date: Fri, 23 May 2014 11:16:08 +0300
Message-ID: <537F03C8.3070101@ti.com>
References: <1400671264-10702-1-git-send-email-rogerq@ti.com> <20140521160818.GA1150@arch.cereza> <537DB17A.6060608@ti.com> <CABxcv=nbgGhVN+XYO8s=mYOpoLU9-kWuEqc+FLMaSbWS7BJNyQ@mail.gmail.com> <20140522144600.GA1785@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140522144600.GA1785-nAQHv47ARr+vIlHkl8J1cg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Ezequiel & Javier,

On 05/22/2014 05:46 PM, Ezequiel Garcia wrote:
> On 22 May 01:51 PM, Javier Martinez Canillas wrote:
>> On Thu, May 22, 2014 at 10:12 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>>>> On 21 May 02:20 PM, Roger Quadros wrote:
>>>>>
>>>>> For DT boot:
>>>>> - The GPMC controller node should have a chip select (CS) node for each used
>>>>>   chip select. The CS node must have a child device node for each device
>>>>>   attached to that chip select. Properties for that child are GPMC agnostic.
>>>>>
>>>>>   i.e.
>>>>>      gpmc {
>>>>>              cs0 {
>>>>>                      nand0 {
>>>>>                      }
>>>>>              };
>>>>>
>>>>>              cs1 {
>>>>>                      nor0 {
>>>>>                      }
>>>>>              }
>>>>>              ...
>>>>>      };
>>>>>
>>>>
>>>> While I agree that the GPMC driver is a bit messy, I'm not sure it's possible
>>>> to go through such a complete devicetree binding re-design (breaking backwards
>>>> compatibility) now that the binding is already in production.
>>>
>>> Why not? especially if the existing bindings are poorly dones. Is anyone using these
>>> bindings burning the DT into ROM and can't change it when they update the kernel?
>>>
>>
>> While I do agree that your DT bindings are much better than the
>> current ones, there is a policy that DT bindings are an external API
>> and once are released with a kernel are set in stone and can't be
>> changed.
>>
> 
> Exactly. The DT binding is considered an ABI. Thus, invariant across kernel
> versions. Users can't be coherced into a DTB update after a kernel update.
> 
> That said, I don't really care if you break compatilibity in this case.
> Rather, I'm suggesting that you make sure this change is going to be accepted
> upstream, before doing any more work. The DT maintainers are reluctant to do
> so.

Appreciate your concern.

Would be really nice if you can review patches 1-12. They have nothing to do with DT changes.
Thanks.

cheers,
-roger

> 
> On the other side, I guess you will also break bisectability while breaking
> backward compatibility. Doesn't sound very nice.
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
