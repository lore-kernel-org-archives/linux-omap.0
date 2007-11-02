From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH resend] Make the dev_*() family of macros in
	device.hcomplete
Date: Fri, 2 Nov 2007 08:35:13 -0700
Message-ID: <20071102153513.GA7485@suse.de>
References: <20071101165700.aa5167fb.akpm@linux-foundation.org> <598D5675D34BE349929AF5EDE9B03E270174CCE0@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757672AbXKBPgZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270174CCE0@az33exm24.fsl.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, hjlipp@web.de, tilman@imap.cc, gigaset307x-common@lists.sourceforge.net, kkeil@suse.de, isdn4linux@listserv.isdn4linux.de, mac@melware.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 02, 2007 at 04:59:48AM -0700, Medve Emilian-EMMEDVE1 wrote:
> Hello Andrew,
> 
> 
> Thanks for the detailed background.
> 
> By now I also submitted a patch with extra spaces. Which one would be a
> better candidate for applying in a maintainer's tree (which tree?)?
> Could you please pick up one of the versions? Should I resubmit the
> first version without extra spaces?

The second patch looks good to me, it's "safer" and I'll add it to my
queue.

thanks,

greg k-h
