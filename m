From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v2 01/17] OMAP2420: hwmod data: add DSS DISPC RFBI VENC
Date: Mon, 6 Dec 2010 13:14:21 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F0A55B6@dbde02.ent.ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
 <1291031503-21036-2-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52409 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744Ab0LFHoe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 02:44:34 -0500
In-Reply-To: <1291031503-21036-2-git-send-email-svadivu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

> -----Original Message-----
> From: Guruswamy, Senthilvadivu
> Sent: Monday, November 29, 2010 5:21 PM
> To: khilman@deeprootsystems.com; tomi.valkeinen@nokia.com; paul@pwsan.com;
> Hiremath, Vaibhav; linux-omap@vger.kernel.org
> Cc: Guruswamy, Senthilvadivu
> Subject: [PATCH v2 01/17] OMAP2420: hwmod data: add DSS DISPC RFBI VENC
> 
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Database generated for OMAP2420 Display Sub System.
> Since dss is also considered as an IP as dispc,rfbi,
> name it as dss_dss.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> ---
The first 4 patches are reviewed by Acked by Benoit.
These patches are also tested on 2420-N800, 2430SDP, 3430SDP as mentioned in cover letter.

Could you please let me know what is needed further to push this changes to l-o.

Regards,
Senthil

>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  283
> ++++++++++++++++++++++++++++

