From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path
Date: Fri, 28 Aug 2009 17:31:25 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2A6D@dlee06.ent.ti.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-7-git-send-email-felipe.balbi@nokia.com>
	 <496565EC904933469F292DDA3F1663E602A5EF29FB@dlee06.ent.ti.com>
 <5ec8ebd50908281413j139f01a8q25c9e9c4339e5a25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54532 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbZH1Wbe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 18:31:34 -0400
In-Reply-To: <5ec8ebd50908281413j139f01a8q25c9e9c4339e5a25@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


Hi,

>-----Original Message-----
>From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>Sent: Friday, August 28, 2009 4:13 PM
>To: Guzman Lugo, Fernando
>Cc: Felipe Balbi; Hiroshi DOYU; Ameya Palande; Linux OMAP Mailing List
>Subject: Re: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path
>
>On Fri, Aug 28, 2009 at 11:58 PM, Guzman Lugo,
>
>
>> @@ -324,7 +324,7 @@ static int __init bridge_init(void)
>> =A0 =A0 =A0 =A0if (result < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GT_1trace(driverTrace, GT_7CLASS, "br=
idge_init: "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Can'=
t get Major %d \n", driver_major);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0driver_major =3D MAJOR(dev);
>> @@ -332,19 +332,17 @@ static int __init bridge_init(void)
>> =A0 =A0 =A0 =A0bridge_device =3D kmalloc(sizeof(struct bridge_dev), =
GFP_KERNEL);
>> =A0 =A0 =A0 =A0if (!bridge_device) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unregister_chrdev_region(dev, 1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0cdev_init(&bridge_device->cdev, &bridge_fops);
>> =A0 =A0 =A0 =A0bridge_device->cdev.owner =3D THIS_MODULE;
>> =A0 =A0 =A0 =A0bridge_device->cdev.ops =3D &bridge_fops;
>>
>> =A0 =A0 =A0 =A0status =3D cdev_add(&bridge_device->cdev, dev, 1);
>> -
>> =A0 =A0 =A0 =A0if (status) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GT_0trace(driverTrace, GT_7CLASS,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Fail=
ed to add the bridge device \n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
>result =3D status, isn't is?
>or change status to result on previous lines.
>

Yes, we need to assigned status to result, in order to report the error=
, however I think we can get rid of result and use status instead, what=
 do you think?

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/* udev support */
>> @@ -474,7 +472,17 @@ static int __init bridge_init(void)
>> =A0 =A0 =A0 =A0DBC_Assert(status =3D=3D 0);
>> =A0 =A0 =A0 =A0DBC_Assert(DSP_SUCCEEDED(initStatus));
>> =A0 =A0 =A0 =A0GT_0trace(driverTrace, GT_ENTER, " <- driver_init\n")=
;
>> - =A0 =A0 =A0 return status;
>> +
>> + =A0 =A0 =A0 return 0;
>> +
>> +err3:
>> + =A0 =A0 =A0 kfree(bridge_device);
>> +
>> +err2:
>> + =A0 =A0 =A0 unregister_chrdev_region(dev, 1);
>> +
>> +err1:
>> + =A0 =A0 =A0 return result;
>> =A0}
>>
>> =A0/* =A0This function is invoked during unlinking of the bridge mod=
ule from
>the
>
>
>--
>With Best Regards,
>Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
