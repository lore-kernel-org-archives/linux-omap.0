From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 00/18] OMAP2,3: hwmod DSS Adaptation
Date: Thu, 20 Jan 2011 21:06:27 -0800
Message-ID: <87fwsmj164.fsf@ti.com>
References: <1295196103-29417-1-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:44820 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab1AUFLt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 00:11:49 -0500
Received: by gxk10 with SMTP id 10so453973gxk.12
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 21:11:48 -0800 (PST)
In-Reply-To: <1295196103-29417-1-git-send-email-sumit.semwal@ti.com> (Sumit
	Semwal's message of "Sun, 16 Jan 2011 22:11:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hi Sumit,

Sumit Semwal <sumit.semwal@ti.com> writes:

[...]

> Testing:
> ---------
> The patches are tested on 2420-n800, 2430sdp, 3630zoom, 3430sdp.
> Complete bootup with penguins on panel is done on 3430sdp.
> For the rest of the mentioned platforms, kernel is built with "OMAP2_DSS"
> and bootup is tested so that base address and clk_get calls are successful.

I think this series needs more validation on the other platforms.
Getting a visible framebuffer w/tux on all tested platforms seems like a
minimal requirement.

I gave a test of this on 3530/Beagle with CONFIG_PANEL_GENERIC_DPI=y and
driving a DVI monitor, using the following kernel cmdline

# cat /proc/cmdline                                                 
console=ttyO2,115200n8 mpurate=600 vram=12M omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_disp=dvi root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait

Without your series, I see penguin logo and get a console login on the
screen with this boot log (from dmesg |grep -i omapfb):

[    2.651885] OMAPFB: omapfb_init                                              
[    2.652160] OMAPFB: omapfb_probe                                             
[    2.657653] OMAPFB: create 3 framebuffers                                    
[    2.657714] OMAPFB: fb_infos allocated                                       
[    2.657714] OMAPFB: allocating 1572864 bytes for fb 0                        
[    2.668212] OMAPFB: allocated VRAM paddr 8f400000, vaddr d0a00000            
[    2.668243] OMAPFB: region0 phys 8f400000 virt d0a00000 size=1572864         
[    2.668243] OMAPFB: region1 phys 00000000 virt   (null) size=0               
[    2.668273] OMAPFB: region2 phys 00000000 virt   (null) size=0               
[    2.668273] OMAPFB: fbmems allocated                                         
[    2.668518] OMAPFB: check_fb_var 0                                           
[    2.668548] OMAPFB: max frame size 1572864, line size 2048                   
[    2.668548] OMAPFB: xres = 1024, yres = 768, vxres = 1024, vyres = 768       
[    2.668579] OMAPFB: set_fb_fix                                               
[    2.669036] OMAPFB: fb_infos initialized                                     
[    2.673522] OMAPFB: set_par(0)                                               
[    2.673614] OMAPFB: set_fb_fix                                               
[    2.673614] OMAPFB: apply_changes, fb 0, ovl 0                               
[    2.673645] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 1024, outh 768     
[    2.673645] OMAPFB: paddr 8f400000, vaddr d0a00000                           
[    2.674346] OMAPFB: pan_display(0)                                           
[    2.674346] OMAPFB: setcmap                                                  
[    2.674377] OMAPFB: setcmap                                                  
[    2.683746] OMAPFB: pan_display(0)                                           
[    2.683776] OMAPFB: setcmap                                                  
[    2.692108] OMAPFB: setcmap                                                  
[    2.701599] OMAPFB: framebuffers registered                                  
[    2.701629] OMAPFB: apply_changes, fb 0, ovl 0                               
[    2.701660] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 1024, outh 768     
[    2.701690] OMAPFB: paddr 8f400000, vaddr d0a00000                           
[    2.701721] OMAPFB: apply_changes, fb 1, ovl 1                               
[    2.701751] OMAPFB: apply_changes, fb 2, ovl 2                               
[    2.701751] OMAPFB: create_framebuffers done                                 
[    2.702331] OMAPFB: mgr->apply'ed                                            
[    2.704803] OMAPFB: create sysfs for fbs                                     
[    2.704833] OMAPFB: create sysfs for fbs                                     

With your series applied (no other changes), I don't see anything on the
screen because omapfb_probe() fails:

[    2.519653] OMAPFB: omapfb_init                                              
[    2.519958] OMAPFB: omapfb_probe                                             
[    2.520019] omapfb omapfb: no driver for display                             
[    2.525115] OMAPFB: free_resources                                           
[    2.525146] OMAPFB: free all fbmem                                           
[    2.525177] omapfb omapfb: failed to setup omapfb                            

which indicates that omap_dss_get_device() is failing in omapfb_probe().

Kevin
