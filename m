From: Mike Chan <mike@android.com>
Subject: Re: drivers that require headers in mach-omap
Date: Thu, 30 Jul 2009 16:20:03 -0700
Message-ID: <8bb80c380907301620g5761ae36j55bec6747e32657a@mail.gmail.com>
References: <8bb80c380907281849i1cd271f3n64a391327cd8bb5e@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F58506D2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:6931 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZG3XUC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 19:20:02 -0400
Received: by wf-out-1314.google.com with SMTP id 26so484039wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2009 16:20:03 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F58506D2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jul 30, 2009 at 8:44 AM, Pandita, Vikram<vikram.pandita@ti.com>=
 wrote:
>
>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.=
kernel.org] On Behalf Of Mike
>>Chan
>>Sent: Tuesday, July 28, 2009 8:49 PM
>>To: Kevin Hilman; linux-omap@vger.kernel.org
>>Subject: drivers that require headers in mach-omap
>>
>>Omap folks, how are drivers that require access to prm and cm
>>registers via cm_read_mod_reg() etc... suppose to access these?
>>
>>For example if drivers/usb/host/ohci-omap.c wanted to call:
>>cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_IDLEST);
>
> The design was supposed to encapsulate the PRCM API's from drivers.
> Driver has control over the iclk and fclk and the clock framework wou=
ld take care of any CM/PRM register settings.
>
> Accessing these registers in drivers would make the driver non-compat=
ible for non-omap platforms.
>

Are drivers such as

drivers/usb/host/ohci-omap.c
drivers/usb/musb/omap2430.c

suppose to be compatible for non-omap platforms?

-- Mike

>>
>>It seems some of the headers in mach-omap2 should be in
>>plat-omap/include/mach, or is there a more elegant way? The other
>>alternatives are to register calls in all the board files, or #includ=
e
>>../../.. both do not seem very elegant to me.
>>
>>-- Mike
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
