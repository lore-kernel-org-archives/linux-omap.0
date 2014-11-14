From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv6 4/5] hwspinlock/core: add common OF helpers
Date: Fri, 14 Nov 2014 11:09:15 -0600
Message-ID: <5466373B.2070808@ti.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com> <1410553499-55951-5-git-send-email-s-anna@ti.com> <CAK=WgbamdqAufjC4Xb5moERRBSB-cO6c1RPTE=f+dp75F+Eh7A@mail.gmail.com> <5463B5B6.8040709@ti.com> <CAK=WgbbatPTiz3efDWHVEcuug_UQfkCViMoK0zcfUg3JwB2oTA@mail.gmail.com> <5464EC7A.7050603@ti.com> <CAK=WgbbodS8GsUxQbkyCp6hAG+Ko4LMirx+pUa8_fUdxWFasvw@mail.gmail.com> <54651C48.90809@ti.com> <CAK=WgbYMM19-rWLOBjix+TA3fF_Pb25ia1rutDxYSUg9SV0efg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK=WgbYMM19-rWLOBjix+TA3fF_Pb25ia1rutDxYSUg9SV0efg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 11/14/2014 01:11 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Thu, Nov 13, 2014 at 11:02 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
>> OK, lets take an example. I have say 2 device instances, say
>>         hwlock1: hwlock@0 {
>>                 hwlock-num-locks = <32>
>>                 hwlock-base-id = <0>;
>>                 #hwlock-cells = <1>;
>>         };
>>         hwlock2: hwlock@0 {
>>                 hwlock-num-locks = <32>
>>                 hwlock-base-id = <32>;
>>                 #hwlock-cells = <1>;
>>         };
>>
>>         some-client {
>>                 hwlocks = <&hwlock1 32>, <&hwlock2 0>;
>>         };
>>
>> The first args value is incorrect, and I expect the API to return an
>> error. I don't think the API can make assumptions that all passed in
>> values will be correct. What do you suggest that the API do here?
> 
> I think this is just one example of many potential mistakes the DT
> developer can have, and that there's nothing really special about it.
> 
> What if the '5' digit below is a typo, and the actual hardware
> assignment was supposed to be '4' ?
> 
>          some-client {
>                  hwlocks = <&hwlock1 5>, <&hwlock2 5>;
>          };
> 
> I don't see how much different this mistake is from the one you
> mentioned above. There's a limit to how much we can really catch DT
> mistakes in the code, just like we couldn't really catch past mistakes
> in the platform data structures.
> 
> If we can easily add some validations then great, but if we have to go
> to great lengths just to gain very limited validations, then I'd vote
> against doing so.

OK, personally, I am not too comfortable to not perform any validation
on an API.

> 
>> One solution to handle #1 is to also make the hwlock-num-locks property
>> also mandatory (even though it could have been read from a register
> 
> Yeah, this is awkward. We shouldn't impose this on implementations
> like OMAP which don't need it.
> 
> Again I think for the very limited validation this buys us - it's not worth it.
> 
>> And, how do you propose we solve the problem of deferred probing?
> 
> It seems to me that hwspin_lock_request_specific failures should be
> used by clients to defer their probing. Why wouldn't such a simple
> solution work?

Because the API always returns NULL on failures and there is no way for
the clients to figure out if the lock id passed is invalid or the bank
containing the lock is not registered. This was an old discussion on v4
[1], and you insisted that we don't change the return code convention on
the API. I had couple of patches on v5 that dealt with this, but even
that requires the list of registered devices.

regards
Suman

[1] https://patchwork.kernel.org/patch/3481331/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
