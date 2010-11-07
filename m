From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 4/6] omap: iommu: intial hwmod support
Date: Sun, 7 Nov 2010 10:21:54 -0600
Message-ID: <AANLkTikMOJkgXvmC4WxPR2iiuJFO_20HjWrr6kgp3SZG@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-5-git-send-email-omar.ramirez@ti.com>
	<4CD5C333.8090608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49630 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753463Ab0KGQVy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Nov 2010 11:21:54 -0500
Received: by mail-iw0-f180.google.com with SMTP id 37so4703730iwn.39
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 08:21:54 -0800 (PST)
In-Reply-To: <4CD5C333.8090608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Nov 6, 2010 at 4:05 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
>> =A0static struct iommu_device omap3_devices[] =3D {
>
> You should not need that at all, you are just duplicating the data th=
at are
> already in hwmod, and then you are going to create real platform_devi=
ce.

ok, will try that.

>> =A0 =A0 =A0 =A0for (i =3D 0; i< =A0num_iommu_devices; i++) {
>
> Don't do that, just iterate over the hwmod class using
> omap_hwmod_for_each_by_class. Please have a look at the drivers with
> multiple devices that are already using hwmod (i2c, uart...).

And this too.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
