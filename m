From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 10/15] ASoC: omap-mcbsp: use
 permission-specific DEVICE_ATTR variants
Date: Sun, 30 Oct 2016 12:58:51 +0200
Message-ID: <20161030125851.bd0e74854c52ce7d4ab3570c@bitmer.com>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
 <1477769829-22230-11-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1477769829-22230-11-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Sat, 29 Oct 2016 21:37:04 +0200
Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> Use DEVICE_ATTR_RW for read-write attributes.  This simplifies the
> source code, improves readbility, and reduces the chance of
> inconsistencies.
> 
...
> 
> - DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
> + DEVICE_ATTR_RW(x);

I'm not so sure does this improve readability. 644 is pretty obvious but for DEVICE_ATTR_RW() one has to dive into include/linux/device.h and include/linux/sysfs.h to see for what users it grants the write access.

-- 
Jarkko
