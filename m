From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCHv5 0/7] HSI framework and drivers
Date: Fri, 21 Oct 2011 14:36:17 +0100
Message-ID: <20111021143617.7b37032c@lxorguk.ukuu.org.uk>
References: <1307713124-3946-1-git-send-email-carlos.chinea@nokia.com>
	<20111020125705.GA2121@earth.universe>
	<CACRpkdYBFGp4+oFUZvXn-wpUk0fmLiKixchQKcFo9XTDW=51+g@mail.gmail.com>
	<1319192913.2702.38.camel@groo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319192913.2702.38.camel@groo>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: ext Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@debian.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, govindraj.ti@gmail.com, pawel.szyszuk@stericsson.com, sjur.brandeland@stericsson.com, peter_henn@gmx.de
List-Id: linux-omap@vger.kernel.org

> A. I create the branch with just the hsi_char and the hsi framework
> B. The same as A but with STE or another hsi/ssi controller driver.

With my Intel hat on we've also got stuff using this framework and
controllers that we'd want to sync with the current version of the core
code (I think it's diverged a bit).

Alan
