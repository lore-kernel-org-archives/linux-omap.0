From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: OMAP: Remove obsolete Makefile line
Date: Thu, 30 May 2013 12:39:14 +0300
Message-ID: <20130530123914.fba4840122d4fbca3c182e08@bitmer.com>
References: <1369899460.23034.31.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1369899460.23034.31.camel@x61.thuisdomein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 30 May 2013 09:37:40 +0200
Paul Bolle <pebolle@tiscali.nl> wrote:

> Support for omap2evm was removed in v3.0. But only one of its two
> lines in this Makefile was removed. Remove the second line too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Eyeball tested only.
> 
>  sound/soc/omap/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
True, commit 91d94af ("omap: Remove support for omap2evm") removed only omap2evm.o.

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
