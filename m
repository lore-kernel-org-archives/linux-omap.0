From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Sat, 27 Aug 2016 15:59:49 +0200
Message-ID: <CAALWOA-XP+mfTcVPc1LZZofAaCK-KtKhFKKKHu2PyHWFrfir3A@mail.gmail.com>
References: <20160525141119.14486-1-rk@ti.com> <20160525141119.14486-2-rk@ti.com>
 <20160825171430.GM2856@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160825171430.GM2856@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ravikumar Kattekola <rk@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Greetings, unfortunate souls trying to use the omap-i2c peripheral in
slave mode! :-)

I recently posted some stuff about exactly that topic on TI's E2E
forum, you may want to read this warning:
http://e2e.ti.com/support/arm/sitara_arm/f/791/p/514961/1955843#1955843

and post contains suggestions on using slave mode and details on the
peripheral actually behaves:
http://e2e.ti.com/support/arm/sitara_arm/f/791/p/514961/1959417#1959417

Matthijs
