From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: linux omap on sdp broken?
Date: Mon, 21 Sep 2009 13:34:23 -0500
Message-ID: <A24693684029E5489D1D202277BE89444C6864D0@dlee02.ent.ti.com>
References: <782515bb0909181942v58ea0e95n8025eb47876116bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41979 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbZIUSeX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 14:34:23 -0400
In-Reply-To: <782515bb0909181942v58ea0e95n8025eb47876116bf@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>, linux-omap <linux-omap@vger.kernel.org>


From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
owner@vger.kernel.org] On Behalf Of Nishanth Menon
Sent: Friday, September 18, 2009 9:42 PM
> 
> Hi Folks,
> Has Anyone tried booting latest kernel from tmlind master tree recently?
> Ref: git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-
> 2.6.git
> 
> Starting kernel ...
> Uncompressing
> Linux.....................................................................
> ..........................................................................
> ..................
> done, booting the kernel.
> 
> Gets stuck there..
> Tried with
> arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2009q1-203) 4.3.3
> Copyright (C) 2008 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
> 
> Also tried 2008q3 with no luck.

And how about trying with DEBUG_LL and sending the logs?

Regards,
Sergio
> 
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

