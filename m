From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Remove restrictive
	checks for cpu type
Date: Fri, 13 May 2011 13:13:02 +0100
Message-ID: <4DCD204E.5030707@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1305122135-27938-1-git-send-email-premi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On 11/05/11 14:55, Premi, Sanjeev wrote:
> Current checks for cpu type were too restrictive leading
> to failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> cc: Liam Girdwood <lrg@ti.com>
> cc: Jarkko Nikula <jhnikula@gmail.com>
> ---
> 
>  Changes in v4:
>    Reposting after validating that patch still applies cleanly on
>    linux-omap master [46966f1]
> 
>    Changed the subject as suggested by Jarkko. Since the subject
>    has changed, i have omitted v4.
> 
>  Changes in v3::
>    None. Reposting[1] after subscribing to alsa-devel list
> 
>  Changes in v2:
>    1) Added one more check to the changes.
>    2) Updated commit message to use plurals.
> 
> 
> 
Applied.

Thanks

Liam
