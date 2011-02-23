From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP2/3/4: DSS2: Enable Display SubSystem as modules
Date: Wed, 23 Feb 2011 15:33:26 +0200
Message-ID: <1298468006.18466.37.camel@deskari>
References: <1298463753-24880-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50439 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab1BWNdk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 08:33:40 -0500
In-Reply-To: <1298463753-24880-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nilofer, Samreen" <samreen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Mundt <lethal@linux-sh.org>

Hi,

On Wed, 2011-02-23 at 06:22 -0600, Nilofer, Samreen wrote:
> Enabling Display options to be built as modules
> Also, the generic dpi, sharp & nec panels are also
> enabled as modules.

I've just posted a patch which fixes the problem with the regulators in
DSS. With that patch we can safely enable all DSS interfaces (and thus
panels) and the resulting binary will work on all boards.

So can you make one more version which enables all the interfaces and
panels as modules, based on
git://gitorious.org/linux-omap-dss2/linux.git master

 Tomi


