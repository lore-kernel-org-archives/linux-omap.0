From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] omap: dmtimer: convert printk to pr_err
Date: Fri, 07 Oct 2011 12:48:21 -0700
Message-ID: <1318016901.11045.9.camel@Joe-Laptop>
References: <20111006201827.GT6324@atomide.com>
	 <1317977417-17874-1-git-send-email-vjaquez@igalia.com>
	 <20111007092243.GC27281@n2100.arm.linux.org.uk>
	 <1318009239.1644.38.camel@Joe-Laptop>
	 <20111007191822.GA26805@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111007191822.GA26805@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: =?ISO-8859-1?Q?V=EDctor?= Manuel =?ISO-8859-1?Q?J=E1quez?= Leal <vjaquez@igalia.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Timo Teras <timo.teras@solidboot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2011-10-07 at 20:18 +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 07, 2011 at 10:40:39AM -0700, Joe Perches wrote:
> > At some point in the next couple of years, I want
> > to convert all of, or as many as possible of, the
> > remaining printk uses to pr_<level>.
> If the idea is also to get rid of printk() too (which IMHO would be a
> good thing as it kills off the constant need to continually patch for
> missing KERN_ prefixes) then that's a good reason (provided Linus
> accepts the idea.)

I don't accept that idea yet.

There are about 50K printks vs 20K pr_<level>s
in kernel source.

I think 50K lines is _way_ too many to convert
in a couple of years.

I think it needs to be done subsystem by subsystem,
arch by arch, as maintainers accept.

And there's no hurry.

I have a script that automates most all of the
conversions, argument alignments, etc.
