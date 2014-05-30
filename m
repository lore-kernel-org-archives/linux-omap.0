From: Satish Patel <satish.patel-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 3/5] char: ti-usim: Add driver for USIM module on AM43xx
Date: Fri, 30 May 2014 09:38:20 +0530
Message-ID: <53880434.7080002@ti.com>
References: <1401267437-22489-1-git-send-email-satish.patel@ti.com> <1401267437-22489-4-git-send-email-satish.patel@ti.com> <CAL_JsqKs=a8GRJRmNE-oxU4imHqnb5szv+Km-wv3KuN0d6Bxkg@mail.gmail.com> <53870671.6080601@ti.com> <20140529155349.GD32214@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140529155349.GD32214-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 5/29/2014 9:23 PM, Greg Kroah-Hartman wrote:
> On Thu, May 29, 2014 at 03:35:37PM +0530, Satish Patel wrote:
>>>> +enum usim_card_mode {
>>>> +       USIM_CARD_MODE_ASYNC = 0,       /* asynchronous mode */
>>>> +       USIM_CARD_MODE_SYNC_TYPE1,      /* synchronous mode: Type 1 */
>>>> +       USIM_CARD_MODE_SYNC_TYPE2,      /* synchronous mode: Type 2 */
>>>> +       USIM_CARD_MODE_SYNC_OTHER,      /* Any other synchronous type */
>>>> +};
>>>> +struct usim_data {
>>>> +       int slot;
>>>> +       int rxexplen;
>>>> +       int txlen;
>>>> +       unsigned char apdu[256];
>>>> +};
>
> You need to use the proper variable types for a structure that is going
> to cross the user/kernel boundry in an ioctl :(
Do you mean to use __u32 instead int ? make use of types defined in 
types.h ? if yes, I will make that change :). Thanks for pointing out.
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
