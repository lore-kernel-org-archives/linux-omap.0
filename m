From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature (fwd)
Date: Wed, 24 May 2017 09:39:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1705240938520.2983@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

CPCAP_BIT_ADTRIG_DIS is duplicated on lines 77-82.

julia

---------- Forwarded message ----------
Date: Wed, 24 May 2017 03:18:35 +0800
From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: kbuild-JC7UmRfGjtg@public.gmane.org
Cc: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
    battery temperature

Hi Tony,

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.12-rc2 next-20170523]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tony-Lindgren/Few-non-critical-cpcap-ADC-fixes/20170524-012140
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
:::::: branch date: 2 hours ago
:::::: commit date: 2 hours ago

>> drivers/iio/adc/cpcap-adc.c:78:6-26: duplicated argument to & or |

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 02e16000e23c899bba86e7dde2b3eaaf8fc76da2
vim +78 drivers/iio/adc/cpcap-adc.c

25ec2496 Tony Lindgren 2017-03-23  62  #define CPCAP_BIT_ADTRIG_ONESHOT	BIT(13)	/* Set for !TIMING_IMM */
25ec2496 Tony Lindgren 2017-03-23  63  #define CPCAP_BIT_ASC			BIT(12)	/* Set for TIMING_IMM */
25ec2496 Tony Lindgren 2017-03-23  64  #define CPCAP_BIT_ATOX_PS_FACTOR	BIT(11)
25ec2496 Tony Lindgren 2017-03-23  65  #define CPCAP_BIT_ADC_PS_FACTOR1	BIT(10)
25ec2496 Tony Lindgren 2017-03-23  66  #define CPCAP_BIT_ADC_PS_FACTOR0	BIT(9)
25ec2496 Tony Lindgren 2017-03-23  67  #define CPCAP_BIT_AD4_SELECT		BIT(8)	/* Currently unused */
25ec2496 Tony Lindgren 2017-03-23  68  #define CPCAP_BIT_ADC_BUSY		BIT(7)	/* Currently unused */
02e16000 Tony Lindgren 2017-05-22  69  #define CPCAP_BIT_THERMBIAS_EN		BIT(6)	/* Bias for AD0_BATTDETB */
25ec2496 Tony Lindgren 2017-03-23  70  #define CPCAP_BIT_ADTRIG_DIS		BIT(5)	/* Disable interrupt */
25ec2496 Tony Lindgren 2017-03-23  71  #define CPCAP_BIT_LIADC			BIT(4)	/* Currently unused */
25ec2496 Tony Lindgren 2017-03-23  72  #define CPCAP_BIT_TS_REFEN		BIT(3)	/* Currently unused */
25ec2496 Tony Lindgren 2017-03-23  73  #define CPCAP_BIT_TS_M2			BIT(2)	/* Currently unused */
25ec2496 Tony Lindgren 2017-03-23  74  #define CPCAP_BIT_TS_M1			BIT(1)	/* Currently unused */
25ec2496 Tony Lindgren 2017-03-23  75  #define CPCAP_BIT_TS_M0			BIT(0)	/* Currently unused */
25ec2496 Tony Lindgren 2017-03-23  76
02e16000 Tony Lindgren 2017-05-22  77  #define CPCAP_REG_ADCC2_DEFAULTS	(CPCAP_BIT_AD4_SELECT | \
02e16000 Tony Lindgren 2017-05-22 @78  					 CPCAP_BIT_ADTRIG_DIS | \
02e16000 Tony Lindgren 2017-05-22  79  					 CPCAP_BIT_ADTRIG_DIS | \
02e16000 Tony Lindgren 2017-05-22  80  					 CPCAP_BIT_LIADC | \
02e16000 Tony Lindgren 2017-05-22  81  					 CPCAP_BIT_TS_M2 | \
02e16000 Tony Lindgren 2017-05-22  82  					 CPCAP_BIT_TS_M1)
02e16000 Tony Lindgren 2017-05-22  83
25ec2496 Tony Lindgren 2017-03-23  84  #define CPCAP_MAX_TEMP_LVL		27
25ec2496 Tony Lindgren 2017-03-23  85  #define CPCAP_FOUR_POINT_TWO_ADC	801
25ec2496 Tony Lindgren 2017-03-23  86  #define ST_ADC_CAL_CHRGI_HIGH_THRESHOLD	530

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
