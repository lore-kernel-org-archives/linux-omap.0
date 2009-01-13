From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [REVIEW PATCH 10/14] OMAP: CAM: Add ISP gain tables
Date: Tue, 13 Jan 2009 19:06:20 -0200
Message-ID: <20090113190620.3927e6ef@pedra.chehab.org>
References: <A24693684029E5489D1D202277BE894416429FA0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:39810 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbZAMVGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 16:06:55 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894416429FA0@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>

On Mon, 12 Jan 2009 20:03:30 -0600
"Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com> wrote:

> This adds the OMAP ISP gain tables. Includes:
> * Blue Gamma gain table
> * CFA gain table
> * Green Gamma gain table
> * Luma Enhancement gain table
> * Noise filter gain table
> * Red Gamma gain table
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  drivers/media/video/isp/bluegamma_table.h    | 1040 ++++++++++++++++++++++++++
>  drivers/media/video/isp/cfa_coef_table.h     |  592 +++++++++++++++
>  drivers/media/video/isp/greengamma_table.h   | 1040 ++++++++++++++++++++++++++
>  drivers/media/video/isp/luma_enhance_table.h |  144 ++++
>  drivers/media/video/isp/noise_filter_table.h |   79 ++
>  drivers/media/video/isp/redgamma_table.h     | 1040 ++++++++++++++++++++++++++
>  6 files changed, 3935 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/isp/bluegamma_table.h
>  create mode 100644 drivers/media/video/isp/cfa_coef_table.h
>  create mode 100644 drivers/media/video/isp/greengamma_table.h
>  create mode 100644 drivers/media/video/isp/luma_enhance_table.h
>  create mode 100644 drivers/media/video/isp/noise_filter_table.h
>  create mode 100644 drivers/media/video/isp/redgamma_table.h

Hmm... patch 06/14 needs this one to compile... This patch should have been added before 06/14...

Also, this is just a series of magic numbers. Could you please put a generic
comment about the meaning of those numbers, better specifying what those tables
are meant to and how are they handled? 

Also, instead of just having a magic sequence of numbers, is better to have the
struct definition there, and put it into a nicer format.

So, instead of:

/*
 * CFA Filter Coefficient Table
 *
 */
static u32 cfa_coef_table[] = {
#include "cfa_coef_table.h"
};

You should do something like:

/*
 * Color Filter Array (CFA) Coefficient Table
 *
 * This table specifies coefficients for a filter that ...
 *
 */
static u32 cfa_coef_table[] = {
	0,   247,   0, 244, 247,  36,  27,  12,
	0,    27,   0, 250, 244,  12, 250,   4,

	...

};

Cheers,
Mauro
