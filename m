From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: SR1: VDD autocomp is not active
Date: Tue, 1 Dec 2009 21:38:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB1@dbde02.ent.ti.com>
References: <48239d390912010353l44f8e6d9w7ff963c7fb41ecf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34481 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbZLAQID convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 11:08:03 -0500
In-Reply-To: <48239d390912010353l44f8e6d9w7ff963c7fb41ecf3@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Sergey Lapin
> Sent: Tuesday, December 01, 2009 5:24 PM
> To: linux-omap@vger.kernel.org
> Subject: SR1: VDD autocomp is not active
> 
> Hi, all!
> 
> on my OMAP3525-based custom board I get SR1: VDD autocomp is not
> active and SR2: VDD autocomp is not active
> quite frequently with PM branch. What that means, and how to fix it?

Do you see them while trying to set the sr_vdd[1|2]_autocomp?
OR
During normal execution?

What is the silicon version reported when Linux kernel boot up?

~sanjeev

> 
> Thanks a lot,
> S.
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 