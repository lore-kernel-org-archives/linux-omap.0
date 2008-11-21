From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: defconfig for omap3-evm
Date: Fri, 21 Nov 2008 15:46:31 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B6C8CE09@dbde02.ent.ti.com>
References: <52c7556c0811210204h13f4a582r7d3add4b790863f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44505 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbYKUKQl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 05:16:41 -0500
In-Reply-To: <52c7556c0811210204h13f4a582r7d3add4b790863f0@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Pundir <pundiramit@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Amit Pundir
> Sent: Friday, November 21, 2008 3:34 PM
> To: linux-omap@vger.kernel.org
> Subject: defconfig for omap3-evm
> 
> Greetings!
> 
> Can anyone please tell me which defconfig should I use for 
> building linux-omap kernel (linux-2.6.22.1 + 
> patch-2.6.22-omap1) for my omap3evm board? I'm getting the 
> following error if I use omap3evm_defconfig(with IPV6 enabled 
> and PM disabled) that comes with the TI kernel.

When you say TI kernel, is it the one you received with your EVM package?

If so, you will need to continue using the same defconfig.

> 
> ------------------------------------------------------------------
>   CC      lib/vsprintf.o
>   AR      lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arm-none-linux-gnueabi-ld: no machine record defined
> arm-none-linux-gnueabi-ld: no machine record defined

This warning can come due to many reasons. When related to the configuration, it points to inconsistencies in your .config against the defconfig.

If you have made many changes to the .config/defconfig I suggest you make incremental updates to narrow the change leading to these warnings.

> drivers/built-in.o: In function `omapfb_do_probe':
> /home/amit/omap35xx/ti/muru_linux/linux-2.6.22.1/drivers/video
> /omap/omapfb_main.c:1777:
> undefined reference to `omap2_int_ctrl'
> drivers/built-in.o: In function `musb_stage2_irq':
> /home/amit/omap35xx/ti/muru_linux/linux-2.6.22.1/drivers/usb/m
> usb/plat_uds.c:739:
> undefined reference to `musb_hnp_stop'
> make: *** [.tmp_vmlinux1] Error 1

Both these errors don't seem to be related to IVP6. The only reason they could occur after disabling PM is - these functions defined within an #ifdef CONFIG_PM. Can you check if this is the case?

> ------------------------------------------------------------------
> 
> Is there any patch or work-around available for this problem?
> Thanks for your concern.
> 
> Regards
> Amit Pundir
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 

Best regards,
Sanjeev 
