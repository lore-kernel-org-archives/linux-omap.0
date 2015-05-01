From: "Lad, Prabhakar" <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: add DT nodes for ov2659 sensor
Date: Fri, 1 May 2015 09:55:42 +0100
Message-ID: <CA+V-a8tk+CzcktcJSWpODpSsyue1J4vVQDNra5TpqWZeGieaOQ@mail.gmail.com>
References: <1426203501-32115-1-git-send-email-prabhakar.csengg@gmail.com>
 <20150316221740.GQ12397@atomide.com> <CA+V-a8uWqjze32ukOGonQAACByPmW6WDbpFrA9EFipnNJeD58A@mail.gmail.com>
 <20150317022344.GB31346@atomide.com> <CA+V-a8u-Y7M9ynJDD05=XeMjZMsb_0Utd-TuwJzEuRziPksvGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+V-a8u-Y7M9ynJDD05=XeMjZMsb_0Utd-TuwJzEuRziPksvGQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 10, 2015 at 9:22 PM, Lad, Prabhakar
<prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Tony,
>
> On Tue, Mar 17, 2015 at 2:23 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>> * Lad, Prabhakar <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150316 18:20]:
>>> Hi Tony,
>>>
>>> On Mon, Mar 16, 2015 at 10:17 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>>> > * Lad Prabhakar <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150312 16:38]:
>>> >> From: "Lad, Prabhakar" <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> >>
>>> >> this patch does the following:
>>> >> 1: adds DT node for fixed oscillator.
>>> >> 2: adds DT node entries for ov2659 sensor
>>> >> 3: adds remote-endpoint entry for VPFE.
>>> >>
>>> >> Signed-off-by: Lad, Prabhakar <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> >
>>> > Applying into omap-for-v4.1/dt thanks.
>>> >
>>> I would like to get this one in via media tree to avoid dependency
>>> as I am still waiting for Acks from DT maintainers for the sensor
>>> driver.
>>
>> OK dropping it.
>>
>>> If I can get your Ack on this I'll queue it up along with sensor
>>> driver via media tree.
>>
>> Sorry the chances are too big for pointless merge conflicts with
>> these files with constant patching going on.
>>
>> Please just resend this patch alone again to me later on once the
>> driver changes are merged into Linux next and on their way to the
>> mainline kernel.
>>
> the sensor driver is now present in linux-next and the same patch
> applies cleanly, can you pick up the same or do you want me to
> resend the patch ?
>
Ping...

Cheers,
--Prabhakar Lad
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
