From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: Platform device tester - Allow removal
Date: Tue, 13 Aug 2013 11:20:12 -0700
Message-ID: <20130813182012.GE7740@kroah.com>
References: <1376386470-27328-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1376386470-27328-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, =?iso-8859-1?Q?Beno=EEt?= Coussno <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Sourav Poddar <sourav.poddar@ti.com>, Russ Dill <Russ.Dill@ti.com>, Felipe Balbi <balbi@ti.com>, Koen Kooi <koen@circuitco.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 13, 2013 at 12:34:30PM +0300, Pantelis Antoniou wrote:
> This is a very simple device that allows testing of the removal path
> for platform devices.
> 
> The only interface is a single writeable sysfs attribute (action).

Why not use the existing "unbind/bind" sysfs files that all busses
support?  That's what userspace is expecting to use for adding and
removing devices from drivers from userspace.

This is a per-driver flag that the function platform_driver_probe() sets
for all platform drivers in the first line of that function.  Remove
that line and see what happens :)

thanks,

greg k-h
