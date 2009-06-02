From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2: How to test TV and LCD output simulatenously
Date: Tue, 02 Jun 2009 11:21:57 +0300
Message-ID: <1243930917.24975.10.camel@tubuntu>
References: <5F744A5A3C131242B81CE5874BD2CFFB34E35EAC@dlee01.ent.ti.com>
	 <ca6476860906012122q4f90c34ay2c98a76cd3921aa1@mail.gmail.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46394 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760069AbZFBIWE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 04:22:04 -0400
In-Reply-To: <ca6476860906012122q4f90c34ay2c98a76cd3921aa1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext halli manjunatha <hallimanju@gmail.com>
Cc: "Venkatesh, Subbu" <subbu.wrs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shah, Hardik" <hardik.shah@ti.com>

Hi,

On Tue, 2009-06-02 at 06:22 +0200, ext halli manjunatha wrote:
> Hi subbu,
> first boot the board including      omapfb.vram="1:2M"    in boootargs
> and follow the below steps it will enable both just try it it should work

You don't need to use the module parameters for that. You can allocate
memory for the framebuffer by echoing

echo mem-amount > /sys/class/graphics/fb?/size

Note that the overlays connected to that framebuffer need to be
disabled.

Also, in your example below, you don't even use fb1, so I don't see much
point in allocating 2M for it.

 Tomi

> 
> 
> ***********************************************************************************
> echo "0" > /sys/devices/platform/omapdss/overlay0/enabled
> echo "0" > /sys/devices/platform/omapdss/overlay1/enabled
> 
> echo "" > /sys/class/graphics/fb1/overlays
> echo "0,1" > /sys/class/graphics/fb0/overlays
> 
> echo "720,564" > /sys/devices/platform/omapdss/overlay1/output_size
> echo "tv" > /sys/devices/platform/omapdss/overlay1/manager
> 
> echo "1" > /sys/devices/platform/omapdss/overlay0/enabled
> echo "1" > /sys/devices/platform/omapdss/overlay1/enabled
> 
> 
> echo "1" > /sys/devices/platform/omapdss/display2/enabled
> 
> 
> 
> **********************************************************************************
> 
> 
> On Tue, Jun 2, 2009 at 7:54 AM, Venkatesh, Subbu <subbu.wrs@ti.com> wrote:
> > Hi,
> > I have DSS2 ported on LDP board, I could manage to get output display on TV and LCD interface individually, also tested some of the features like Rotation and Mirroring, they worked with out any problem.
> > Now I am trying to get output both on TV and LCD simultaneously,
> >
> > I was not successful with my approach that I tried, like
> >
> > 1. Boot the kernel with the default LCD display
> > 2. Then I enabled ntsc timings for TV, as PAL do not work on it.
> >    #echo ntsc > /sys/devices/platform/omapdss/display1/timings
> > 3. Enabled TV
> >  # echo 1 > /sys/devices/platform/omapdss/display1/enable
> > and did the common fb test....
> > But it did not seem to work.
> > Its nice if someone has different working approach or can suggest me where I am going wrong in the above steps.
> >
> > Regards,
> > Subbu
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> 

