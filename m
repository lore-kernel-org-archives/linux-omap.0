From: "Gross, Andy" <andy.gross@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 7 Mar 2012 09:59:37 -0600
Message-ID: <CABT81PiS1b7=4r_S8op9FUoWp+H2xgWYDLpuj1PfD8Ag7r_6Hw@mail.gmail.com>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	<1331040371.2059.113.camel@deskari>
	<CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
	<1331044544.2059.150.camel@deskari>
	<CABT81PhtXsuy_XL0i+4TV=BScYV9-0nfzys5Gi_-=iiSso0bSQ@mail.gmail.com>
	<1331121928.4348.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:53810 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758073Ab2CGP7k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Mar 2012 10:59:40 -0500
Received: by lahl5 with SMTP id l5so17588040lah.1
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 07:59:37 -0800 (PST)
In-Reply-To: <1331121928.4348.28.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Clark <rob.clark@linaro.org>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>

On Wed, Mar 7, 2012 at 6:05 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
>
> Does this "DMM has become synonymous" mean that people just started
> calling TILER DMM, and thus the name has stuck, or are there technica=
l
> reasons to handle it as DMM in the kernel? If the former, and if TILE=
R
> is the technically exact name for it, perhaps it would make sense to
> call it TILER, as that's what (at least I) would be looking for if I
> read the TRM and try to find the code for the TILER.
>
> =A0Tomi

Well the breakdown of the DMM/Tiler kind of goes like this.  The DMM
defines a set of registers used to manipulate the PAT table that backs
the address space with physical memory.  The Tiler portion of the DMM
really just describes the address space that is exposed.  Depending on
what address range you access, you'll get a different mode of access
and rotation.  Management of the address space is attributed to the
Tiler as well and that is where we have managed the address space and
provided APIs to reserve address space and pin/unpin memory to those
regions.

=46rom a hardware perspective, we need access to the resources provided
by the DMM so that we can do the PAT programming and that can only be
gotten from the hwmod entry.  And if you use the hwmod device entry,
you have to match the name used for that entry.

Regards,

Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
