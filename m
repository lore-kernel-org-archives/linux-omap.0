From: "Nilofer, Samreen" <samreen@ti.com>
Subject: RE: [PATCH] OMAP2/3/4: DSS2: Enable Display SubSystem as modules
Date: Thu, 24 Feb 2011 09:52:28 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370563B3A@dbde02.ent.ti.com>
References: <1298463753-24880-1-git-send-email-samreen@ti.com>
 <1298468006.18466.37.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52572 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932383Ab1BXEWo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 23:22:44 -0500
In-Reply-To: <1298468006.18466.37.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Mundt <lethal@linux-sh.org>

Hi,
Valkeinen, Tomi wrote:
> Hi,
> 
> On Wed, 2011-02-23 at 06:22 -0600, Nilofer, Samreen wrote:
>> Enabling Display options to be built as modules Also, the generic dpi,
>> sharp & nec panels are also enabled as modules.
> 
> I've just posted a patch which fixes the problem with the
> regulators in DSS. With that patch we can safely enable all DSS interfaces
> (and thus panels) and the resulting binary will work on all boards.
> 
> So can you make one more version which enables all the
> interfaces and panels as modules, based on
> git://gitorious.org/linux-omap-dss2/linux.git master
> 
[samreen]
Sure. Will post out the next version soon.
>  Tomi