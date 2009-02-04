From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: OMAP3: Low DDR Memory bandwidth
Date: Wed, 04 Feb 2009 14:18:17 +0000
Message-ID: <yw1xy6wms2ty.fsf@thrashbarg.mansr.com>
References: <703092.95158.qm@web112223.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43302 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbZBDOS3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Feb 2009 09:18:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LUiaC-0003tL-RK
	for linux-omap@vger.kernel.org; Wed, 04 Feb 2009 14:18:28 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 14:18:28 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 14:18:28 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Ganeshan N <nganeshan1@yahoo.com> writes:

> Hi All,
> I am using OMAP3EVM and measuring DDR memory bandwidth. Used "lmbench=
"
> to measure the bandwidth.=A0 I am getting low bandwidth around 460 MB=
/S
> in TI kernel 2.6.22 and getting bandwidth around 800 MB/S in git
> kernel 2.6.28-rc8.
>
> In kernel 2.6.22, there are two SDRC registers (SDRC_DLLA_CTRL and
> SDRC_POWER_REG), which are getting modified. I have updated code such
> that SDRC values for both the=A0 the kernel 2.6.22 and 2.6.28 are
> same. After this updation there is no improvement in the bandwidth.=A0
> The SDRC is running at 166MHz.=A0 I am using same x-loader and u-boot
> for both the kernel (2.6.22 and 2.6.28).
>
> Can you please suggest some pointers/methods, to increase the=A0DDR
> memroy bandwidth in 2.6.22=A0TI kernel.

Check your cache settings.  Enabling or disabling the L2 cache can
have dramatic effects on memory throughput.  For mainly sequential
accesses disabling it can be faster.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
