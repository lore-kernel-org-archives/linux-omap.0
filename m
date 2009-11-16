From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Dose OMAP3 support split transfer?
Date: Mon, 16 Nov 2009 14:55:25 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043702B3DB@dbde02.ent.ti.com>
References: <c27069990911151802s4f7e8da4k83dfa9bce6219cd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54298 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbZKPJZZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 04:25:25 -0500
In-Reply-To: <c27069990911151802s4f7e8da4k83dfa9bce6219cd5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jung songtan <jungsongtan@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of jung songtan
> Sent: Monday, November 16, 2009 7:32 AM
> To: linux-omap@vger.kernel.org
> Subject: Dose OMAP3 support split transfer?
> 
> Hi Guys,
> 
> Dose OMAP3 support split transaction?

Yes, it supports.

OMAP3 has one USB2.0 OTG port and three HSUSB host only ports which can
Act as a high speed host(using EHCI) or full/low speed port(using OHCI). 

You can connect any FS/LS or HS devices to OTG port directly and it will 
work. While you can connect only HS devices to ports using EHCI and
FS/LS devices to ports using OHCI.

FS/LS devices can be connected to EHCI via a high speed hub with a TT. 

-Ajay
> 
> Thanks,
> --
> K T Jung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

