From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5 v4] usb: musb: Using runtime pm APIs for musb.
Date: Fri, 10 Dec 2010 19:06:29 +0530
Message-ID: <AANLkTin0eifHXn_OoA5Y87K24GYd3VHnmHP30-UO6BmZ@mail.gmail.com>
References: <1291985626-27174-1-git-send-email-hemahk@ti.com>
	<20101210125958.GK6027@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101210125958.GK6027-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 10, 2010 at 6:29 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Fri, Dec 10, 2010 at 06:23:46PM +0530, Hema HK wrote:
>>
>> @@ -429,28 +392,29 @@ static int __init omap2430_probe(struct
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdev->num_resources);
>> =A0 =A0 =A0 =A0if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to add re=
sources\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0ret =3D platform_device_add_data(musb, pdata, sizeof(=
*pdata));
>> =A0 =A0 =A0 =A0if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to add pl=
atform_data\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0ret =3D platform_device_add(musb);
>> =A0 =A0 =A0 =A0if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to regist=
er musb device\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 =A0 if (pm_runtime_get_sync(dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "pm_runtime_get_sync FAIL=
ED");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> + =A0 =A0 =A0 }
>
> don't you have to pm_runtime_disable() if get_sync fails ?

Yes. That is require. Otherwise next time driver load will through warn=
ing.
Thanks for pointing this out.
>
>> @@ -468,8 +432,7 @@ static int __exit omap2430_remove(struct
>>
>> =A0 =A0 =A0 =A0platform_device_del(glue->musb);
>> =A0 =A0 =A0 =A0platform_device_put(glue->musb);
>> - =A0 =A0 =A0 clk_disable(glue->clk);
>> - =A0 =A0 =A0 clk_put(glue->clk);
>> + =A0 =A0 =A0 pm_runtime_put_sync(&pdev->dev);
>
> same here, don't you need to pm_runtime_disable() ??
Yes.

Regards,
Hema
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
