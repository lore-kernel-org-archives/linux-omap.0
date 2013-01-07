From: Paul Walmsley <paul@pwsan.com>
Subject: RE: Querry on UART wakeup on Linux 3.8-rc1
Date: Mon, 7 Jan 2013 18:40:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301071827440.24780@utopia.booyaka.com>
References: <B668883EB5DD7144ADFC248A72176EA803E743F9@fioues07.ebgroup.elektrobit.com> <B668883EB5DD7144ADFC248A72176EA803E74A7A@fioues07.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53746 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3AGSkE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jan 2013 13:40:04 -0500
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA803E74A7A@fioues07.ebgroup.elektrobit.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan.Gowda@elektrobit.com
Cc: linux-omap@vger.kernel.org, t-kristo@ti.com, rnayak@ti.com

Hi,

On Sun, 6 Jan 2013, Madhusudhan.Gowda@elektrobit.com wrote:

> Could  someone point me if it has been working in any of the releases ?

Serial wakeup from retention suspend seems to work on the OMAP4460 
Panda-ES here as of v3.8-rc1, with a really recent U-boot[*]:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/pm/4460pandaes/4460pandaes_log.txt

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/README.txt

(There are some warnings present from the power state debugging 
code, so there's probably something that could use a closer look.)

The problem is, you need a really recent bootloader for this to work.  
This is because the mainline kernel is missing code to idle several 
on-chip devices (IVAHD, DSP, etc.).  This can be seen with the OMAP4430 
boot logs:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/pm/4430es2panda/4430es2panda_log.txt

That board is running an "older" bootloader - from July 2012!

The hope is that some of the folks still working for TI can post the 
appropriate reset and idle code for these devices.  Or at least, we'd 
better add a console warning to the OMAP44xx PM init code that warns about 
the bootloader dependencies.  Any comments from the TI folks here?


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
> On the serial uart side I have manually enabled wakeup by echo enabled >
> /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
> 
> I could see the wakeup enable bit (1<<14)  of  uart irrx pad register is
> being set properly before it does static suspend fine.
> 
> Should I need to do any more thing to get it work?
> 
> Thanks,
> Gowda
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

