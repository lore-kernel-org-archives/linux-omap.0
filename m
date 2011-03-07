From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB issues with 2.6.38-rc7?
Date: Mon, 7 Mar 2011 09:37:50 +0200
Message-ID: <20110307073750.GB2522@legolas.emea.dhcp.ti.com>
References: <AANLkTi=icn1QeM7pTZhVNLAcsHaJO-eyp-EHm5QWVvOf@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:54233 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752252Ab1CGHhy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 02:37:54 -0500
Received: by mail-fx0-f42.google.com with SMTP id 20so6489226fxm.1
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 23:37:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=icn1QeM7pTZhVNLAcsHaJO-eyp-EHm5QWVvOf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

On Sun, Mar 06, 2011 at 08:58:47PM -0800, Steve Sakoman wrote:
> I began working with mainline 2.6.38-rc7 on Overo this past week in an
> attempt to get a few patches submitted in time for the 2.6.39 merge
> window.
> 
> One thing I've noticed is that neither musb nor ehci USB support are
> working for me.  I'm using the same config options as I did for
> 2.6.37.
> 
> Have there been changes made to the USB subsystem that require board
> file or config changes?  A search of this list hasn't turned up any
> likely candidates, but it wouldn't be the first time my search skills
> failed me!

Many changes on MUSB at least. EHCI/OHCI changes are going into merge
window. Do you have your .config available so I can check if there's
anything obvious ?

Does the driver probe at least ? What does 'dmesg | grep -i usb' return
?

-- 
balbi
