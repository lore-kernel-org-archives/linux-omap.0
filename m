Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CF440636;
	Wed, 19 Aug 2026 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166348; cv=none; b=AR2PLYq4T61OJNrMD1GNF6kUvhmy2M/Jy9rB2juyhlicQ/LxxM6oQqnPkaQE8AKHkzm8u1lIP2gdjVz5vHvUu5l2Ymj7UCsIvok1DJEUGjCipHrbLpNbL23lOs22ylVb8EKPtnzKVzVnbUHklquOiWYPeSKzmS3i47k20VLpTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166348; c=relaxed/simple;
	bh=ii+gwOsrWSanD8cArg5+GVkdGSU7vXp70zu7el1rC5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQq4m43PiKk5EXKBsLOru4279KN4nBqfoS1aIXbsui9wd0l6IBxRy0dA5LRkgJJn9gwk3MLVLpTey0v8FsHnC9/LxKAkX28Irs4FHOg7zUbFCh58+4IJ7Bm/zxm5jQObh4OAHwIGm4WpMjaIVYWa0cjPIP0/iBph37porQaORi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576961F000E9;
	Wed, 19 Aug 2026 19:05:41 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Tero Kristo <kristo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH treewide 0/5] clk: Make sure clk_init_data is fully initialized (part 1)
Date: Wed, 19 Aug 2026 21:05:14 +0200
Message-ID: <cover.1787165329.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

The clk_init_data structure contains three mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  When commit
fc0c209c147f35ed ("clk: Allow parents to be specified without string
names") added the last two methods, this was done in a
backwards-compatible way, using a priority-based scheme:
  - .name, .ops, .num_parents, and .flags must always be initialized,
  - if .num_parents is non-zero, .parent_names must be initialized,
      - if .parent_names is NULL, .parent_data must be initialized,
	  - if .parent_data is NULL, .parent_hws must be initialized
	    and valid.

However, not initializing all members may cause subtle issues, which are
only exposed when CONFIG_INIT_STACK_ALL_PATTERN or
CONFIG_INIT_STACK_NONE is enabled.

Hence this series makes sure all members are fully initialized, to fix
such bugs, and to avoid future breakage when converting drivers to a
different method for specifying the parents.

This (small) series is part 1, and fixes all cases that I identified to
be real bugs:
  - The first patch fixes a crash I saw on BeagleBone Black,
  - The other patches are only compile-tested.
All patches in this series can be applied independently.

Part 2 will be much larger (touching 185 files), and will fix the
remaining cases that are currently harmless.

Thanks for your comments!

Geert Uytterhoeven (5):
  clk: ti: Make sure clk_init_data is fully initialized
  clk: visconti: Make sure clk_init_data is fully initialized
  hwmon: (ltc4282) Make sure clk_init_data is fully initialized
  iio: frequency: adf4377: Make sure clk_init_data is fully initialized
  spi: amlogic-spisg: Make sure clk_init_data is fully initialized

 drivers/clk/ti/adpll.c          | 4 ++--
 drivers/clk/ti/divider.c        | 2 +-
 drivers/clk/ti/mux.c            | 2 +-
 drivers/clk/visconti/clkc.c     | 2 +-
 drivers/hwmon/ltc4282.c         | 2 +-
 drivers/iio/frequency/adf4377.c | 2 +-
 drivers/spi/spi-amlogic-spisg.c | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
