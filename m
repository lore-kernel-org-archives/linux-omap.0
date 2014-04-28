From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] mfd: twl4030-power: Add recommended idle
 configuration
Date: Mon, 28 Apr 2014 16:42:17 +0100
Message-ID: <20140428154217.GB24959@lee--X1>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-2-git-send-email-tony@atomide.com>
 <20140428114133.GV21279@lee--X1>
 <20140428153346.GI20807@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:61573 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbaD1PmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 11:42:24 -0400
Received: by mail-wg0-f48.google.com with SMTP id b13so508069wgh.31
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 08:42:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140428153346.GI20807@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, 28 Apr 2014, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [140428 04:42]:
> > > These settings are based on the "Recommended Sleep Sequences for
> > > the Zoom Platform" pdf at:
> > >=20
> > > http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.p=
df
> > >=20
> > > These settings assume most of the regulators are under control of
> > > Linux, and cuts off VDD1 and VDD2 during off-idle as Linux cannot
> > > do it.
> >=20
> > Linux does it becuase Linux can't do it. Eh?
>=20
> Heh yeah that's confusing, will update to:
>=20
> These settings assume most of the regulators are under control of
> Linux, and twl4030 only cuts off VDD1 and VDD2 during off-idle as
> Linux cannot do it.

+1, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
