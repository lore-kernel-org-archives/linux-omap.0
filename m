From: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add dwc3-st.c file to ARCH/STI architecture
Date: Tue, 8 Jul 2014 11:01:12 +0200
Message-ID: <53BBB358.3040801@st.com>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org> <1404541530-27856-4-git-send-email-peter.griffin@linaro.org> <53BBA075.9040204@st.com> <20140708075332.GM6407@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140708075332.GM6407@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 07/08/2014 09:53 AM, Lee Jones wrote:
> On Tue, 08 Jul 2014, Maxime Coquelin wrote:
>> On 07/05/2014 08:25 AM, Peter Griffin wrote:
>>> Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
>
> Maxime,
>    Once Acked by Felipe, I think this should go in via your tree to
> avoid conflicts with other ARM/STI ARCHITECTURE additions.

Ok

>
>>> ---
>>>   MAINTAINERS | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 702ca10..269ad3b 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1325,6 +1325,7 @@ F:	drivers/pinctrl/pinctrl-st.c
>>>   F:	drivers/media/rc/st_rc.c
>>>   F:	drivers/i2c/busses/i2c-st.c
>>>   F:	drivers/tty/serial/st-asc.c
>>> +F:	drivers/usb/dwc3/dwc3-st.c
>>>
>>>   ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
>>>   M:	Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
