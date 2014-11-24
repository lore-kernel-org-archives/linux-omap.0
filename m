From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: Re: [PATCH v3 2/4] i2c: omap: implement workaround for handling invalid BB-bit values
Date: Mon, 24 Nov 2014 23:05:21 +0300
Message-ID: <47749B61-5924-4E56-9931-77B0CFC0AAA0@gmail.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com> <1416685634-5864-1-git-send-email-al.kochet@gmail.com> <1416685634-5864-3-git-send-email-al.kochet@gmail.com> <CAMAWPa8whctBR6fBFaSzPvm3qn+QK06CimRrxFxxH=0kNkF4UA@mail.gmail.com> <47A1A441-952C-4AC3-859C-5A8E405767E0@gmail.com> <20141124194759.GG2757@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141124194759.GG2757@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@kernel.org>, Felipe Balbi <balbi@ti.com>, Wolfram Sang <wsa@the-dreams.de>, linux-omap <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Alexander Kochetkov <al.kochet@gmail.com>
List-Id: linux-omap@vger.kernel.org

Guys, I really sorry for that :(

> Just try to boot it with your patch? :)

Yes, may be two-three times (max).
Something (u-boot, may be) leave the bus in the wrong state.
Really strange.

> But the test function should not loop forever in any case I take?

It doesn't loop forever. It finish with message:
"[    3.046691] omap_i2c 48070000.i2c: timeout waiting for bus ready"

> So I doubt we just want to change the test for for a higher rev number
> for  OMAP_I2C_REV_ON_3430_3530.


Yes, I'll do it within 15 minutes.
And later, if it possible, I'd try to see what happens.

Alexander.
