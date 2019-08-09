From: Tony Lindgren <tony@atomide.com>
Subject: Regression in next with codec unload and snd_soc_component_get/put
Date: Fri, 9 Aug 2019 00:00:03 -0700
Message-ID: <20190809070003.GA52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit 4a81e8f30d0b ("ASoC: soc-component: add
snd_soc_component_get/put()") causes a regression where trying
to rmmod a codec driver fails with module is in use error after
rmmod of snd-soc-audio-graph-card for example.

Any ideas what goes wrong there?

BTW, looks like the lore.kernel.org link in that commit also is
unreachable?

Regards,

Tony
