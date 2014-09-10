From: Nishanth Menon <nm@ti.com>
Subject: Re: 3.15+: omap4: mmc: multi_v7: can't boot off mmc
Date: Wed, 10 Sep 2014 11:50:01 -0500
Message-ID: <20140910165000.GA3026@splat>
References: <20140910153316.GA12169@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140910153316.GA12169@luxor.wired.org>
Sender: linux-mmc-owner@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mmc' <linux-mmc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 17:33-20140910, Paolo Pisati wrote:
> I'm having an hard time making the vanilla v7_defconfig boot off the mmc on my
> pandaboard:

V3.15:
https://github.com/nmenon/kernel-test-logs/blob/v3.15/multi_v7_defconfig/pandaboard-vanilla.txt
https://github.com/nmenon/kernel-test-logs/blob/v3.15/multi_v7_defconfig/pandaboard-es.txt

v3.16:
https://github.com/nmenon/kernel-test-logs/blob/v3.16/multi_v7_defconfig/pandaboard-es.txt
https://github.com/nmenon/kernel-test-logs/blob/v3.16/multi_v7_defconfig/pandaboard-vanilla.txt

Latest tag: v3.17-rc4
https://github.com/nmenon/kernel-test-logs/blob/v3.17-rc4/multi_v7_defconfig/pandaboard-es.txt
https://github.com/nmenon/kernel-test-logs/blob/v3.17-rc4/multi_v7_defconfig/pandaboard-vanilla.txt


You might be interested in using partuuid to be careful about the probe
order deltas that may take place.

-- 
Regards,
Nishanth Menon
