From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arch/arm/plat-omap/clock.c: included linux/debugfs.h
 twice
Date: Mon, 5 Mar 2012 14:12:47 -0800
Message-ID: <20120305221247.GZ12083@atomide.com>
References: <1329403433-32327-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1329403433-32327-1-git-send-email-danny.kukawka@bisect.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: Paul Walmsley <paul@pwsan.com>, Danny Kukawka <dkukawka@suse.de>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Danny Kukawka <danny.kukawka@bisect.de> [120216 06:12]:
> arch/arm/plat-omap/clock.c: included 'linux/debugfs.h' twice,
> remove the duplicate.

Thanks, applying into fixes-non-critical-part2.

Regards,

Tony
