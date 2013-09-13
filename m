From: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 15:09:31 +0530
Message-ID: <5232DD53.3010706@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-2-git-send-email-archit@ti.com> <5232D9C8.9020809@ti.com> <5232DCFE.5050700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5232DCFE.5050700-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday 13 September 2013 03:08 PM, Archit Taneja wrote:
> On Friday 13 September 2013 02:54 PM, Tomi Valkeinen wrote:
>> On 13/09/13 12:14, Archit Taneja wrote:
>>> Move omapdrm device creation inside the omap_display_init so that we can
>>> correctly create the device based on the presence of omapdss.
>>>
>>> Originally worked on by Andy Gross.
>>
>> If the dmm device is present in the DT data, there is no need to create
>> the dmm device. It's created automatically.
>
> Yes, that is done in a later patch.
>
>>
>> Also, omapfb device is currently created the same way as omapdrm,
>> independently of omapdss. Why is it a problem to have them like that?
>
> In a multiplatform config, we might have CONFIG_DRM_OMAP and
> CONFIG_DRM_OMAP_MODULE selected.

I meant these configs might be selected even if the image is booted on 
am3xx platform.

Archit

>
> This would cause the call omap_init_drm() in arch/arm/mach-omap2/drm.c
> to occur. Creating a platform device for omapdrm is unnecessary here
> isn't it? Tying it with the initialisation of omapdss devices prevents it.
>
> Archit
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
