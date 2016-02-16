From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: omapfb: Add early framebuffer memory allocator
Date: Tue, 16 Feb 2016 15:05:15 +0100
Message-ID: <20160216140515.GI1476@pali>
References: <52A062A0.3070005@ti.com>
 <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201601011301.27415@pali>
 <568A5970.2000201@ti.com>
 <568A6DD1.5050700@gmail.com>
 <5693F5B7.8040608@ti.com>
 <56BEDA57.4030300@gmail.com>
 <56C32966.9020105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C32966.9020105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tony@atomide.com, linux@arm.linux.org.uk, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

On Tuesday 16 February 2016 15:51:34 Tomi Valkeinen wrote:
> Another thing, with v4.5, omapfb has moved into maintenance mode. I
> don't want to merge new features there. Are you planning to move to
> omapdrm, and if not, why? I'd rather see all this done for omapdrm on=
ly.

Hi! We are using (patched) Maemo and for OpenGL ES support we need SGX
PVR graphics kernel driver which depends on omapfb :-( Because Maemo
needs OpenGL ES we needs omapfb driver. Kernel part of SGX PVR driver i=
s
open source (GPL) but there is no manpower to port it to omapdrm...

So if we want to use (patched) Maemo (which I really want) we need to
stay on omapfb for now...

And there are no full open source drivers for SGX PVR graphic chip whic=
h
would work on TI omap3 Nokia N900 device...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
