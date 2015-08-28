From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: hdmi: Reconfigure and restart
 audio when display is enabled
Date: Fri, 28 Aug 2015 15:57:40 +0300
Message-ID: <55E05AC4.1030206@ti.com>
References: <1440764660-10417-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1440764660-10417-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, tomi.valkeinen@ti.com
List-Id: linux-omap@vger.kernel.org

On 08/28/15 15:24, Jyri Sarha wrote:
> @@ -565,9 +594,14 @@ out:
>   static int hdmi_audio_shutdown(struct device *dev)
>   {
>   	struct omap_hdmi *hd = dev_get_drvdata(dev);
> +	unsigned long flags;
>
>   	mutex_lock(&hd->lock);
>   	hd->audio_abort_cb = NULL;
> +	hd->audio_configured = false;
> +	spin_lock_irqsave(&hd->audio_playing_lock, flags);
> +	hd->audio_playing = false;
> +	spin_unlock_irqrestore(&hd->audio_playing_lock, flags);
>

BTW, This extra locking (and the corresponding change in hdmi5.c) should 
not be needed. But it does not harm either. I'll fix that, but I'll wait 
first if there is anything else fix.

Best regards,
Jyri
