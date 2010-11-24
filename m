From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Wed, 24 Nov 2010 10:22:45 +0200
Message-ID: <20101124082245.GF2468@legolas.emea.dhcp.ti.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
 <1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
 <AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40126 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751370Ab0KXIWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 03:22:51 -0500
Received: by mail-gx0-f177.google.com with SMTP id 26so177408gxk.36
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 00:22:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

On Wed, Nov 24, 2010 at 10:46:04AM +0530, Varadarajan, Charulatha wrote=
:
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailb=
ox.c
>> index 48e161c..a1c6bd9 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -358,6 +358,10 @@ int omap_mbox_register(struct device *parent, s=
truct omap_mbox **list)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(mbox-=
>dev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())
>
>Do not use cpu_is* checks in plat-omap/*

see the previous thread.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
