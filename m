From: Kimmo Jukarainen <kimju-omap@inside.org>
Subject: Re: DVB-T problems with MUSB
Date: Wed, 8 Oct 2008 02:10:32 +0300
Message-ID: <20081007231032.GB669@inside.org>
References: <70E3439A-A4CE-442B-928A-EEBAB253F279@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from thalassa.inside.org ([143.51.142.148]:55146 "EHLO
	thalassa.inside.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845AbYJGX2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 19:28:33 -0400
Content-Disposition: inline
In-Reply-To: <70E3439A-A4CE-442B-928A-EEBAB253F279@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Ajay Kumar Gupta <ajay.gupta@ti.com>

On Tue, Oct 07, 2008 at 09:03:42PM +0200, Koen Kooi wrote:
> Is this a problem with MUSB, omap dma or the dvb stack?

I'd say dvb stack. This small patch fixed my dvb-t stick with
a omap2 board:

http://www.linuxtv.org/pipermail/linux-dvb/2008-January/023040.html
