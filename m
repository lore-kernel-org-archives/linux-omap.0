From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Question on OTG transceivers
Date: Mon, 22 Mar 2010 11:06:32 -0500
Message-ID: <4BA79588.4040409@billgatliff.com>
References: <4BA14B06.8050202@billgatliff.com> <5A47E75E594F054BAF48C5E4FC4B92AB03220FB2A2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:58501 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab0CVQG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 12:06:26 -0400
Received: by iwn12 with SMTP id 12so4435671iwn.21
        for <linux-omap@vger.kernel.org>; Mon, 22 Mar 2010 09:06:25 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03220FB2A2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Gadiyar, Anand wrote:
>  
> Actually, the way the ehci-omap driver is currently written, it assumes
> the transceiver is present and available - you don't need a separate
> driver to access it.
>
> For that matter, the same probably holds for the OTG driver as well - you
> really don't need a driver for transparent transceivers like the SMSC332x.
>   

But I get an OOPS and the system halts when I don't have a transceiver
driver...



b.g.
