From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 06/14] ARM: dts: omap5-board-common: Add
 pdmclk binding for audio
Date: Fri, 10 Jun 2016 04:36:40 -0700
Message-ID: <20160610113639.GE22406@atomide.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
 <20160530085522.30398-7-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20160530085522.30398-7-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, broonie@kernel.org, linux-omap@vger.kernel.org, lee.jones@linaro.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160530 01:58]:
> The twl6040 codec is generating the pdmclk, which is used by the McPDM as
> functional clock.

Applying patches 6 - 10 into omap-for-v4.8/dt thanks.

Tony
