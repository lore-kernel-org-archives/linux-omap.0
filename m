From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC][PATCH 2/5] OMAP SSI driver interface
Date: Tue, 7 Oct 2008 06:56:53 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365AE0FB8@dlee02.ent.ti.com>
References: <1223034606.32631.156.camel@groo.research.nokia.com>
 <1223034750-18690-2-git-send-email-carlos.chinea@nokia.com>
 <20081006232931.GE8273@frodo> <200810061803.06731.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59616 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbYJGL5J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 07:57:09 -0400
In-Reply-To: <200810061803.06731.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: Carlos Chinea <carlos.chinea@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of David Brownell
> On Monday 06 October 2008, Felipe Balbi wrote:
> > looks much better and much easier to type: #include <linux/ssi.h>
>
> Does this work on non-OMAP kernels?  If not, <mach/ssi.h> or
> similar would seem more sensible ...

Seems like some cousin might be multi vendor via MIPI HSI. http://www.mipi.org/wgoverview.shtml


Regards,
Richard W.

