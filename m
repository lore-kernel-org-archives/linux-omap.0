From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Wed, 9 Nov 2011 19:33:31 +0800
Message-ID: <CACVXFVO-ay4auvF+=+b7pagcfaYOkEeZb212TiaysJ2A6p14Eg@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-5-git-send-email-ming.lei@canonical.com>
	<alpine.DEB.2.00.1111080837250.10451@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33726 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab1KILdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2011 06:33:33 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RO6PL-0006FZ-S1
	for linux-omap@vger.kernel.org; Wed, 09 Nov 2011 11:33:31 +0000
Received: by wyh15 with SMTP id 15so1491903wyh.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Nov 2011 03:33:31 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1111080837250.10451@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi,

On Tue, Nov 8, 2011 at 11:42 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi
>
> I just read
>
> http://comments.gmane.org/gmane.comp.embedded.pandaboard/168
>
> Looks to me that the L3_EMU interconnect and the emulation IP blocks =
need

You mean the "emu" hwmod in the patch should be kept and a new "l3_emu"=
 hwmod
need to be added? and make the clkdm_name of 'l3_emu' points to CD_L3_2=
?

But in the link above, looks like the hwmod of "l3_main_3" and "l3_inst=
r" need
to be enabled for routing IRQs of pmu on omap4.

> to be added to the OMAP4 hwmod data, based on Section 2.2.1 "L3_EMU M=
emory
> Space Mapping" in the OMAP4460 TRM Rev. I. =A0If the clockdomain &
> powerdomain are correctly defined then the OMAP framework code will
> automatically enable these too.

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
