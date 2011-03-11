From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v12 6/9] dmtimer: switch-over to platform device driver
Date: Fri, 11 Mar 2011 18:15:33 +0530
Message-ID: <20110311124533.GA7492@m-desktop>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-7-git-send-email-tarun.kanti@ti.com>
 <20110309220241.GR26463@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD852@dbde02.ent.ti.com>
 <20110310175611.GV26463@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD9D2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:44841 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753265Ab1CKMrc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 07:47:32 -0500
Received: by mail-yx0-f180.google.com with SMTP id 1so1383796yxe.39
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 04:47:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD9D2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Mar 11, 2011 at 11:05:25AM +0530, DebBarma, Tarun Kanti wrote:
> [...]
> > > >
> > > > * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110308 15:41]:
> > > > > switch-over to platform device driver through following changes:
> > > > > (a) initiate dmtimer early initialization from omap2_gp_timer_init()
> > > > > in timer-gp.c. This is equivalent of timer_init()->timer->init().
> > > > > (b) modify plat-omap/dmtimer routines to use new register map and
> > > > > platform data.
> > > >
> > > > This patch breaks booting for 2420 and makes boot hang early
> > > > on 2430. Note that to test with omap-for-linus branch you need
> > > > to disable the following in omap2plus_defconfig:
> > > >
> > > > CONFIG_ARCH_OMAP3
> > > > CONFIG_ARCH_OMAP4
> > > > CONFIG_CPU_32v6K
> > > I disabled above options on omap-for-linus *WITHOUT* my patch series.
> > > I am still seeing crash. Here is the log.
> > > I tried on two different setups. Not sure if I am missing something.
> > 
> > Hmm sounds like H4 needs some attention. Can you try the following
> > completely untested patch?
> 
> This works fine!

I tried to use below patch for booting  OMAP2420 H4 on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
Branch: omap-for-linus
commit 94a06b74e724caabcf0464c81527cfbcae0c8aff
Merge: 0dde52a 9062511
Author: Tony Lindgren <tony@atomide.com>
Merge branch 'for_2.6.39/pm-misc' of
ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm
into omap-for-linus

Looks like it stops after uncompressing kernel. Same setup works fine
with tag v2.6.37.

OMAP242x H4 # boot                                                              
Using MAC Address 10:20:30:40:50:61                                             
TFTP from server 10.24.244.97; our IP address is 10.24.244.196                  
Filename 'uImage'.                                                              
Load address: 0x80300000                                                        
Loading:
#################################################################      
         #################################################################      
         #################################################################      
         #################################################################      
         #################################################################      
         #################################################################      
         #################################################################      
         #################################################################      
         #########################################################              
done                                                                            
Bytes transferred = 2950216 (2d0448 hex)                                        
## Booting image at 80300000 ...                                                
   Image Name:   Linux-2.6.38-rc8-00188-g94a06b7-                               
   Image Type:   ARM Linux Kernel Image (uncompressed)                          
   Data Size:    2950152 Bytes =  2.8 MB                                        
   Load Address: 80008000                                                       
   Entry Point:  80008000                                                       
   Verifying Checksum ... OK                                                    
OK                                                                              
                                                                                
Starting kernel ...                                                             
                                                                                
Uncompressing Linux... done, booting the kernel.                                

-Manjunath

> --
> Tarun
> 
> > 
> > Tony
> > 
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Thu, 10 Mar 2011 09:51:29 -0800
> > Subject: [PATCH] omap: Fix H4 init_irq to not call h4_init_flash
> > 
> > There should be no reason to call h4_init_flash this
> > early. It causes problems as things are not yet initialized.
> > 
> > Note: This patch has not been tested.
> > 
> > Not-Yet-Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > --- a/arch/arm/mach-omap2/board-h4.c
> > +++ b/arch/arm/mach-omap2/board-h4.c
> > @@ -299,7 +299,6 @@ static void __init omap_h4_init_early(void)
> >  static void __init omap_h4_init_irq(void)
> >  {
> >  	omap_init_irq();
> > -	h4_init_flash();
> >  }
> > 
> >  static struct at24_platform_data m24c01 = {
> > @@ -372,6 +371,7 @@ static void __init omap_h4_init(void)
> >  	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
> >  	omap2_usbfs_init(&h4_usb_config);
> >  	omap_serial_init();
> > +	h4_init_flash();
> >  }
> > 
> >  static void __init omap_h4_map_io(void)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
