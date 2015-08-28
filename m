From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: hdmi: Reconfigure and restart
 audio when display is enabled
Date: Fri, 28 Aug 2015 16:46:49 +0300
Message-ID: <55E06649.5070701@ti.com>
References: <1440764660-10417-1-git-send-email-jsarha@ti.com>
 <55E05C60.2090400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <55E05C60.2090400@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com
List-Id: linux-omap@vger.kernel.org

On 08/28/15 16:04, Tomi Valkeinen wrote:
...
> The question is (which was my point in the earlier mail), we already
> have mutex, so why a new spinlock?
>
> I think the answer is that audio start/stop (anything else?) are called
> in atomic context, so mutex cannot be used.
>

Yes, that is correct.

> Also (not exactly related to this patch), if the audio callbacks must be
> atomic, could we use a workqueue to run the audio start/stop work in
> non-atomic context? Protecting the whole hdmi state with a single mutex
> would be much nicer.

The reason why the audio start and stop are done in atomic context is 
for audio synchronization to other audio devices or video stream to be 
more accurate.

I guess in theory a work queue could be used to serialize the audio 
commands, but that would ruin the whole point of why the start and stop 
commands are atomic in the first place.

Cheers,
Jyri
