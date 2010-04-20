From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP camera port connected to Davinci VPIF port
Date: Tue, 20 Apr 2010 13:54:40 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E137862@dbde02.ent.ti.com>
References: <4BC8BA17.5060200@mlbassoc.com> <C7EE2C14.2B621%kshen@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41215 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940Ab0DTIYp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 04:24:45 -0400
In-Reply-To: <C7EE2C14.2B621%kshen@cisco.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kshen <kshen@cisco.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of kshen
> Sent: Saturday, April 17, 2010 3:31 AM
> To: OMAP Linux discussion
> Subject: OMAP camera port connected to Davinci VPIF port
> 
> Hi,
> 
> On a board I'm working on, it has the OMAP 3530's camera port connected to
> the Davinci DM6467's VPIF port. The Davince is supposed to send BT656 stream
> over this link to OMAP. How to get the OMAP camera driver to work in this
> situation?
> 
> In kernel config, I set the CONFIG_VIDEO_OMAP3_CAM=yes option. I saw that
> omap34xxcam.c got compiled and the omap34xxcam device got probed during boot
> up. But I don't get a /dev/video0 node.
[Hiremath, Vaibhav] Atleast from description I could see you are referring to TI PSP release, since camera driver is still accepted to main-line.

In that case, the PSP release does support BT656 interface, the only difference from your set-up is, we are getting BT656 stream from Video Decoder TVP5146 and you are getting it from DM6467.

The important points to look for - 

	- Interfacing: Since OMAP supports bridge lane shifter, where you can interface your 8 bit data likes to any of 0-15 camera datalines. The release configuration fro lane shifter is 2, that means the interfacing is from 2-11.

	- OMAP35x works in slave mode, that means the synchronization is dependent on incoming pixel clock.

	- Slave driver: You have to have slave driver for your interface. Please refer to tvp514x-int.c
http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;a=blob;f=drivers/media/video/tvp514x-int.c;h=aa2048b43b9d622c61a96551a8f20a1d75bf0a88;hb=da0c86a8f3bd57fad0ccd05eb1b5e3326d7f36aa

Hope this gives you some pointers.

Thanks,
Vaibhav

> 
> Do I need to write a specific driver for the Davinci VPIF interface? What
> else do I need to do?
[Hiremath, Vaibhav] How are you making sure that DM6467 provides BT656 stream out on data pins.
> 
> Thanks,
> Ke
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
