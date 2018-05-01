From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/6] ARM: dts: omap2420-n810: Enable
	McBSP2 for audio
Date: Tue, 1 May 2018 08:36:40 -0700
Message-ID: <20180501153640.GF98604@atomide.com>
References: <20180427081715.28791-1-peter.ujfalusi@ti.com>
 <20180427081715.28791-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180427081715.28791-2-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [180427 08:18]:
> McBSP2 is used with the tlv320aic33 codec for audio.
> Pin mux change is needed to get the needed signals in/out from the SoC.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Thanks applying patches 1 and 2 of this series into omap-for-v4.18/dt.

Regards,

Tony
