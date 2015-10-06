From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: dts: DRA7: Add timer12 node
Date: Tue, 6 Oct 2015 11:02:36 -0500
Message-ID: <5613F09C.1050809@ti.com>
References: <1444087704-1429-1-git-send-email-s-anna@ti.com>
 <1444087704-1429-4-git-send-email-s-anna@ti.com>
 <87y4fgesbz.fsf@saruman.tx.rr.com> <20151006075209.GH23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151006075209.GH23801-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/06/2015 02:52 AM, Tony Lindgren wrote:
> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [151005 17:51]:
>>
>> according to Tony we should avoid using status at all for in-SoC
>> devices.
>>
>> Tony, can you confirm I understood you correctly ?
> 
> Yes. With status = "disabled" kernel completely ignores the
> device and struct device is not created at all even with the
> device being there. In general we're better off trying to
> probe the device and idle it.
> 
> The only time we really want to mark something with
> status = "disabled" is if some coprocessor firmware is
> using that device and the kernel should not touch it at
> all.

Not always, since some of the PM clocking logic depends on the state
machine variables within the kernel.

We are also using this to deal with paper-spins (atleast in the DRA7
case) and the DTS include model, wherein certain instances may not be
present on all variations of the SoC, and enabled specifically on the
instances that matter. Obviously, it could be done the other way too,
but as far as what Nishanth mentioned sometime back, we are following
the former for DRA7.

In anycase, the status property on the Timer12 node can be removed, it
doesn't fall into the above category, and we are fixing it up properly
on HS devices in the kernel.

regards
Suman

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
