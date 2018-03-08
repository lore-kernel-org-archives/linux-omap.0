From: Kees Cook <keescook@chromium.org>
Subject: Re: linux-next on n900: oops in codec_reg_show() when
	grepping sysfs
Date: Thu, 8 Mar 2018 11:47:50 -0800
Message-ID: <CAGXu5jK1cvTOCT_OZVwk20LCNt6QLEM5CoLBXpT9JaHpwEKeJg@mail.gmail.com>
References: <20180308151421.GA13160@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180308151421.GA13160@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: peter.ujfalusi@ti.com, moderated for non-subscribers <alsa-devel@alsa-project.org>, ivo.g.dimitrov.75@gmail.com, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, security@kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Mark Brown <broonie@kernel.org>, abcloriens@gmail.com, Sakari Ailus <sakari.ailus@linux.intel.com>, pali.rohar@gmail.com, Clayton Craft <clayton@craftyguy.net>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 8, 2018 at 7:14 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> pavel@n900:/sys$ uname -a
> Linux n900 4.16.0-rc4-next-20180308 #71 Thu Mar 8 15:27:49 CET 2018
> armv7l GNU/Linux
> pavel@n900:/sys$ grep -ri fasdfasdf .
>
> leads to an oops:
>
> [ 2278.331878] DSS: context saved
> [ 2278.820343] Unable to handle kernel NULL pointer dereference at
> virtual address 00000004
> [ 2278.828948] pgd = c36040a2
> [ 2278.831787] [00000004] *pgd=876c4831, *pte=00000000, *ppte=00000000
> [ 2278.838439] Internal error: Oops: 17 [#1] ARM
> [ 2278.843017] Modules linked in:
> [ 2278.846221] CPU: 0 PID: 16337 Comm: grep Tainted: G        W
> 4.16.0-rc4-next-20180308 #71
> [ 2278.855529] Hardware name: Nokia RX-51 board
> [ 2278.860015] PC is at soc_codec_reg_show+0x8/0x19c
> [ 2278.864959] LR is at codec_reg_show+0x28/0x30

Looks like a NULL codec (driver has offsetof of 0x4).

static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
                                  size_t count, loff_t pos)
{
...
        loff_t p = 0;

        wordsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
        regsize = codec->driver->reg_word_size * 2;
...

This would paper over it. I have no idea that the lifetime expectation
are for codec and driver...

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6576c9..78ad165ad424 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct
snd_soc_codec *codec, char *buf,
        size_t total = 0;
        loff_t p = 0;

+       if (!codec || !codec->driver)
+               return 0;
+
        wordsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
        regsize = codec->driver->reg_word_size * 2;


-Kees

-- 
Kees Cook
Pixel Security
