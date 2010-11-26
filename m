From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Fri, 26 Nov 2010 00:18:49 -0700
Message-ID: <AANLkTimkovvHzgdnGtGpTH1pz8QLi9K0-rcWVHCdMJbu@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
 <1290526740-27624-2-git-send-email-ohad@wizery.com> <20101126045912.GC6598@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51589 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab0KZHTK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 02:19:10 -0500
In-Reply-To: <20101126045912.GC6598@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hari Kanigeri <h-kanigeri2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Kevin Hilman <khilman@deeprootsystems.com>, akpm@linux-foundation.org, Suman Anna <s-anna@ti.com>

On Thu, Nov 25, 2010 at 9:59 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Nov 23, 2010 at 05:38:57PM +0200, Ohad Ben-Cohen wrote:
>> +#define pr_fmt(fmt) =A0 =A0"%s: " fmt, __func__
>
> Not used.

pr_fmt() is a magic #define that changes the behaviour of the pr_*()
macros.  See include/linux/kernel.h

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
