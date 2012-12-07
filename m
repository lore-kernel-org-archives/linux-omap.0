From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 2/5] OMAPFB: simplify locking
Date: Fri, 7 Dec 2012 14:53:50 +0200
Message-ID: <20121207125350.GE32230@intel.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
 <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10420 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964963Ab2LGMyI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Dec 2012 07:54:08 -0500
Content-Disposition: inline
In-Reply-To: <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Dec 07, 2012 at 01:55:06PM +0200, Tomi Valkeinen wrote:
> Kernel lock verification code has lately detected possible circular
> locking in omapfb. The exact problem is unclear, but omapfb's current
> locking seems to be overly complex.
>=20
> This patch simplifies the locking in the following ways:
>=20
> - Remove explicit omapfb mem region locking. I couldn't figure out th=
e
>   need for this, as long as we take care to take omapfb lock.

I suppose the idea with that was that you wouldn't need the global
omapfb lock, and also it was an rwsem so it allowed parallel access to
the mem regions, unless the region size was being changed, in which
case it took the write lock. I can't really remember what the reason
for using an rwsem was, but I suppose there was one at the time.

I think the only correctness issue with your patch is that you're
opening up a race between omapfb_mmap and
omapfb_setup_mem/store_size.

--=20
Ville Syrj=E4l=E4
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
