From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: opp: Introduce ti-opp-supply bindings
Date: Sat, 16 Dec 2017 11:52:07 +0100
Message-ID: <CAJZ5v0iRg0Sncqt4s3M5+E0h=HJiEDQ4vnB3=6mFhECCv_Lnng@mail.gmail.com>
References: <20171215042528.28715-1-d-gerlach@ti.com> <20171215042528.28715-4-d-gerlach@ti.com>
 <CAJZ5v0iaYAodhiQm3=7OMhtqP3JXoX_RTrYMRDxVwO=3hTL7Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJZ5v0iaYAodhiQm3=7OMhtqP3JXoX_RTrYMRDxVwO=3hTL7Bg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 15, 2017 at 3:29 PM, Rafael J. Wysocki <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Dec 15, 2017 at 5:25 AM, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> wrote:
>> Document the devicetree bindings that describe Texas Instruments
>> opp-supply which allow a platform to describe multiple regulators and
>> additional information, such as registers containing data needed to
>> program aforementioned regulators.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
>
> I need an ACK from Rob on this one.

Actually, how this (and the next patch) is related to the [1-2/4]?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
