From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: Re: MMC not working on 3430SDP
Date: Tue, 3 Feb 2009 16:51:53 +0530
Message-ID: <00a301c985f1$9e5bf910$LocalHost@wipultra796>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A3D45333@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37683 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbZBCLWF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Feb 2009 06:22:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, Tony Lindgren <tony@atomide.com>, dbrownell@users.sourceforge.net
Cc: linux-omap@vger.kernel.org

Hi ,

On 3430 SDP , the MMC card insertion and removal is not working on the 
linux -omap tree !
It seems like interrupts are  not getting  triggered on Card insertion & 
removal !

I wonder if it has to do something with GPIO library  !
Also whether the GPIO library takes care of the requests to TWL4030 ?

Thanks & Regards,
Kishore

----- Original Message ----- 
From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
To: "Tony Lindgren" <tony@atomide.com>
Cc: <linux-omap@vger.kernel.org>
Sent: Tuesday, February 03, 2009 1:01 AM
Subject: OMAP: MMC not working on 3430SDP


> Hi,
>  When using the latest Linux Omap code base, MMC functionality is broken. 
> MMC card insertion is not giving interrupts. Also at proc/interrupts, 
> where mmc interrupt should have been, the entry says:
> "Err:          0"
>
> --
> With Regards,
> Jagadeesh Bhaskar P
>
> ----------------------------
> Some men see things as they are and say why - I dream things that never 
> were and say why not.
> - George Bernard Shaw
> ----------------------------
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> 

