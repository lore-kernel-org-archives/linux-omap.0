From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 01:44:09 +0800
Message-ID: <50B4FBE9.5080301@linaro.org>
References: <Pine.LNX.4.44L0.1211271131130.1489-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:35349 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755972Ab2K0RoT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 12:44:19 -0500
In-Reply-To: <Pine.LNX.4.44L0.1211271131130.1489-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

On 11/28/2012 12:37 AM, the mail apparently from Alan Stern included:
> On Tue, 27 Nov 2012, Andy Green wrote:
>
>>> I don't know if such an approach would be sufficiently general for
>>> future requirements, but it would solve the problem at hand.
>>
>> We can get a notification about device creation and do things there.
>> But the cost of that is like the tuple suggestion, they'll only be a=
ble
>> to do a fixed thing like operate on regulators.
>
> I'm not quite sure what you mean by that.  _Any_ function is capable =
of
> doing only a fixed thing.
>
>> Actually the targeted device may have arbitrary associated assets li=
ke
>> generic GPIO to turn on a "flash" for built-in webcam controlled
>> out-of-band.  These also can be reached by known names.  And the dri=
ver
>> may wish to do things with them that are more complex than enable /
>> disable or follow logical lifecycle of the hub or whatever.
>
> Let's worry about that when it arises.
>
>> However when the guidance from Greg is that we can do nothing except
>> complain at hardware designers for some reason I failed to quite
>> identify, I fear we are moving deckchairs on the titanic.
>
> Greg's advice was simply not to rely on pathnames in sysfs because th=
ey
> aren't fixed in stone.  That leaves plenty of other ways to approach
> this problem.

It's sage advice, but there is zero code provided in my patches that=20
"relies on pathnames in sysfs".

> Basically, what you want is for something related to device A (the
> regulator or the GPIO) to happen whenever device B (the ehci-omap.0
> platform device) is bound to a driver.  The most straightforward way =
to
> arrange this is for A's driver to have a callback that is invoked
> whenever B is bound or unbound.  The most straightforward way to
> arrange _that_ is to allow each platform_device to have a list of
> callbacks.

Sorry I didn't really understand this proposal yet.  You want "A", the=20
regulator, driver to grow a callback function that gets called when the=
=20
targeted platform_device ("B", ehci-omap.0) probe happens.  Could you=20
expand what the callback prototype or new members in the struct might=20
look like?  It's your tuple thing or we pass it an opaque pointer that=20
is the struct regulator * or suchlike?

Throwing out the path stuff and limiting this to platform_device means=20
you cannot bind to dynamically created objects like hub or anything=20
downstream of a hub.  So Felipe's identification of the hub as the=20
happening place to do this is out of luck.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
