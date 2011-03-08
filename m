From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: AM3517: Update codec name after
 multi-component update
Date: Tue, 8 Mar 2011 15:34:03 +0000
Message-ID: <20110308153402.GA21538@opensource.wolfsonmicro.com>
References: <1299598363-32656-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1299598363-32656-1-git-send-email-abhilash.kv@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 08, 2011 at 09:02:43PM +0530, Abhilash K V wrote:
> The i2c client device name (".2-001a" in this case, including
> the separator period) for the AIC23 codec on the TI AM3517-EVM
> was appended to the codec_name member of am3517evm_dai to
> resolve the names mismatch happening in soc_bind_dai_link(),
> due to which the card was not getting registered.

Ached-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
