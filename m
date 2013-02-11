From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: Add OMAP4 Blaze Tablet support
Date: Mon, 11 Feb 2013 11:00:11 -0800
Message-ID: <20130211190011.GS4801@atomide.com>
References: <1360352269-14922-1-git-send-email-ruslan.bilovol@ti.com>
 <1360352269-14922-2-git-send-email-ruslan.bilovol@ti.com>
 <20130210025225.GB4801@atomide.com>
 <51193DE1.6080704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51193DE1.6080704@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Jon Hunter <jon-hunter@ti.com> [130211 10:58]:
> 
> Please note that the blaze is derived from the omap4-sdp board and so I
> would hope that we can use the existing for sdp dts and board file for
> blaze. In fact this is what I do today for basic booting.
> 
> So unless there is some feature on the blaze that is not compatible with
> the original sdp, we should just use the sdp dts.

Sounds like we need some common .dts file and separate files
for sdp, blaze and tablet that include the common .dts file?

There's a different LCD panel at least between blaze and the
tablet.

Regards,

Tony
