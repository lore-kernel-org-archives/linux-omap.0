From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] musb: move usb_add_hcd to the core init code from
 gadget code (v2)
Date: Mon, 10 Jan 2011 13:57:14 +0200
Message-ID: <20110110115714.GA5573@legolas.emea.dhcp.ti.com>
References: <1279895783-7313-1-git-send-email-bryan.wu@canonical.com>
 <4C600171.5020405@canonical.com>
 <4D2AF1EE.8010105@heeltoe.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D2AF1EE.8010105@heeltoe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brad Parker <brad@heeltoe.com>
Cc: bryan.wu@canonical.com, felipe.balbi@nokia.com, linux-usb@vger.kernel.org, david-b@pacbell.net, kernel-team@lists.ubuntu.com, linux-kernel@vger.kernel.org, ricardo.salveti@canonical.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Jan 10, 2011 at 06:47:58AM -0500, Brad Parker wrote:
> I know this is a top post, and a comment on a post from August, but I'd like
> to point out that without this patch I can't get musb host mode to work
> on the beagle board xm (3630).
> 
> With this patch, host mode works.  If I disconnect and reconnect the port
> goes into "a_idle", which is almost right, and will go into host mode if
> I "echo >/sys/devices/platform/musb_hdrc/mode".
> 
> (my expectation is that the mode should toggle from "b_idle" to "a_host"
> when I plug in an a connector with the id pin tied correctly, and
> back to "b_idle"
> when I disconnect)
> 
> It seems like few people people test host mode on the omap twl otg port,
> but I have applications which use it...
> 
> should this patch get more attention?  (there was no response to the
> initial post I could find)

What's the problem in simply insmoding a gadget driver ? If you have OTG
enabled, you _need_ a gadget driver to have a fully working setup. If
you want host only, then change Kconfig.

-- 
balbi
