From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Thu, 21 Oct 2010 08:57:10 -0700
Message-ID: <20101021155710.GB3616@atomide.com>
References: <4CBD9FD5.506@nokia.com>
 <AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>
 <4CBE9E69.6060803@nokia.com>
 <AANLkTinOYDBMVZ3ibG3Md7jdOuOC6NkGWaugvHwT6uqF@mail.gmail.com>
 <4CBEB312.7060400@nokia.com>
 <AANLkTikom=eRFqCJmYE+k1zn5K2MR9s8HhNXtjOvUqvr@mail.gmail.com>
 <4CBEE186.8090701@nokia.com>
 <AANLkTinULxyUg_vHjk9RsQm4Row7vRC9ApzYXt7ZMQJD@mail.gmail.com>
 <4CC0493F.1000701@nokia.com>
 <20101021154125.GR3958@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101021154125.GR3958@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Roger Quadros <roger.quadros@nokia.com>, ext Felipe Contreras <felipe.contreras@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, David Brownell <dbrownell@users.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [101021 08:32]:
> Hi,
> 
> On Thu, Oct 21, 2010 at 09:07:59AM -0500, Roger Quadros wrote:
> >But I'm not sure that omap_udc is used only for OMAP1 architecture.
> >Dave/Tony should confirm this.
> 
> Maybe the old omap2420_h4 board still uses it, but from 2430 I think the
> ip isn't even there anymore.

I don't think it's currently working on 2420. But still, the drivers
should be platform independent. All the drivers that might be possible
should at least build and not mess up things for other platforms.

Regards,

Tony
