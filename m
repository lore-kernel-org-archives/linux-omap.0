From: Tim Nordell <tim.nordell@logicpd.com>
Subject: Re: DM3730 + MUSB host mode + DMA + USB Ethernet dongle = Fail
Date: Thu, 07 May 2015 17:12:33 -0500
Message-ID: <554BE351.7070908@logicpd.com>
References: <554AA11B.9040909@logicpd.com>	<20150507160606.GB15563@atomide.com>	<20150507161656.GB29183@saruman.tx.rr.com>	<554BAC48.2050406@logicpd.com>	<CAPM0aKVSJfyBj-FzdTDC+PFmHOmch39F26OF_0CzK5a704AVpA@mail.gmail.com> <CADYTM3YGgm9b+vpxH8jJk41Cc9no=-pPydfHQsvR1FehbRCTxw@mail.gmail.com> <554BD878.7090907@logicpd.com> <554BDC0D.7010401@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58948 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbbEGWM6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2015 18:12:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1YqU2J-0004Um-My
	for linux-omap@vger.kernel.org; Fri, 08 May 2015 00:12:55 +0200
Received: from 66-162-60-14.static.twtelecom.net ([66.162.60.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2015 00:12:55 +0200
Received: from tim.nordell by 66-162-60-14.static.twtelecom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2015 00:12:55 +0200
In-Reply-To: <554BDC0D.7010401@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org

On 05/07/15 16:41, Tim Nordell wrote:
> I'm going to try another test which limits the TX or RX activity to PIO
> mode only just to see what happens if I avoid the trigger listed in that
> specific errata (despite the workaround for the errata being present).

The system survives this.  I'm not sure if it's just because of 
different usages of the system, or if because there is still an issue 
with TX/RX DMA at the same time despite the advisory for the hardware 
still being followed.

- Tim

