From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: tidspbridge: problems executing sample apps
Date: Thu, 16 Jun 2011 15:56:03 -0500
Message-ID: <BANLkTinkudMjuDZ-KGCO5gpYikUhiYuxJA@mail.gmail.com>
References: <BANLkTinawxhRF2FWBrR=vpfCraM=xLX4mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46095 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758080Ab1FPU4M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 16:56:12 -0400
Received: by wwi36 with SMTP id 36so1604968wwi.2
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 13:56:09 -0700 (PDT)
In-Reply-To: <BANLkTinawxhRF2FWBrR=vpfCraM=xLX4mA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: linux-omap@vger.kernel.org

Hi Javier,

On Wed, Jun 15, 2011 at 10:19 AM, javier Martin
<javier.martin@vista-silicon.com> wrote:
> Hi,
>
> 1- If I try prebuilt binaries (both for DSP side and userspace) I get
> an execution error:
=2E..
> DSPNode_GetMessage failed: 0xffffffc2

In this case, sample application is working, however the failures on
get_message are unexpected, it seems this arose when the error codes
were changed and the precompiled binaries where not updated, I'll fix
this, thanks for the heads up.

> 3- If I compile both DSP side and MPU side samples it also gives an
> execution error:
=2E..
> root@beagleboard:/dspbridge# ./ping.out
> DSP device detec[ =A0 64.484649] procwrap_detach: deprecated dspbridg=
e ioctl
> ted !!
> DSPNode_Create failed: 0xffffffe3
>
=2E..
> Do you know what combination of DSP bios, TI CGT and xdctools is most
> suitable for using with tidspbridge in kernel 2.6.39?

This is mentioned in the wiki: bios 5.33.04 and cgt tools 6.0.7
http://omapedia.org/wiki/DSPBridge_Project#Initial_environment_setup

This version of the bios already has the xdc tools bundled. BTW I
replied to your gforge query in case it gives any information:
http://bit.ly/laeJFD

I also applied your patch to fix copying the dsp binaries on the build
system, thanks!

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
