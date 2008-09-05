From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: OMAP3EVM : Doesn't resume after suspend
Date: Fri, 5 Sep 2008 19:25:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301A039AB94@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301A03B16D8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44746 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292AbYIENzT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 09:55:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m85DtAXk008675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Sep 2008 08:55:17 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m85Dt9I3026829
	for <linux-omap@vger.kernel.org>; Fri, 5 Sep 2008 19:25:09 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301A03B16D8@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Friday, September 05, 2008 2:08 AM
> To: linux-omap@vger.kernel.org
> Subject: OMAP3EVM : Doesn't resume after suspend
> 
> Hi all,
> 
> I am building off the tag v2.6.26-omap2. While trying the 
> suspend/resume, i noticed that suspend succeeds; but the 
> resume doesn't happen.
> Did anyone else notice this behavior?
> 
> Best regards,
> Sanjeev--
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 
After some mods, I was able to get the wake-up from the keypad event.

However, these prints indicate that suspend may not have been successful:

  Freezing user space processes ... Freezing user space processes ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
done.
  Freezing remaining freezable tasks ... Freezing remaining freezable tasks ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.done.

  Suspending console(s)
  Suspending console(s)

  -- <after key press> --

  Powerdomain (mpu_pwrdm) didn't enter target state 3
  Powerdomain (neon_pwrdm) didn't enter target state 0
  Powerdomain (per_pwrdm) didn't enter target state 0
  Could not enter target state in pm_suspend
  eth0: link down
  Restarting tasks ... Restarting tasks ... done.
  done.

Best regards,
Sanjeev 
