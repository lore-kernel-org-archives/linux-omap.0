From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 2/2] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 19:43:16 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08805E777E5@dbde01.ent.ti.com>
References: <1209044786-9244-1-git-send-email-felipe.balbi@nokia.com> <1209044786-9244-2-git-send-email-felipe.balbi@nokia.com> <1209044786-9244-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008AbYDXORr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 10:17:47 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1209044786-9244-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, "Syed Mohammed, Khasim" <khasim@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Thursday, April 24, 2008 7:16 PM
> To: linux-omap@vger.kernel.org; David Brownell
> Cc: Tony Lindgren; Syed Mohammed, Khasim; Felipe Balbi
> Subject: [PATCH 2/2] USB: Generalize usb initialization for omap hw
> 
> Create a generic board-file for initializing usb
> on omap2430 and omap3 boards.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/Makefile                       |    4 +-
>  arch/arm/mach-omap2/board-2430sdp-usb.c            |   96 
> --------------------
>  arch/arm/mach-omap2/board-2430sdp.c                |    3 +-
>  arch/arm/mach-omap2/board-3430sdp.c                |    3 +-
>  .../mach-omap2/{board-3430sdp-usb.c => usb-musb.c} |   32 ++++---
>  include/asm-arm/arch-omap/usb-musb.h               |   35 +++++++

usb-musb.{c,h}? EHCI/OHCI has nothing to do with mentor.

>  6 files changed, 61 insertions(+), 112 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/board-2430sdp-usb.c
>  rename arch/arm/mach-omap2/{board-3430sdp-usb.c => usb-musb.c} (91%)
>  create mode 100644 include/asm-arm/arch-omap/usb-musb.h
> 
