From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Anyone using an ISP1505?
Date: Mon, 21 Dec 2009 13:47:55 -0600
Message-ID: <4B2FD0EB.7030005@billgatliff.com>
References: <4B2A7FFB.6090909@billgatliff.com> <5A47E75E594F054BAF48C5E4FC4B92AB031DC20A68@dbde02.ent.ti.com> <4B2BD3B6.20407@billgatliff.com> <FCCFB4CDC6E5564B9182F639FC35608702FFDF312B@dbde02.ent.ti.com> <4B2FAB22.90000@billgatliff.com> <FCCFB4CDC6E5564B9182F639FC35608703001E1949@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:47596 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbZLUTrg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 14:47:36 -0500
Received: by ywh12 with SMTP id 12so5986718ywh.21
        for <linux-omap@vger.kernel.org>; Mon, 21 Dec 2009 11:47:35 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703001E1949@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

Pandita, Vikram wrote:
> Bill
>  There is a basic confusion whether you are using MUSB OTG core of omap 
> Or are you using EHCI core of omap.
>
> Both can be connected to a ULPI PHY and so you need to be very precise?
>   

I'm on the CUS package, and the D0 pin of the PHY is tied to pad T24 of
the OMAP3530.  That's the ULPI D0 for EHCI, right?

If the pad can be multiplexed between both MUSB and EHCI, how can I tell
which one is connected there now?  For that matter, where in the
mountains of OMAP3xxx documentation does it say which controller the UH0
pins are tied to?  I haven't found it yet...


Thanks!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

