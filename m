From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Omap3430 does not resume after suspend
Date: Fri, 30 Jan 2009 19:32:43 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301C7069769@dbde02.ent.ti.com>
References: <d105d8d00901300124i60025abete9f0b0e86d676f82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53089 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZA3ODD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 09:03:03 -0500
In-Reply-To: <d105d8d00901300124i60025abete9f0b0e86d676f82@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shreyas Mahajan <mahajan.shreyas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Shreyas Mahajan
> Sent: Friday, January 30, 2009 2:54 PM
> To: linux-omap@vger.kernel.org
> Subject: Omap3430 does not resume after suspend
> 
> Hello,
>          I am a newbie with omap3430. As a part of my 
> project, I suspended my board with 'echo mem > 
> /sys/power/state'.The suspend happens correctly, without 
> giving any failure message. But, when I tried it to resume, 
> it is not resuming.I tried to find some reasons for this, and 
> got the patches for unmasking keyboard interrupt while 
> suspending. But, all patches are for omap2 and omap1 board 
> architecture.
[sp] Are you following updates in Kevin Hilman's pm branch?
With lastest updates you shouldn't see this problem on a minimal config.

Would be good to start from here and add drivers selectively.

> Are there any patches to do this thing in omap3430?

[sp] omap2 applies to OMAP3430 as well.

> 
> Thanks,
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 