From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 5/5 v2] ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram
Date: Sat, 10 Dec 2011 13:04:29 +0100
Message-ID: <201112101304.30135.jkrzyszt@tis.icnet.pl>
References: <1322364751-29980-6-git-send-email-jkrzyszt@tis.icnet.pl> <201112091100.01690.jkrzyszt@tis.icnet.pl> <20111210002503.GA6018@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:47115 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737Ab1LJMIs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Dec 2011 07:08:48 -0500
In-Reply-To: <20111210002503.GA6018@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Saturday 10 of December 2011 at 01:25:03, Russell King - ARM Linux wrote:
> On Fri, Dec 09, 2011 at 11:00:01AM +0100, Janusz Krzysztofik wrote:
> > 
> > Those were BogoMIPS, ...
> 
> I realise that.  But which is which - is 70.40 from recalibrate_delay
> or is it 74.54?  Your message is too vague to be able to interpret your
> results because it's impossible to work out what figure refers to which
> method.

Yes, I realised what you had actually asked about after re-reading your 
answer, which I unfortunately did after I had already replied, sorry.

> > ... Then, in case of a machine always booting at, let's say, 12 and
> > then reprogrammed to 150 MHz, we actually scale up that less then the
> > theoretical number, with a side effect of scaling up its error as well.
> > Perhaps in this case, when the machine is going to run at that target
> > rate until rebooted, we should rather decide to recalibrate to keep
> > that error proportionally small compared to the target loops per
> > jiffy value ...
> 
> It really doesn't matter - udelay() etc is not designed to be mega
> accurate but good enough... 

Great, that's the answer to my initial question: loops per jiffy 
inaccuracy of 6% shouldn't matter.

Thanks,
Janusz
