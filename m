From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/25] Re-jig cpu_suspend for a saner calling convention
Date: Thu, 23 Jun 2011 15:14:15 -0700
Message-ID: <87r56k6vrc.fsf@ti.com>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu, 23 Jun 2011 20:09:00 +0100")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

[...]

>
> Tested on Assabet (SA1100) and 3430LDP only.
>

Tested-by: Kevin Hilman <khilman@ti.com>

Tested on OMAP: 3430/n900, 3530/Overo and 3630/Zoom3.

In addition to this series, I needed that ENDPROC fix as well as the
v7_processor_functions patch just sent.

With those, I was able to hit full-chip retention and off-mode in both
suspend and idle paths on the above platforms.

Kevin
