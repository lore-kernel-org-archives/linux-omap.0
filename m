From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RESEND PATCH 0/2] Add dt support for extcon gpio driver
Date: Thu, 06 Nov 2014 10:14:55 +0900
Message-ID: <545ACB8F.3080508@samsung.com>
References: <1415201388-32060-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1415201388-32060-1-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rongjun.ying-kQvG35nSl+M@public.gmane.org, Baohua.Song-kQvG35nSl+M@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi George,

On 11/06/2014 12:29 AM, George Cherian wrote:
> This series
>         - Adds dt support to extcon-gpio driver.
> 	- Add cable name support in case of dt.
> 
> George Cherian (2):
>   extcon: gpio: Add dt support for the driver
>   extcon: gpio: Add support for using cable names
> 
>  drivers/extcon/extcon-gpio.c       | 87 +++++++++++++-------------------------
>  include/linux/extcon/extcon-gpio.h | 59 --------------------------
>  2 files changed, 29 insertions(+), 117 deletions(-)
>  delete mode 100644 include/linux/extcon/extcon-gpio.h
> 

I'm so sorry for late reply because I'm busy for other jobs.

But, I will review this patchset and test it on my board
within 3~4 days.

Best Regards,
Chanwoo Choi

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
