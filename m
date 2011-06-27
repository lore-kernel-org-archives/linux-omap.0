From: "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] USB: OTG: Use work_queue in set_vbus for TWL6030 transciever
Date: Mon, 27 Jun 2011 10:06:01 -0500
Message-ID: <BANLkTimtKAY7J2=c+ZhAEKAdZP3KY7CAPw@mail.gmail.com>
References: <1308928443-15352-1-git-send-email-m-sonasath@ti.com>
	<20110625063116.GA14681@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110625063116.GA14681-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Todd Poynor <toddpoynor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Todd,

On Sat, Jun 25, 2011 at 1:31 AM, Todd Poynor <toddpoynor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wr=
ote:
> On Fri, Jun 24, 2011 at 10:14:03AM -0500, Moiz Sonasath wrote:
> ...
>> + =A0 =A0 if (enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl->vbus_enable =3D 1;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl->vbus_enable =3D 0;
>> +
>
> Suggest twl->vbus_enable =3D enabled;
>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Start driving VBUS. Set OPA_MODE bit in CHARGERUSB_=
CTRL1
>> =A0 =A0 =A0 =A0* register. This enables boost mode.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if (enabled)
>> - =A0 =A0 =A0 =A0 =A0 =A0 twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE=
 , 0x40,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 CHARGERUSB_CTRL1);
>> - =A0 =A0 =A0else
>> - =A0 =A0 =A0 =A0 =A0 =A0 twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE=
 , 0x00,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 CHARGERUSB_CTRL1);
>> +
>> + =A0 =A0 schedule_work(&twl->set_vbus_work);
>> +
>
> Suggest also moving the comments together with the new location of
> the code to write CHARGERUSB_CTRL1.
>
> Add a cancel_work_sync(&twl->set_vbus_work) at twl6030_usb_remove(),
> prior to kfree(twl).
>

Thank you for the feedback, have posted a V2 of the patch.


--=20
Regards
Moiz Sonasath
Android Kernel Team
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
