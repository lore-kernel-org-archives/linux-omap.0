From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] init/calibrate.c: allow for recalibration of loops
	per jiffy
Date: Mon, 28 Nov 2011 15:39:00 +0000
Message-ID: <20111128153900.GA16481@n2100.arm.linux.org.uk>
References: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl> <1322364751-29980-5-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322364751-29980-5-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 27, 2011 at 04:32:30AM +0100, Janusz Krzysztofik wrote:
> This is required on ARM OMAP1 platform, after DPLL reprogramming has
> been fixed by moving it from setup_arch() to kernel_init().
> 
> Created against linux-3.2-rc2.

Why do you need this?  If you know what the original CPU clock rate and
bogomips were, and the new CPU clock rate, then you simply scale the
bogomips from the original accordingly.  That's what cpufreq does.

You don't have to waste 10s of milliseconds redoing the bogomips
calibration.
