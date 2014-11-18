From: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Tue, 18 Nov 2014 09:09:09 +0100
Message-ID: <546AFEA5.9020000@samsung.com>
References: <20141116075928.GA9763@amd>
 <20141117145857.GO8907@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20141117145857.GO8907-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, freemangordon-uiMcrn6V0Vs@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel, Sakari,

On 11/17/2014 03:58 PM, Sakari Ailus wrote:
> Hi Pavel,
>
> On Sun, Nov 16, 2014 at 08:59:28AM +0100, Pavel Machek wrote:
>> For device tree people: Yes, I know I'll have to create file in
>> documentation, but does the binding below look acceptable?
>>
>> I'll clean up driver code a bit more, remove the printks. Anything
>> else obviously wrong?
>
> Jacek Anaszewski is working on flash support for LED devices. I think it'd
> be good to sync the DT bindings for the two, as the types of devices
> supported by the LED API and the V4L2 flash API are quite similar.
>
> Cc Jacek.

I've already submitted a patch [1] that updates leds common bindings.
I hasn't been merged yet, as the related LED Flash class patch [2]
still needs some indicator leds related discussion [3].

I think this is a good moment to discuss the flash related led common
bindings.

[1] http://www.spinics.net/lists/linux-leds/msg02121.html
[2] http://www.spinics.net/lists/linux-media/msg83100.html
[3] http://www.spinics.net/lists/linux-leds/msg02472.html

Best Regards,
Jacek Anaszewski


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
