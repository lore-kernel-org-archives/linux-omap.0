From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2: powerdomain: Add break in switch statement
Date: Mon, 12 Jul 2010 14:21:01 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007121418220.10106@utopia.booyaka.com>
References: <1278661253-22185-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278661253-22185-1-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 9 Jul 2010, Thomas Weber wrote:

> Add a missing break at end of switch statement. At the moment it is a
> fall through to WARN_ON(1) and return -EEXIST.
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>

Thanks Thomas.

Tony, this is

Acked-by: Paul Walmsley <paul@pwsan.com>

if you want it for .36; otherwise, can queue it for .37 here.


- Paul
