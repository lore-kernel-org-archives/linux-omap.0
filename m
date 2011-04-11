From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Diagnosing issues with OMAPDSS scaling of overlay 0
Date: Mon, 11 Apr 2011 09:32:51 +0300
Message-ID: <1302503571.2198.0.camel@deskari>
References: <58ae76c6-267f-4f94-a97a-ffff366afff2@zimbra.xlogic.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:57511 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751917Ab1DKGc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 02:32:57 -0400
Received: by ewy9 with SMTP id 9so2240789ewy.14
        for <linux-omap@vger.kernel.org>; Sun, 10 Apr 2011 23:32:55 -0700 (PDT)
In-Reply-To: <58ae76c6-267f-4f94-a97a-ffff366afff2@zimbra.xlogic.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz =?UTF-8?Q?M=C5=82oduchowski?= <tomasz.mloduchowski@xlogic.pl>
Cc: linux-omap@vger.kernel.org

On Sat, 2011-04-09 at 17:27 +0200, Tomasz M=C5=82oduchowski wrote:
> Hi!
>=20
> Is there a way to diagnose why the omapdss fails to scale ovl 0?
>=20
> [ 2470.719604] omapdss OVERLAY: check_overlay 0: (0,0 1280x768 -> 136=
0x768) disp (1360x768)
> [ 2470.719635] omapdss MANAGER: omap_dss_mgr_apply(lcd)
> [ 2470.719665] omapdss OVERLAY: check_overlay 0: (0,0 1280x768 -> 136=
0x768) disp (1360x768)
> [ 2470.719726] omapdss MANAGER: configure_overlay(0)
> [ 2470.719757] omapdss DISPC: dispc_setup_plane 0, pa 86800000, sw 12=
80, 0,0, 1280x768 -> 1360x768, ilace 0, cmode 80, rot 0, mir 0 chan 0
> [ 2470.719787] omapdss MANAGER error: dispc_setup_plane failed for ov=
l 0
> [ 2470.726593] omapdss DISPC: dispc_enable_plane 0, 0

No need to diagnose, graphics overlay (overlay 0) cannot be scaled =3D)=
=2E

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
