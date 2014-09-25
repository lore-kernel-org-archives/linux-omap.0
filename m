From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] USB: Remove .owner field for driver
Date: Thu, 25 Sep 2014 14:29:00 +0300
Message-ID: <1411644540.18580.128.camel@iivanov-dev>
References: <1411557494-32535-1-git-send-email-kiran.padwal@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411557494-32535-1-git-send-email-kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2014-09-24 at 16:48 +0530, Kiran Padwal wrote:
> There is no need to init .owner field.
> 
> Based on the patch from Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> "mmc: remove .owner field for drivers using module_platform_driver"
> 
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway."
> 
> Signed-off-by: Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>

Thank you Kiran.

Reviewed-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
