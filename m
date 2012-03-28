From: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Wed, 28 Mar 2012 13:33:49 +0200
Message-ID: <4F72F71D.5080406@compulab.co.il>
References: <1332857335-27911-1-git-send-email-grinberg@compulab.co.il> <20120328085231.GD18156@arwen.pp.htv.fi> <CAMrsUdJjwAN4haHOkrGfrpb9HnbsMLyUE4a5aLnCPKC2JdUt_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMrsUdJjwAN4haHOkrGfrpb9HnbsMLyUE4a5aLnCPKC2JdUt_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Raja, Govindraj" <govindraj.raja-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/28/12 12:53, Raja, Govindraj wrote:
> On Wed, Mar 28, 2012 at 2:22 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>> On Tue, Mar 27, 2012 at 04:08:55PM +0200, Igor Grinberg wrote:
>>> When PHY reset pin is connected to a GPIO on external GPIO chip
>>> (e.g. I2C), we should not call the gpio_set_value() function, but
>>> gpio_set_value_cansleep().
>>>
>>> Signed-off-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>>
>> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>
>> Keshava, please give us your tested-by. Patch looks fine to me.
> 
> Tried on beagle-xm where the smsc hub + smsc95xx ethernet controller
> relies gpio nreset sequence for initialization.
> 
> Both hub + Ethernet controller get enumerated even after this patch.
> 
> Tested-by: Govindraj.R <govindraj.raja-l0cyMroinI0@public.gmane.org>

Thanks Raja.


-- 
Regards,
Igor.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
