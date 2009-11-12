From: Daniel Toussaint <daniel@dmhome.net>
Subject: Re: [PATCH 3/4] Add support for DEVKIT8000 LCD
Date: Fri, 13 Nov 2009 00:28:33 +0800
Message-ID: <4AFC37B1.7060801@dmhome.net>
References: <838d5a2d54d0668ad72fffee7196d595@djdvant.com>	 <1258026396.20378.106.camel@tubuntu.research.nokia.com>
Reply-To: daniel@dmhome.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:36965 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbZKLQ2p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 11:28:45 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so2430876fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 08:28:50 -0800 (PST)
In-Reply-To: <1258026396.20378.106.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



On Thu, Nov 12, 2009 at 7:46 PM, Tomi Valkeinen 
<tomi.valkeinen@nokia.com <mailto:tomi.valkeinen@nokia.com>> wrote:

    On Thu, 2009-11-12 at 11:23 +0100, ext Kim Botherway wrote:
     > This patch add support for the Timll DEVKIT8000 LCD panel

    I don't handle old omapfb patches. I think you should contact Imre Deak
    for those, although my advise would be to use the new display subsystem
    driver.


Question more or less related to this thread : when submitting new 
boards, it is better to work with DSS2 directly right ? I am also 
preparing a new board patch at this point, so I would like to know what 
is the sanest way to work ? Patch the linux-omap-2.6 tree with DSS2 
patches , and then diff from there ? Or is is wiser to first submit 
without display related items, and wait for linux-omap-2.6 tree to have 
DSS2 support - which is going to happen soon I guess. 

Thanks


 

     Tomi


    --
    To unsubscribe from this list: send the line "unsubscribe linux-omap" in
    the body of a message to majordomo@vger.kernel.org
    <mailto:majordomo@vger.kernel.org>
    More majordomo info at  http://vger.kernel.org/majordomo-info.html



