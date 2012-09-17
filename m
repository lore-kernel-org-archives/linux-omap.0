From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 02/15] dmaengine: omap: Add support for pause/resume
 in cyclic dma mode
Date: Mon, 17 Sep 2012 11:41:23 +0300
Message-ID: <5056E233.6010900@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>  <1347624358-25582-3-git-send-email-peter.ujfalusi@ti.com> <1347851637.1943.125.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347851637.1943.125.camel@vkoul-udesk3>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-omap@vger.kernel.org

Hi Vinod,

On 09/17/2012 06:13 AM, Vinod Koul wrote:
> On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
>> -       /* FIXME: not supported by platform private API */
>> -       return -EINVAL;
>> +       /* Pause/Resume only allowed with cyclic mode */
>> +       if (!c->cyclic)
>> +               return -EINVAL;=20
> This is not a dma restriction right?

The pause/resume operation has been only used by audio. This might work=
 with
non cyclic modes as well but it has never been used/tested so to be saf=
e I
have added this restriction.

--=20
P=C3=A9ter
