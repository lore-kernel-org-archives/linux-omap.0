From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 06/12] usb: dwc3: omap: Replace the extcon API
Date: Fri, 02 Dec 2016 16:52:40 +0900
Message-ID: <58412848.5070209@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-7-git-send-email-cw00.choi@samsung.com>
 <CGME20161130103827epcas4p268ee1cbc6b7b2ace7c987dd7baba82d4@epcas4p2.samsung.com>
 <877f7lntjq.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <877f7lntjq.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Peter.Chen-3arQi8VN3Tc@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chanwoo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 2016년 11월 30일 19:36, Felipe Balbi wrote:
> 
> Hi,
> 
> Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> writes:
>> This patch uses the resource-managed extcon API for extcon_register_notifier()
>> and replaces the deprecated extcon API as following:
>> - extcon_get_cable_state_() -> extcon_get_state()
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> Acked-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 

Thanks for your review.

Each patch has no any dependency among patches.
So, If possible, could you pick the patch6/8/9/10/11/12 on your tree?

-- 
Best Regards,
Chanwoo Choi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
