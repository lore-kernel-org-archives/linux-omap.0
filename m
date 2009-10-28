From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: OMAP DSS2 - bpp problem
Date: Wed, 28 Oct 2009 11:10:27 +0200
Message-ID: <1256721027.24999.11.camel@tubuntu.research.nokia.com>
References: <4AE80892.3090106@cioinfoindus.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56152 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757AbZJ1JKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 05:10:45 -0400
In-Reply-To: <4AE80892.3090106@cioinfoindus.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Laurent Epinat <laurent.epinat@cioinfoindus.fr>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

You can define default modes in board file, using platform data for
omapfb.

See omapfb.h:

struct omapfb_platform_data
struct omapfb_mem_desc
struct omapfb_mem_region
omapfb_set_platform_data(). 

If you need to do it dynamically in boot scripts, you can change the
mode via the normal fb interface. You don't need to expose
recommended_bpp.

 Tomi

Ps. Please also cc linux-omap mailing list, so other people will see the
answers also.


On Wed, 2009-10-28 at 10:02 +0100, ext Laurent Epinat wrote:
> Hello Tomi,
> 
> I would like to know your opinion.
> 
> We had own board with 2 differents configuration
> First with VGA/DVI display and the other with LCD panel (Prime view)
> for each configuration we need to used 2 differents color depth (24 bpp, 
> 16 bpp).
> 
> For the vga I can override the parameters with the module args 
> (mode=dvi:1024x768-16@60)
> but for the lcd panel is not working, I seen in the display.c
> than the get_recommended_bpp() return the data_lines of the panel (own 
> panel has 18 physical lines but connected like 24 lines)
> 
> I decided to expose the variable panel.recommended_bpp in the sysfs for 
> forcing the value, it works but I think it's really dirty
> cause in one case I'm using
> 
> 	modprobe omapdss def_disp=lcd
> 	modprobe panel_primeview_pm070wt3
> 	if [ x${OGLES} = x"yes" ]; then
>   		echo "16" > /sys/devices/omapdss/display0/recommended_bpp
>      	fi
>      	modprobe omapfb vram=0:4M,1:4M,2:4M
> 
> 
> and the other case :
> 
> 	modprobe omapdss def_disp=dvi
> 	modprobe panel_generic
> 	if [ x${OGLES} = x"yes" ]; then
> 		SCREEN_MODE="mode=dvi:1024x768-16@60"
> 	else
> 		SCREEN_MODE="mode=dvi:1024x768-24@60"
> 	fi
> 	modprobe omapfb vram=0:4M,1:4M,2:4M :${SCREEN_MODE}
> 
> 
> Have you any ideas to do it better?
> 
> 
> sorry for my english
> 

