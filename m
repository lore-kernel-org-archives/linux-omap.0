From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Diagnosing issues with OMAPDSS scaling of overlay 0
Date: Mon, 11 Apr 2011 13:37:59 +0300
Message-ID: <1302518279.2198.65.camel@deskari>
References: <f49bfabe-ecf0-4e9e-89d5-1a6a5c00b4b3@zimbra.xlogic.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47224 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755097Ab1DKKiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 06:38:04 -0400
Received: by mail-fx0-f45.google.com with SMTP id 2so4646372fxm.18
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 03:38:03 -0700 (PDT)
In-Reply-To: <f49bfabe-ecf0-4e9e-89d5-1a6a5c00b4b3@zimbra.xlogic.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz =?UTF-8?Q?M=C5=82oduchowski?= <tomasz.mloduchowski@xlogic.pl>
Cc: linux-omap@vger.kernel.org

On Mon, 2011-04-11 at 12:08 +0200, Tomasz M=C5=82oduchowski wrote:
> >> Is there a way to diagnose why the omapdss fails to scale ovl 0?
> > No need to diagnose, graphics overlay (overlay 0) cannot be scaled =
=3D).
> Thanks so much!=20
>=20
> Now that you pointed me in the right direction - the only place this
> limitation is actually mentioned is the TRM document (and the driver
> seems quite content to export unsupported functionality to the sysfs)

True. I've long had plan to add the sysfs files only if the feature is
actually supported.

> Perhaps next time someone stumbles over my naive question and finds
> this thread. If I find the time this week, I'll try adding something
> to the documentation.

I've mostly tried to keep the documentation only discuss about the
software side. The TRM is public and should be used to understand the
hardware.

But you are right that normal user shouldn't need to read the TRM if he
just wants to use scaling =3D). So either the sysfs/ioctl interfaces
should force the user to use things correctly, or he should get clear
warnings/errors when he uses things incorrectly, or the documentation
should say these things.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
