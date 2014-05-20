From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/3] OMAPDSS: DT support for panel-lgphilips-lb035q02
Date: Tue, 20 May 2014 13:04:02 +0200
Message-ID: <537B36A2.1080107@epfl.ch>
References: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:42491 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbaETLEI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 07:04:08 -0400
In-Reply-To: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>

Hi Tomi,

On 05/15/2014 12:10 PM, Tomi Valkeinen wrote:
> Hi,
> 
> This adds DT support to panel-lgphilips-lb035q02. Compile tested only.
> 
> This panel is used on some Overo boards (alto35, if I'm not mistaken).
> 

I tested with the Alto35. Using the small fix for patch 2, I was able to
use the panel. I will post the related DTS changes soon.

Tested-by: Florian Vaussard <florian.vaussard@epfl.ch>

>  Tomi
> 
> Tomi Valkeinen (3):
>   OMAPDSS: panel-lgphilips-lb035q02: use gpiod for enable gpio
>   OMAPDSS: panel-lgphilips-lb035q02: Add DT support
>   Doc/DT: Add binding doc for lgphilips,lb035q02.txt
> 
>  .../bindings/video/lgphilips,lb035q02.txt          | 33 ++++++++++
>  .../omap2/displays-new/panel-lgphilips-lb035q02.c  | 76 +++++++++++++++++-----
>  2 files changed, 94 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt
> 
