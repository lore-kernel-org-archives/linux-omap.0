From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: USB issues with 2.6.38-rc7?
Date: Mon, 7 Mar 2011 10:06:53 -0800
Message-ID: <AANLkTi=B91BVsPiw2-vP9d09_U0KHoa70GMA85Z6CW4F@mail.gmail.com>
References: <AANLkTi=icn1QeM7pTZhVNLAcsHaJO-eyp-EHm5QWVvOf@mail.gmail.com>
	<20110307073750.GB2522@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50181 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab1CGSGy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 13:06:54 -0500
Received: by vws12 with SMTP id 12so3901211vws.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 10:06:54 -0800 (PST)
In-Reply-To: <20110307073750.GB2522@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

On Sun, Mar 6, 2011 at 11:37 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Sun, Mar 06, 2011 at 08:58:47PM -0800, Steve Sakoman wrote:
>> I began working with mainline 2.6.38-rc7 on Overo this past week in =
an
>> attempt to get a few patches submitted in time for the 2.6.39 merge
>> window.
>>
>> One thing I've noticed is that neither musb nor ehci USB support are
>> working for me. =A0I'm using the same config options as I did for
>> 2.6.37.

The 2.6.37 defconfig was my issue.  The 2.6.37 deconfig did not
include CONFIG_USB_MUSB_OMAP2PLUS.

=46or some reason this causes CONFIG_USB_MUSB_TUSB6010 and
CONFIG_USB_TUSB_OMAP_DMA to be set and results in non-working USB.

Adding CONFIG_USB_MUSB_OMAP2PLUS to my defconfig did the trick and I
now have working musb and ehci.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
