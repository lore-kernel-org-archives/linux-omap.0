From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: tslib on OMAP3
Date: Wed, 25 Jun 2008 11:55:54 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53045DE4ED@dlee03.ent.ti.com>
References: <200806251833.25218.thomas.cooksey@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56051 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbYFYQ4G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 12:56:06 -0400
In-Reply-To: <200806251833.25218.thomas.cooksey@trolltech.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tom Cooksey <thomas.cooksey@trolltech.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tom

> Does anyone have tslib running well on an OMAP3?
>
> I have a LogicPD Zoom LPD3430 thing and a TI OMAP3430 SDP dev board,
> and both have similar issues. The touchscreen is on /dev/input/event1 and
> works, but is so inaccurate, it's almost unusable. After running
> ts_calibrate
> I'm testing with ts_test. If I press and hold with ts_test in draw mode, I
> can
> see just how inaccurate it is... After a few seconds I get a white blob
> about
> 1/3 of the screen width in diameter.
>
> Has anyone got this to work correctly? If so, what tslib plugins/modules
> are
> you using and with which parameters? I've tried various combinations and
> found some to give a slight improvement and others make it a lot worse.

Try the new kernel image from omapzoom website fro ldp

http://www.omapzoom.org/pub/kernel/linux-ldp-v1.4.tar.bz2

The environment variables:

export TSLIB_TSDEVICE=/dev/input/event1
export TSLIB_CONFFILE=/etc/ts.conf
export TSLIB_PLUGINDIR=/lib/ts

then execute ts_calibrate and ts_test

Regards
Abraham

