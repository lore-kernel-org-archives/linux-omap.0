From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 1/2] OMAPDSS: DISPC: Enable predecimation
Date: Fri, 16 Mar 2012 00:28:11 +0200
Message-ID: <20120315222811.GN17132@sci.fi>
References: <1331812108-9776-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:38041 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964997Ab2COW2Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 18:28:16 -0400
Content-Disposition: inline
In-Reply-To: <1331812108-9776-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Mar 15, 2012 at 05:18:28PM +0530, Chandrabhanu Mahapatra wrote:
> In OMAP3 and OMAP4, the DISPC Scaler can downscale an image up to 4 t=
imes, and
> up to 2 times in OMAP2. However, with predecimation, the image can be=
 reduced
> to 16 times by fetching only the necessary pixels in memory. Then thi=
s
> predecimated image can be downscaled further by the DISPC scaler.

Now, where does that number 16 come from? IIRC the hardware can skip
basically any number of pixels/rows. I certainly didn't add any such
limit to the code in the harmattan kernel, and distinctly remember
being able to downscale the N9/N950 UI even down to 1 pixel size :)

> Based on the downscaling required, a prior calculation of predecimati=
on values
> for width and height of an image is done. Since, Predecimation reduce=
s quality
> of an image higher priorty is given to DISPC Scaler for downscaling.
>=20
> This code was successfully tested on OMAP2, OMAP3 and OMAP4. Horizont=
al and
> vertical predecimation worked fine except for some synclost errors du=
e to
> undocumented errata in OMAP3 which are fixed later and skewed images =
were seen
> on OMAP2 and OMAP3 during horizontal predecimation which will be addr=
essed in
> the future patches.

All the rotation offset calculations still look suspiciously different
to what is in the harmattan kernel. I remember that the original code
was quite broken, and I fixed a lot of things when I was implementing
pre-decimation and some rotation stuff for the N9/N950. Too bad I never
managed to push that stuff upstream...

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
