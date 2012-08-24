From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: omap_hwmod: Fix up resource names when booted with
 devicetree
Date: Fri, 24 Aug 2012 19:20:30 +0300
Message-ID: <5037A9CE.1080809@ti.com>
References: <1345730049-12675-1-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1208241536290.25436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:40656 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759797Ab2HXQUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 12:20:31 -0400
Received: by obhx4 with SMTP id x4so5290480obh.0
        for <linux-omap@vger.kernel.org>; Fri, 24 Aug 2012 09:20:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208241536290.25436@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 08/24/2012 06:38 PM, Paul Walmsley wrote:
> Do we need both this one and your '[PATCH] driver core: Check if r->n=
ame=20
> is valid in platform_get_resource_byname()' ?  Or would that second p=
atch=20
> be enough?  Is the crash happening in the platform_get_resource_bynam=
e()=20
> iterator?

The crash happens in platform_get_resource_byname(). What I see as a pr=
oblem
that when we boot without DT the r->name is configured for the hwmods. =
If we
boot with DT we discard the resources created by the OF (which also hav=
e the
r->name configured). We replace the resources from hwmods but we do not=
 fix up
the resource names (which is done in other cases).
I have sent the patch for the drivers core as well since I think it is =
a good
practice anyway to check for NULL pointer before strcmp().

Either is good, but IMHO we should fix this in omap_hwmod (at least).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
