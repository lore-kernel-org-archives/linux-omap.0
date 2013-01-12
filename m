From: <Madhusudhan.Gowda@elektrobit.com>
Subject: RE: Querry on UART wakeup on Linux 3.8-rc1
Date: Sat, 12 Jan 2013 21:56:26 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA803EEA5F5@fioues07.ebgroup.elektrobit.com>
References: <B668883EB5DD7144ADFC248A72176EA803E743F9@fioues07.ebgroup.elektrobit.com> <B668883EB5DD7144ADFC248A72176EA803E74A7A@fioues07.ebgroup.elektrobit.com> <alpine.DEB.2.00.1301071827440.24780@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpgw2fi.elektrobit.com ([194.136.18.129]:35164 "EHLO
	smtpgw1fi.elektrobit.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754330Ab3ALT4e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Jan 2013 14:56:34 -0500
Received: from fioumg02.ebgroup.elektrobit.com (smtpgw2fi.ebgroup.elektrobit.com [127.0.0.1])
	by smtpgw1fi.elektrobit.com (8.13.8/8.13.8) with ESMTP id r0CJuUXd013431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 12 Jan 2013 21:56:31 +0200
Received: (from defang@localhost)
	by fioumg02.ebgroup.elektrobit.com (8.13.8/8.13.8/Submit) id r0CJuRWW013428
	for <linux-omap@vger.kernel.org>; Sat, 12 Jan 2013 21:56:27 +0200
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.1301071827440.24780@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, t-kristo@ti.com, rnayak@ti.com

Thanks for the reply Paul.

I  will check the boot loader version and try with latest.

Best Regards,
Gowda

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
Sent: 07. tammikuuta 2013 20:40
To: Gowda Madhusudhan
Cc: linux-omap@vger.kernel.org; t-kristo@ti.com; rnayak@ti.com
Subject: RE: Querry on UART wakeup on Linux 3.8-rc1

Hi,

On Sun, 6 Jan 2013, Madhusudhan.Gowda@elektrobit.com wrote:

> Could  someone point me if it has been working in any of the releases
?

Serial wakeup from retention suspend seems to work on the OMAP4460
Panda-ES here as of v3.8-rc1, with a really recent U-boot[*]:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/pm/4460p
andaes/4460pandaes_log.txt

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/README.t
xt

(There are some warnings present from the power state debugging code, so
there's probably something that could use a closer look.)

The problem is, you need a really recent bootloader for this to work.  
This is because the mainline kernel is missing code to idle several
on-chip devices (IVAHD, DSP, etc.).  This can be seen with the OMAP4430
boot logs:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/pm/4430e
s2panda/4430es2panda_log.txt

That board is running an "older" bootloader - from July 2012!

The hope is that some of the folks still working for TI can post the
appropriate reset and idle code for these devices.  Or at least, we'd
better add a console warning to the OMAP44xx PM init code that warns
about the bootloader dependencies.  Any comments from the TI folks here?


- Paul

> 
> Thanks,
> Gowda
> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org]
> Sent: 01. tammikuuta 2013 22:08
> To: linux-omap@vger.kernel.org
> Subject: Querry on UART wakeup on Linux 3.8-rc1
> 
> Hi,
> 
> I tried to wakeup OMAP430 ES2.1 Panda from static suspend retention 
> using console uart2, it doesn't wakeup.
> But could configure GPIO_121 button to wake up from retention fine.
> 
> On the serial uart side I have manually enabled wakeup by echo enabled

> > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
> 
> I could see the wakeup enable bit (1<<14)  of  uart irrx pad register 
> is being set properly before it does static suspend fine.
> 
> Should I need to do any more thing to get it work?
> 
> Thanks,
> Gowda
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org More majordomo info
at  http://vger.kernel.org/majordomo-info.html
