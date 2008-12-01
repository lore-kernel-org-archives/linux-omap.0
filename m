From: Laurent Pinchart <laurent.pinchart@skynet.be>
Subject: Re: [PULL] http://www.linuxtv.org/hg/~hverkuil/v4l-dvb-ng
Date: Mon, 1 Dec 2008 13:31:25 +0100
Message-ID: <200812011331.25676.laurent.pinchart@skynet.be>
References: <200812011246.08885.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:18281 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750956AbYLAMbV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 07:31:21 -0500
In-Reply-To: <200812011246.08885.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: video4linux-list@redhat.com
Cc: Hans Verkuil <hverkuil@xs4all.nl>, v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com, Mauro Carvalho Chehab <mchehab@infradead.org>

On Monday 01 December 2008, Hans Verkuil wrote:
> Hi Mauro,
>
> Please pull from http://www.linuxtv.org/hg/~hverkuil/v4l-dvb-ng for the
> following:
>
> - v4l2: add v4l2_device and v4l2_subdev structs to the v4l2 framework.
> - v4l2-common: add i2c helper functions
> - cs53l32a: convert to v4l2_subdev.
> - cx25840: convert to v4l2_subdev.
> - m52790: convert to v4l2_subdev.
> - msp3400: convert to v4l2_subdev.
> - saa7115: convert to v4l2_subdev.
> - saa7127: convert to v4l2_subdev.
> - saa717x: convert to v4l2_subdev.
> - tuner: convert to v4l2_subdev.
> - upd64031a: convert to v4l2_subdev.
> - upd64083: convert to v4l2_subdev.
> - vp27smpx: convert to v4l2_subdev.
> - wm8739: convert to v4l2_subdev.
> - wm8775: convert to v4l2_subdev.
> - ivtv/ivtvfb: convert to v4l2_device/v4l2_subdev.
>
> All points raised in reviews are addressed so I think it is time to get
> this merged so people can start to use it.

Does linuxtv.org and Mercurial provide the necessary infrastructure to 
integrate those changes into the v4l-dvb repository while not pushing them 
upstream yet ? I'd like to see more people testing (and breaking and 
fixing :-)) your changes before they reach the mainline kernel.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@skynet.be>
> Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Reviewed-by: Andy Walls <awalls@radix.net>
> Reviewed-by: David Brownell <david-b@pacbell.net>
>
> Once this is in I'll start on converting the other i2c drivers.

Best regards,

Laurent Pinchart
