From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ams-delta: fix card initalization
	failure
Date: Mon, 27 Aug 2012 14:38:35 -0700
Message-ID: <20120827213835.GE4400@opensource.wolfsonmicro.com>
References: <1346102910-8610-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1346102910-8610-1-git-send-email-jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 27, 2012 at 11:28:30PM +0200, Janusz Krzysztofik wrote:

> -	platform_set_drvdata(ams_delta_audio_platform_device,
> -				&ams_delta_audio_card);
> -
> -	ret = platform_device_add(ams_delta_audio_platform_device);
> -	if (ret)
> -		goto err;

The real fix here is that you should be using platform data here, not
driver data.  Is there some reason not to do that?
