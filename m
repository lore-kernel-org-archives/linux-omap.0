From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS fixes for 3.3-rc
Date: Tue, 28 Feb 2012 16:03:29 +0000
Message-ID: <4F4CFAD1.1000301@gmx.de>
References: <1329988974.1820.62.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:34664 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965682Ab2B1QD5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 11:03:57 -0500
In-Reply-To: <1329988974.1820.62.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-omap mailing list <linux-omap@vger.kernel.org>

On 02/23/2012 09:22 AM, Tomi Valkeinen wrote:
> Hi Florian,
> 
> Two fixes for OMAP DSS for 3.3:
> 
> First one gets the HDMI output working again. Managing the clocks for
> OMAP4 is not very simple, and this patch circumvents the problems we
> have in the clock framework. It's a clean but rather hacky fix, but it
> shouldn't cause any side-effects. The issue will hopefully be fixed
> properly with DT when we'll get proper parent-child hierarchy for DSS HW
> submodules.
> 
> The second one is a simple fix for HDMI hotplug detection, which I
> missed when I wrote the HDMI PHY fix
> (c49d005b6cc8491fad5b24f82805be2d6bcbd3dd).

Merged. You would add
Cc: stable@vger.kernel.org
to patches if appropriate?


Thanks,

Florian Tobias Schandinat

> 
>  Tomi
> 
> The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:
> 
>   Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)
> 
> are available in the git repository at:
>   git://gitorious.org/linux-omap-dss2/linux.git for-3.3-rc
> 
> Archit Taneja (1):
>       OMAPDSS: HACK: Ensure DSS clock domain gets out of idle when HDMI is enabled
> 
> Rob Clark (1):
>       OMAPDSS: HDMI: hot plug detect fix
> 
>  drivers/video/omap2/dss/hdmi.c            |   24 +++++++++++++++++++++++-
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    9 +--------
>  2 files changed, 24 insertions(+), 9 deletions(-)
> 

