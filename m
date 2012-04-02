From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: make modules behave better
Date: Mon, 2 Apr 2012 22:33:10 +0530
Message-ID: <CAAe_U6+kqyn7mdujJKr-ysC+HyA0=pyO012H-FxYY6DSRjznJQ@mail.gmail.com>
References: <1327574749-18552-1-git-send-email-balbi@ti.com>
	<20120402143448.GD922@valkosipuli.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120402143448.GD922-S+BSfZ9RZZlogJBL88hg6CZi+YwRKgec@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Apr 2, 2012 at 8:04 PM, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org> wrote:
> Hi Felipe,
>
> On Thu, Jan 26, 2012 at 12:45:49PM +0200, Felipe Balbi wrote:
>> There's really no point in doing all that
>> initcall trickery when we can safely let
>> udev handle module probing for us.
>>
>> Remove all of that trickery, by moving everybody
>> to module_init() and making proper use of
>> platform_device_register() rather than
>> platform_device_probe().
>>
>> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> ---
>>
>> Because this falls into the "has never worked before" category
>> I will be sending this only on the next merge window. This
>> also gives people enough time to complain about any mistakes
>> on the patch.
>
> This patch looks correct and right to me, but it breaks musb when it's
> compiled into the kernel, at least on the Nokia N950. I haven't yet figured
> out exactly why, though.

Is it an abort?
You can use the patch which I've sent to the list last week for fixing it.
http://www.spinics.net/lists/linux-usb/msg60603.html.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
