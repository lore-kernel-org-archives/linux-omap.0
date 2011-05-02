From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] omap:usb: fixing ehci phy gpio values for omap3
Date: Mon, 2 May 2011 17:53:18 +0530
Message-ID: <BANLkTimCsBXProWJ=sxN2TPkkxKYHPAqhQ@mail.gmail.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
	<1303395763-8702-2-git-send-email-keshava_mgowda@ti.com>
	<20110502093815.GQ2529@legolas.emea.dhcp.ti.com>
	<BANLkTi=kH02P9GFo6wmPpRGr=L582DEp0A@mail.gmail.com>
	<20110502115408.GC2529@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:58781 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752834Ab1EBM3O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 May 2011 08:29:14 -0400
In-Reply-To: <20110502115408.GC2529@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gadiyar@ti.com, p-basak2@ti.com, axel.lin@gmail.com, johnstul@us.ibm.com, mpfj-list@mimc.co.uk

On Mon, May 2, 2011 at 5:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, May 02, 2011 at 05:01:05PM +0530, Munegowda, Keshava wrote:
>> On Mon, May 2, 2011 at 3:08 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > On Thu, Apr 21, 2011 at 07:52:42PM +0530, Keshava Munegowda wrote:
>> >> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>> >>
>> >> The gpio of EHCI phy should be 0 instead of 1;
>> >> This fixes the hub enumeration issue in beagle xm board.
>> >>
>> >> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> >
>> > applied, thanks
>> >
>> > --
>> > balbi
>>
>> Thanks balbi
>>
>> but ,.his patch is was made by Juergen Kilb ( patch description =A0a=
nd link is
>> given below); But I was not aware of it and reinvented wheel with
>> beagle-xm board :(
>>
>> So, Juergen Kilb is the first author of this patch.
>>
>> Here is the link :
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg48215.html
>>
>> =A0 omap:usbhs:Fixed gpio polarity of gpio USB-phy reset
>>
>> =A0 =A0 With commit 19403165 a main part of ehci-omap.c moved to
>> =A0 =A0 drivers/mfd/omap-usb-host.c created by commit 17cdd29d.
>> =A0 =A0 Due to this reorganisation the polarity used to reset the
>> =A0 =A0 external USB phy changed and USB host doesn't recognize
>> =A0 =A0 any devices.
>>
>> =A0 =A0 Signed-off-by: Juergen Kilb <J.Kilb@phytec.de>
>
> I sent a pull request to Greg with that patch in, so it looks like
> Samuel also didn't send this patch before. Can you reply to the pull
> request I sent saying that this patch should be dropped just so Greg
> knows and I recreate the branch and send another pull request ?
>
> --
> balbi

yes Balbi, I have send a mail to Greg.

once again, I am sorry ,  this patch came in 14th april and i was
returning from ELC-2011. I missed it.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
