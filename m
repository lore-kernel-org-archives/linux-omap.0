From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 1/2] OMAP: DSS2: Add support for LG Philips LB035Q02
 panel
Date: Sat, 5 Mar 2011 11:18:02 +0200
Message-ID: <1299316682.2311.0.camel@deskari>
References: <1299271940-4286-1-git-send-email-steve@sakoman.com>
	 <1299271940-4286-2-git-send-email-steve@sakoman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47942 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab1CEJSH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Mar 2011 04:18:07 -0500
In-Reply-To: <1299271940-4286-2-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <steve@sakoman.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, 2011-03-04 at 14:52 -0600, Steve Sakoman wrote:
> This patch adds support for the Gumstix Palo35 expansion board
> which utilizes the 320 x 240 pixel LG.Philips LB035Q02 LCD Panel
> 
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  drivers/video/omap2/displays/Kconfig               |    6 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  .../omap2/displays/panel-lgphilips-lb035q02.c      |  278 ++++++++++++++++++++
>  3 files changed, 285 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-lgphilips-lb035q02.c

This doesn't compile.

 Tomi


