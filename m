From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2a/5] Remove unsafe clock values from omap1_defconfig
Date: Wed, 30 Nov 2011 14:32:42 -0800
Message-ID: <20111130223242.GS31337@atomide.com>
References: <20111128174508.GO31337@atomide.com>
 <1322517644-5066-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322517644-5066-1-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111128 13:26]:
>
> I'm not sure which of the patches you meant not ready for 3.2-rc. From
> your comment I would conclude that only patch 3/5, which would really
> break omap1_defconfig booting on some boards, is questionable, while you
> posted this comment against patch 1/5, which I don't see how it could
> break booting, including omap1_defconfig.

Sorry for the delay in replying, yes you're right looks like it's allowing
the rate changes currently that would break things in 3/5.
 
> Anyway, I hope that the additional patch below is addressing all your
> concerns.

I'd rather not modify omap1_defconfig as a fix assuming that we'll be
removing all those options anyways the next merge window together with
your new patch.
 
Can you please split your series into two: Fix(es) for the -rc cycle,
then patches that can be left for the next merge window.

Cheers,

Tony
