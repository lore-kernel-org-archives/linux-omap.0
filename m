From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: OMAP build failure after this merge window - caused by usb
 or phy Kconfig krap
Date: Mon, 25 Nov 2013 18:50:38 +0100
Message-ID: <52938DEE.4030905@broadcom.com>
References: <20131125140927.GP16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:3845 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756712Ab3KYRuv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 12:50:51 -0500
In-Reply-To: <20131125140927.GP16735@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 11/25/2013 03:09 PM, Russell King - ARM Linux wrote:
> which just illustrates why "select" in Kconfig is soo fscking bad that
> it shouldn't be used.

The problem is that instinctively people assume that select is the 
opposite from depends. Unfortunately, it is not and it is a pitfall for 
many.

Gr. AvS

