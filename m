From: Diego Dompe <diego.dompe@ridgerun.com>
Subject: Re: GUI for OMAP3EVM
Date: Thu, 28 Aug 2008 05:38:11 -0600
Message-ID: <39CFFEB2-BFB1-4138-9A50-D7B8F2B53C1C@ridgerun.com>
References: <c656a4d20808280151u74b3f6d6xbda61097ebe3fb1e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:45731 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbYH1MR6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Aug 2008 08:17:58 -0400
In-Reply-To: <c656a4d20808280151u74b3f6d6xbda61097ebe3fb1e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Arun,

Besides QT, you can try with DFB + GTK on DFB. Anyway having an X  
based GUI is not a big deal considering the hardware performance and  
storage capacities on any embedded device running an OMAP3x processor.  
We have ported DFB, GTK and Webkit/Gtk to the EVM and they run pretty  
well.

However you need to consider that if in the future (or now) you want  
to take advantage of the hardware acceleration (SGX hardware) for  
rendering with 3D capabilities any of this technologies may have  
problems integrating OpenGL ES renderings (because there is not  
standard OGLES stack for Linux, so there is no _simple_ way to  
integrate it with existing X extension, or any of the other stacks,  
beyond having a OGL surface withint all your standard widgets). A good  
approach on this case is to use clutter (clutter-project.org) to  
create rich UIs, but at this point you will find this software stack a  
little bit lacking for any other input than a touchscreen (nothing  
that cannot be solved in the future). We have done some work  
integrating clutter with experimental OGLES drivers and it works  
perfectly on the EVM.

Regards,

Diego Dompe
RidgeRun Engineering

On Aug 28, 2008, at 2:51 AM, arun c wrote:

> Hi All,
>
> I want to have a GUI on OMAP3EVM.
> Basically I am looking for a GUI stack that can work on top of linux  
> framebuffer
> device(Eg: DirectFb).
>
> X window based GUI is not suitable for embedded
> devices, am I right?
>
> Does any body tried this?
>
> Regards,
> Arun C
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

