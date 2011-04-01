From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 1 Apr 2011 14:07:20 +0200
Message-ID: <201104011407.20716.arnd@arndb.de>
References: <201103301906.42429.arnd@arndb.de> <201104011322.44729.arnd@arndb.de> <1301658919.27593.72.camel@deskari>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301658919.27593.72.camel@deskari>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 01 April 2011, Tomi Valkeinen wrote:
> Thanks for pointing me to the MCDE stuff. I doesn't seem to be merged,
> though. I need to contact them and see if they're still interested in
> working on the common interface.

I pushed back quite hard on some of the aspects there, which probably
prevented it from going in so far. If the code is as much based on
the OMAP DSS as I think, quite a number of changes are required to
both in order to get them into shape for a decent cross-platform layer,
but there should not be any fundamental issues.

	Arnd
