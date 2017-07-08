From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Motorola Droid 4 Audio Support
Date: Fri, 7 Jul 2017 22:27:53 -0700
Message-ID: <20170708052753.GM3730@atomide.com>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170707 09:43]:
> Hi,
> 
> I got working sound on Droid 4 with mainline \o/. The codec is
> currently missing support for detecting if something has been
> plugged into the 3.5mm connector, since that seems to require
> some closed source firmware and needs further investigation. I
> think this can be added later.

Hey that's great! I'll give it a try this weekend.. Does that mean
that 3G voice calls work too now or is something more needed there?

For the CPCAP PMIC macro interrupts I think it's best to set up
a separate driver as it seems separate from the core CPCAP
functionality. So I think we can just move the unused "cpcap-m2"
IRQ banks out of motorola-cpcap.c and put them into a separate child
driver that loads it's firmware on init and provides interrupts for
the 3.5mm connector.

Regards,

Tony
