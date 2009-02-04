From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: OMAP3: Low DDR Memory bandwidth
Date: Wed, 4 Feb 2009 14:14:37 +0100
Message-ID: <200902041414.38032.marek.vasut@gmail.com>
References: <703092.95158.qm@web112223.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:42969 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbZBDNOg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 08:14:36 -0500
Received: by ewy14 with SMTP id 14so3261628ewy.13
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 05:14:33 -0800 (PST)
In-Reply-To: <703092.95158.qm@web112223.mail.gq1.yahoo.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ganeshan N <nganeshan1@yahoo.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 04 of February 2009 13:47:41 Ganeshan N wrote:
> Hi All,
> I am using OMAP3EVM and measuring DDR memory bandwidth. Used "lmbench=
" to
> measure the bandwidth.=A0 I am getting low bandwidth around 460 MB/S =
in TI
> kernel 2.6.22 and getting bandwidth around 800 MB/S in git kernel
> 2.6.28-rc8.
>
> In kernel 2.6.22, there are two SDRC registers (SDRC_DLLA_CTRL and
> SDRC_POWER_REG), which are getting modified. I have updated code such=
 that
> SDRC values for both the=A0 the kernel 2.6.22 and 2.6.28 are same. Af=
ter this
> updation there is no improvement in the bandwidth.=A0 The SDRC is run=
ning at
> 166MHz.=A0 I am using same x-loader and u-boot for both the kernel (2=
=2E6.22
> and 2.6.28).
>
> Can you please suggest some pointers/methods, to increase the=A0DDR m=
emroy
> bandwidth in 2.6.22=A0TI kernel.
>
> Thanks in advance.

why don't you use the .28 one then ? .22 is way too deprecated.
>
> With Regards
> Ganeshan
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
