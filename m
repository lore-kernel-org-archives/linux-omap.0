From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: OMAP video compile error; regression from 2.6.33-rc4 onward
 (including current master)
Date: Mon, 07 Jun 2010 10:39:01 +0300
Message-ID: <1275896341.2549.11.camel@tubuntu.research.nokia.com>
References: <201006061652.39248.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201006061652.39248.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Luke-Jr <luke@dashjr.org>
Cc: "slapin@ossfans.org" <slapin@ossfans.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 2010-06-06 at 23:52 +0200, ext Luke-Jr wrote:
> This doesn't even build, so I don't know how it was tested... Reverting the 
> offending commit (simple, but does require conflict resolution) at least lets 
> it compile, but I haven't tested whether it alone is enough to work in 
> practise yet... hoping Tomi might provide a real fix. Maybe even in time for 
> 2.6.35 final? :)
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=16144
> 
> CC      drivers/video/omap/rfbi.o                                               
> drivers/video/omap/rfbi.c: In function 'rfbi_get_clocks':                       
> drivers/video/omap/rfbi.c:86: error: 'dispc' undeclared (first use in this
> function)
> drivers/video/omap/rfbi.c:86: error: (Each undeclared identifier is reported
> only once
> drivers/video/omap/rfbi.c:86: error: for each function it appears in.)          
> make[1]: *** [drivers/video/omap/rfbi.o] Error 1                                
> make: *** [drivers/video/omap/rfbi.o] Error 2                                   
> 
> The 'dispc' referred to herein is and has always been defined in
> drivers/video/omap/dispc.c as an anonymous struct.

Hmm yes, looks rather broken. I don't know how that has gotten through
=). Reverting the patch makes it compile, but RFBI won't work.

 Tomi
