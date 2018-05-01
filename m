From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v2 5/6] ASoC: omap: n810: HS mic is not
 working, add a widget for it with comment
Date: Tue, 1 May 2018 21:44:53 +0300
Message-ID: <dfda4dc8-32e5-b85a-5c71-d0e26ee31be0@bitmer.com>
References: <20180427081715.28791-1-peter.ujfalusi@ti.com>
 <20180427081715.28791-6-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180427081715.28791-6-peter.ujfalusi@ti.com>
Content-Language: en_US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

On 04/27/18 11:17, Peter Ujfalusi wrote:
> The bias for the analog HS microphone is coming from Retu/Vilma chip and
> we do not have control over it, yet.
> 
> For clarity, add a new DAPM_MIC widget for the HS mic and document the
> current state.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/n810.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
