From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Fri, 26 Nov 2010 15:00:08 -0600
Message-ID: <20101126210008.GA27223@lixom.net>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com> <1290526740-27624-2-git-send-email-ohad@wizery.com> <20101126045912.GC6598@lixom.net> <AANLkTimkovvHzgdnGtGpTH1pz8QLi9K0-rcWVHCdMJbu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:58970 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab0KZVAJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Nov 2010 16:00:09 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimkovvHzgdnGtGpTH1pz8QLi9K0-rcWVHCdMJbu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hari Kanigeri <h-kanigeri2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Kevin Hilman <khilman@deeprootsystems.com>, akpm@linux-foundation.org, Suman Anna <s-anna@ti.com>

On Fri, Nov 26, 2010 at 12:18:49AM -0700, Grant Likely wrote:
> On Thu, Nov 25, 2010 at 9:59 PM, Olof Johansson <olof@lixom.net> wrot=
e:
> > On Tue, Nov 23, 2010 at 05:38:57PM +0200, Ohad Ben-Cohen wrote:
> >> +#define pr_fmt(fmt) =A0 =A0"%s: " fmt, __func__
> >
> > Not used.
>=20
> pr_fmt() is a magic #define that changes the behaviour of the pr_*()
> macros.  See include/linux/kernel.h

D'oh, thanks.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
