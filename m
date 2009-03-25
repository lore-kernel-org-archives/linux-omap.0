From: twebb <taliaferro62@gmail.com>
Subject: Re: MMC2 support in linux-omap-2.6.27 (omap1)
Date: Wed, 25 Mar 2009 17:49:37 -0400
Message-ID: <dbdb2ea60903251449u5d8e3edfvd58291923ecf6693@mail.gmail.com>
References: <dbdb2ea60903250713s2eba347aib5758cf5157979da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:55761 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZCYVtk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 17:49:40 -0400
Received: by qw-out-2122.google.com with SMTP id 8so284496qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 14:49:38 -0700 (PDT)
In-Reply-To: <dbdb2ea60903250713s2eba347aib5758cf5157979da@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wed, Mar 25, 2009 at 10:13 AM, twebb <taliaferro62@gmail.com> wrote:
> I'm currently using linux-omap-2.6.27 (tag=3Domap1) and trying to add
> MMC2 support. =A0I've back ported what I think I need from various fi=
les
> inn l-o-2.6.28-omap1. =A0I will eventually move to 2.6.28-omap1 but f=
or
> now am trying to get it working on 2.6.27.
>
> Traces show that all looks good up until first command is issued, the=
n
> nothing seems to happen. =A0STAT reg shows 0, don't see clock or cmd
> activity. =A0MMC1 is working fine with an SD card; MMC2 is connected =
to
> eMMC flash. =A0Seems like I'm missing something basic like a clock or
> enable, though I've confirmed ICLK and FCLK are enabled. =A0Any ideas=
?
>
> Thanks,
> twebb
>

I found at least part of my problem.  SDVS field of HCTL was being set
to 0x7 (3.3V) instead of 0x5 (1.8V), and apparently MMC2 must be set
for 0x5.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
