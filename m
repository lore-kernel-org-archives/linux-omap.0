From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3: pm: AVS enabled by default?
Date: Thu, 28 Jan 2010 20:51:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E22B429F@dbde02.ent.ti.com>
References: <0C997DD87CC88A4F86C897F52650B52B02807807@MOLSON.mpc-data.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35307 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529Ab0A1PVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 10:21:40 -0500
In-Reply-To: <0C997DD87CC88A4F86C897F52650B52B02807807@MOLSON.mpc-data.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Murray <amurray@mpc-data.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Andrew Murray
> Sent: Thursday, January 28, 2010 7:53 PM
> To: linux-omap@vger.kernel.org
> Subject: omap3: pm: AVS enabled by default?
> 
> Hello,
> 
> I noticed that Smart Reflex AVS is not turned on by default - and must
> be manually enabled from user-land through the sr_vddX_autocomp
> controls.
> 
> Are there any plans to enable this by default, or perhaps via 
> a KConfig
> option in the future?
> 
> I ask because the longer a boot time, the longer the device is running
> without AVS (assuming it's not enabled by a boot loader) - and on a
> mobile device with frequent power on/offs this duration could add up
> leading to a potential missed power saving? I appreciate the 
> saving may
> be small - but would it be worthwhile?

Andrew,

Some of the initial silicon revisions did not have the efuse data to
Required for AVS. I believe AVS is disabled - by default - to ensure
compatibility with these devices.

Best regards,
Sanjeev

> 
> Thanks,
> 
> Andrew Murray
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 