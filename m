From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH] W1: OMAP HDQ1W: use 32-bit register accesses
Date: Mon, 23 Jan 2012 23:36:38 +0300
Message-ID: <20120123203638.GA8313@ioremap.net>
References: <alpine.DEB.2.00.1201221319270.26641@utopia.booyaka.com>
 <20120123150753.GA21395@ioremap.net>
 <alpine.DEB.2.00.1201231155590.29673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1201231155590.29673@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, neilb@suse.de
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 23, 2012 at 11:57:09AM -0700, Paul Walmsley (paul@pwsan.com) wrote:
> http://www.spinics.net/lists/arm-kernel/msg156572.html

Well, if runtime PM does its job for clock manipulation properly, then
things should be fine. I suppose that ->probe() will fire up first and
you say it boots and detects w1 properly, so patch looks good.
Feel free to add my ack

-- 
	Evgeniy Polyakov
