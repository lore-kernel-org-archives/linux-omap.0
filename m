From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Thu, 27 Jan 2011 06:48:10 +0200
Message-ID: <20110127044810.GJ2429@legolas.emea.dhcp.ti.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com>
 <87fwsqm3b2.fsf@gmail.com>
 <87k4hu8fvx.fsf@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87k4hu8fvx.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Jan 24, 2011 at 10:45:22AM -0500, Ben Gamari wrote:
> On Tue, 18 Jan 2011 14:15:13 -0500, Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Mon,  6 Dec 2010 13:43:31 +0530, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org> wrote:
> > > As the control.h have been moved to new location and it's
> > > uses are not allowed to drivers directly so moving the phy
> > > control, interrupt clear and reset functionality to board
> > > files.
> > > 
> > What happened to the board changes for board-am3517evm?
> 
> Ping. A response would be appreciated.

sorry, quite busy at the moment, but here's one answer. Check this
commit:

commit a9c037832e9624e240c5019d0e01e9352e8f638d
Author: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Date:   Tue Dec 7 18:57:45 2010 +0530

    musb: am35x: fix compile error due to control apis
    
    commit 4814ced5116e3b73dc4f63eec84999739fc8ed11 (OMAP:
    control: move plat-omap/control.h to mach-omap2/control.h)
    moved <plat/control.h> to another location, preventing
    drivers from accessing it, so we need to pass function
    pointers from arch code to be able to talk to internal
    PHY on AM35x.
    
    Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
    Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

$ git describe a9c037832e9624e240c5019d0e01e9352e8f638d
v2.6.37-rc1-95-ga9c0378

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
