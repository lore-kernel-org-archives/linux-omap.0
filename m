From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Thu, 21 Jun 2012 21:36:12 +0300
Message-ID: <CAPo=G1wbwt_wO8HV7+WqTqDcFO6bbjj2eYSNwNVMGyhDM_1vuw@mail.gmail.com>
References: <20120427165032.GD28062@n2100.arm.linux.org.uk>
	<CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com>
	<20120427171933.GE28062@n2100.arm.linux.org.uk>
	<CAPo=G1wDANyQ5ARyerizp6oA=Wyc7s_to7zfz-n4GdZ20tfX4g@mail.gmail.com>
	<20120427183116.GF28062@n2100.arm.linux.org.uk>
	<20120427193129.GA3951@n2100.arm.linux.org.uk>
	<20120429203525.GA4618@n2100.arm.linux.org.uk>
	<4F9E3EB5.8030104@ti.com>
	<20120621125903.GA17984@n2100.arm.linux.org.uk>
	<20120621131642.GA27383@n2100.arm.linux.org.uk>
	<20120621132249.GA27635@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:54725 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759018Ab2FUSgO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jun 2012 14:36:14 -0400
Received: by yenl8 with SMTP id l8so934263yen.13
        for <linux-omap@vger.kernel.org>; Thu, 21 Jun 2012 11:36:12 -0700 (PDT)
In-Reply-To: <20120621132249.GA27635@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

Hi Russel,

On Thu, Jun 21, 2012 at 4:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> Okay, reverting back to v3.4-rc4 works.
>
> As does reverting to v3.4, of course. =A0So, it was broken during the=
 last
> merge window.

Strange...
I had no problem with the SDP4430/Blaze audio with 3.5-rc2 last week.
Have you restored the mixers with
alsactl -f blaze.aconf restore
command?

Does aplay (seemingly) plays the file OK or is it times out with an
error after a while?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
