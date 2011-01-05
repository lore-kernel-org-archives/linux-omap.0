From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Wed, 05 Jan 2011 07:37:22 -0600
Message-ID: <4D247412.5070008@ti.com>
References: <1293782878-9756-1-git-send-email-thara@ti.com> <4D21F09D.3040007@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F0E0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42519 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751257Ab1AENhe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 08:37:34 -0500
Received: by gyg4 with SMTP id 4so5938459gyg.8
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 05:37:33 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F0E0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

Gopinath, Thara wrote, on 01/05/2011 04:46 AM:
[..]
> Yes you are right. The SR I2C needs to be enabled for vp force update
> and vc bypass method of voltage scaling as well as for smartreflex
> feature. Are you telling that there are platforms out there using OMAP3
> and T2 and still using VMODE or VSEL. As far as I am aware our h/w folks themselves do not recommend these methods.

;) not every one likes to follow recommendations rt? but yeah, there are 
folks who use vmode for 3430, vsel is possible even for 3630 - using 
class2 implementation if desired or forced to if the SR lines are not 
hooked up on the board.

-- 
Regards,
Nishanth Menon
