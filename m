From: "Andrew Murray" <amurray@mpc-data.co.uk>
Subject: omap3: pm: AVS enabled by default?
Date: Thu, 28 Jan 2010 14:22:36 -0000
Message-ID: <0C997DD87CC88A4F86C897F52650B52B02807807@MOLSON.mpc-data.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cvs.mpc-ogw.co.uk ([81.2.99.171]:38224 "EHLO
	molson.mpc-data.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752853Ab0A1OWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 09:22:39 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I noticed that Smart Reflex AVS is not turned on by default - and must
be manually enabled from user-land through the sr_vddX_autocomp
controls.

Are there any plans to enable this by default, or perhaps via a KConfig
option in the future?

I ask because the longer a boot time, the longer the device is running
without AVS (assuming it's not enabled by a boot loader) - and on a
mobile device with frequent power on/offs this duration could add up
leading to a potential missed power saving? I appreciate the saving may
be small - but would it be worthwhile?

Thanks,

Andrew Murray

