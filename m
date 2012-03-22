From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] OMAP DSS for v3.4
Date: Thu, 22 Mar 2012 15:58:33 +0000
Message-ID: <201203221558.33833.arnd@arndb.de>
References: <1332154865.2144.57.camel@deskari> <201203191624.42020.arnd@arndb.de> <4F6B4A80.309@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49849 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965073Ab2CVP6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 11:58:44 -0400
In-Reply-To: <4F6B4A80.309@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>

On Thursday 22 March 2012, Florian Tobias Schandinat wrote:
> On 03/19/2012 04:24 PM, Arnd Bergmann wrote:
> > I've looked at the specific conflicts again, and it seems that the only
> > conflicting commit in arm-soc is 2e3ee9f45b "ARM: OMAP1: Move most of
> > plat/io.h into local iomap.h". I'm planning to send that one very early,
> > as soon as Russell has his first set up patches merged, so I don't
> > actually have to resolve the conflict here unless Florian is also
> > there early.
> 
> just for your info, I am going to send my pull request today. As I
> didn't find any pull request from you until now, I didn't pull any of
> the branches below.

Ok, thanks for the notification. I'm still waiting for Russell to go
first, so I'll pull in your branch.

	Arnd
