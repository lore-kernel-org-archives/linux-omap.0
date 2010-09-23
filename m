From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Thu, 23 Sep 2010 14:38:55 +0300
Message-ID: <20100923113855.GK4580@legolas.emea.dhcp.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D9E5@dbde02.ent.ti.com>
 <20100923085138.GG4580@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DBA4@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab0IWLjF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 07:39:05 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863DBA4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Thu, Sep 23, 2010 at 06:11:22AM -0500, Kalliguddi, Hema wrote:
>When there is global suspend initiated, driver's pm_ops functions
>Musb_suspend api is called and the clocks are disabled.
>Now when the system resumes after wakeup,
>Musb_resume_noirq is called, now need to re-enable the clocks so calling
>pm_runtime_get_sync function.
>
>Do you see wny problem with it?

ok, now I get it. It's just that platform_suspend/resume() are actually
only used on platform_init/exit() :-p

After we apply this, I'll queue patches to fix up that goofy method
name.

-- 
balbi
