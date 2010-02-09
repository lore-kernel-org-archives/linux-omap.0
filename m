From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3evm: Doesn't boot at 4fa42e46
Date: Tue, 9 Feb 2010 21:33:53 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E263A697@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E263A671@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46766 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411Ab0BIQD6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 11:03:58 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o19G3t7t014439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 9 Feb 2010 10:03:57 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o19G3s20005844
	for <linux-omap@vger.kernel.org>; Tue, 9 Feb 2010 21:33:54 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E263A671@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Tuesday, February 09, 2010 9:02 PM
> To: linux-omap@vger.kernel.org
> Subject: omap3evm: Doesn't boot at 4fa42e46
> 
> Hi all,
> 
> Just updated my repo to the commit:
> 
> commit 4fa42e4679324b0e3c54fb509535eea3923ccb63
> Merge: e599f12 c446167
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Thu Feb 4 20:07:44 2010 -0800
> 
> The kernel builds fine; but doesn't boot on the OMAP3EVM.
> 
> I have been able to trace the code until rest_init(); but 
> will need to restart debugging.
> There seems to be an exception during execution.
> 
> Will continue to dig further. This is just an FYI.
> 

The kernel panics during I2C init in function omap3_evm_i2c_init()
during this call:

    omap_register_i2c_bus(2, 400, NULL, 0);

I see that there isn't any difference between omap3_evm_i2c_init()
and omap3430_i2c_init(). Has anyone tried the booting 3430SDP at
this commit?

...just trying to understand if this is a board specific issue
OR is it a generic OMAP3 issue before I try bisect.

~sanjeev

> Best regards,
> Sanjeev
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 