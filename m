From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 22:17:19 +0300
Message-ID: <CAPo=G1xj8ukm9++DtrKcJQ=iW2iOsAxPvAp5GHCXu35J8fQnBA@mail.gmail.com>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk>
	<CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com>
	<20120427160445.GC28062@n2100.arm.linux.org.uk>
	<CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com>
	<20120427165032.GD28062@n2100.arm.linux.org.uk>
	<CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com>
	<20120427171933.GE28062@n2100.arm.linux.org.uk>
	<CAPo=G1wDANyQ5ARyerizp6oA=Wyc7s_to7zfz-n4GdZ20tfX4g@mail.gmail.com>
	<20120427183116.GF28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:59832 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761289Ab2D0TRV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 15:17:21 -0400
Received: by iakl21 with SMTP id l21so1595263iak.9
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 12:17:20 -0700 (PDT)
In-Reply-To: <20120427183116.GF28062@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

Hi Russell,

On Fri, Apr 27, 2012 at 9:31 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> Can you check if you have this commit:
>> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dc=
ommit;h=3D8eaeb9393397be8eb700ab38a69c450975463b77
>
> I don't have that in the branch I'm building because I started the
> DMA engine work against v3.4-rc3.
>
>> This is the second patch to separate the twl6040 from twl-core.
>> If you are missing this patch twl6040 will not probe (twl core will
>> not register the audio if we have twl6030).
>
> So it sounds like if I rebase stuff forward to -rc4, it should start
> working?

Yes, it should.
Unfortunately the two patch went separately to avoid merge issues.
You will need to configure the Headset path to be able to hear the audi=
o.
I can send my .aconf if you are interested.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
