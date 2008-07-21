From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/0] Power domain and clock domain patches for omap
Date: Mon, 21 Jul 2008 23:29:08 +0100
Message-ID: <20080721222908.GF18909@flint.arm.linux.org.uk>
References: <1216221555-18958-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755757AbYGUW3a@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1216221555-18958-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 16, 2008 at 06:19:05PM +0300, Tony Lindgren wrote:
> I'm reposting the series to a wider audience as Russell King suspected that
> other archs may be interested in reviewing these too, or at least some
> parts of the code.

It would be nice to have some comment on these patches from other
people.  My suspicions is that this infrastructure is solving a
problem found on other SoCs in addition to OMAP, and, if this is
useful to other people, it should become cross-SoC infrastructure.

Since I don't know the answer to whether it would be useful, I'm
trying to ensure that these patches have sufficient exposure to
people who _may_ know the answer.
