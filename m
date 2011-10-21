From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCHv5 0/7] HSI framework and drivers
Date: Fri, 21 Oct 2011 14:19:55 +0200
Message-ID: <CACRpkdb6sm-Xq=NSj2Qp8Lx0=hurEVtr91OLt0VtDLjEtn3_XA@mail.gmail.com>
References: <1307713124-3946-1-git-send-email-carlos.chinea@nokia.com>
	<20111020125705.GA2121@earth.universe>
	<CACRpkdYBFGp4+oFUZvXn-wpUk0fmLiKixchQKcFo9XTDW=51+g@mail.gmail.com>
	<1319192913.2702.38.camel@groo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319192913.2702.38.camel@groo>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: Sebastian Reichel <sre@debian.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, govindraj.ti@gmail.com, pawel.szyszuk@stericsson.com, sjur.brandeland@stericsson.com, peter_henn@gmx.de
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 21, 2011 at 12:28 PM, Carlos Chinea <carlos.chinea@nokia.com> wrote:

(...)
> Basically, we have 2 alternatives for that:
>
> A. I create the branch with just the hsi_char and the hsi framework
> B. The same as A but with STE or another hsi/ssi controller driver.

I'd say (A) and then when someone (like me) fixes up the
STE HSI controller you can just git am that on top of the
framework. Possibly you can also stack the needed OMAP
changes in the same HSI tree provided you get an ACK
from the subsystem maintainer.

Yours,
Linus Walleij
