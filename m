From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv2 0/3] Few non-critical cpcap ADC fixes
Date: Mon, 22 May 2017 17:51:43 -0700
Message-ID: <20170523005146.726-1-tony@atomide.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few fixes for cpcap ADC mostly to get temperature readings                                  produce sane values. AFAIK no need for urgency with these and they                                   can all wait for v4.13 merge window.

Regards,

Tony

Changes since v1:

- Rename CPCAP_ADC_AD0_BATTDETB to just CPCAP_ADC_AD0 based on
  Matt Ranostay's suggestion as it's the battery temperature

- Add ack from Sebastian Reichel

Tony Lindgren (3):
  iio: adc: cpcap: Fix default register values and battery temperature
  iio: adc: cpcap: Fix die temperature
  iio: adc: cpcap: Remove hung interrupt quirk

 drivers/iio/adc/cpcap-adc.c | 109 +++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 32 deletions(-)

-- 
2.13.0
