From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 22/30] mfd: build twl6030 only on omap2
Date: Tue, 4 Oct 2011 16:47:02 +0200
Message-ID: <201110041647.02690.arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-23-git-send-email-arnd@arndb.de> <20111004104713.GY4118@sortiz-mobl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111004104713.GY4118@sortiz-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Balaji T K <balajitk@ti.com>, Hemanth V <hemanthv@ti.com>, Bill Gatliff <bgat@billgatliff.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 04 October 2011, Samuel Ortiz wrote:
> On Sun, Oct 02, 2011 at 04:45:52PM +0200, Arnd Bergmann wrote:
> > We can only have one pwm driver built into the kernel,
> I seem to remember that Bill Gatliff was working on a PWM subsystem that would
> get rid of the current pwm.h ugliness. Do we have any updates on this one ?

I don't know if the work on the pwm subsystem is progressing right now,
there were at one point two competing patches, but so far neither of them
has made it into linux-next.
 
> The patch below looks like a hack to me, trying to work around the current
> lack of such subsystem.

Absolutely. I'll clarify this in the patch description when I fix the
bug pointed out by Balaji T Krishnamoorthy.

	Arnd
