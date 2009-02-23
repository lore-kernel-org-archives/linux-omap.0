From: "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>
Subject: Re: [REVIEW PATCH 11/14] OMAP34XXCAM: Add driver
Date: Mon, 23 Feb 2009 10:50:29 +0200
Message-ID: <200902231050.29282.tuukka.o.toivonen@nokia.com>
References: <Aclb0Ghhhph2tRyARSuubB27tGfovg==> <A24693684029E5489D1D202277BE894415E6E1A1@dlee02.ent.ti.com> <5e9665e10902230008g62d5f3bfm56cffdfe04a3adea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50993 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbZBWIut (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 03:50:49 -0500
In-Reply-To: <5e9665e10902230008g62d5f3bfm56cffdfe04a3adea@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ailus Sakari (Nokia-D/Helsinki)" <Sakari.Ailus@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>

On Monday 23 February 2009 10:08:54 ext DongSoo(Nathaniel) Kim wrote:
> So, logically it does not make sense with making device nodes of every
> single slave attached with OMAP3camera interface. Because they can't
> be opened at the same time,even if it is possible it should not work
> properly.
> 
> So.. how about making only single device node like /dev/video0 for
> OMAP3 camera interface and make it switchable through V4L2 API. Like
> VIDIOC_S_INPUT?

You are right that if the OMAP3 has several camera sensors attached
to its camera interface, generally just one can be used at once.

However, from user's perspective those are still distinct
cameras. Many v4l2 applications don't support VIDIOC_S_INPUT
or at least it will be more difficult to use than just pointing
an app to the correct video device. Logically they are two
independent cameras, which can't be used simultaneously
due to HW restrictions.

- Tuukka
