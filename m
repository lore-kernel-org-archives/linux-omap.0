From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2 0/2] OMAP3: DSS2: Pre-Multiplied Alpha support
Date: Fri, 12 Nov 2010 15:19:40 +0200
Message-ID: <1289567980.3297.275.camel@tubuntu>
References: <1288870122-22836-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:31706 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014Ab0KLNTw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Nov 2010 08:19:52 -0500
In-Reply-To: <1288870122-22836-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Samreen <samreen@ti.com>
Cc: "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, Archit Taneja <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

On Thu, 2010-11-04 at 12:28 +0100, ext Samreen wrote:
> Enable Pre multiplied alpha support on OMAP3630
> 
> The first patch splits the omap3 dss has features for omap3430
> and omap3630 separately
> The second patch adds the support for pre multiplied alpha
> 
> Version2:
>    - Split the patch into dss has feature patch and pre multiplied
>    alpha support
>    - Remove the BUG_ON in functions setting pre multiplied alpha
>    and global alpha 
>    - Uniformly use "pre_mult_alpha" naming convention

Looks good, I'll apply to my tree.

 Tomi


