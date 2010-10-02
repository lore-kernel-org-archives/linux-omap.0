From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v3] SoC Camera: add driver for OMAP1 camera
	interface
Date: Sat, 2 Oct 2010 08:07:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1010020803200.14599@axis700.grange>
References: <201009301335.51643.jkrzyszt@tis.icnet.pl>
Reply-To: Discussion of the Amstrad E3 emailer hardware/software
	<e3-hacking@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e3-hacking-bounces@earth.li>
In-Reply-To: <201009301335.51643.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://www.earth.li/cgi-bin/mailman/options/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=unsubscribe>
List-Archive: <http://www.earth.li/pipermail/e3-hacking>
List-Post: <mailto:e3-hacking@earth.li>
List-Help: <mailto:e3-hacking-request@earth.li?subject=help>
List-Subscribe: <http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=subscribe>
Sender: e3-hacking-bounces@earth.li
Errors-To: e3-hacking-bounces@earth.li
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Same with this one - let's take it as is and address a couple of clean-ups 
later.

On Thu, 30 Sep 2010, Janusz Krzysztofik wrote:

> +static void omap1_videobuf_queue(struct videobuf_queue *vq,
> +						struct videobuf_buffer *vb)
> +{
> +	struct soc_camera_device *icd = vq->priv_data;
> +	struct soc_camera_host *ici = to_soc_camera_host(icd->dev.parent);
> +	struct omap1_cam_dev *pcdev = ici->priv;
> +	struct omap1_cam_buf *buf;
> +	u32 mode;
> +
> +	list_add_tail(&vb->queue, &pcdev->capture);
> +	vb->state = VIDEOBUF_QUEUED;
> +
> +	if (pcdev->active) {
> +		/*
> +		 * Capture in progress, so don't touch pcdev->ready even if
> +		 * empty. Since the transfer of the DMA programming register set
> +		 * content to the DMA working register set is done automatically
> +		 * by the DMA hardware, this can pretty well happen while we
> +		 * are keeping the lock here. Levae fetching it from the queue

"Leave"

> +		 * to be done when a next DMA interrupt occures instead.
> +		 */
> +		return;
> +	}

superfluous braces

> +static void videobuf_done(struct omap1_cam_dev *pcdev,
> +		enum videobuf_state result)
> +{
> +	struct omap1_cam_buf *buf = pcdev->active;
> +	struct videobuf_buffer *vb;
> +	struct device *dev = pcdev->icd->dev.parent;
> +
> +	if (WARN_ON(!buf)) {
> +		suspend_capture(pcdev);
> +		disable_capture(pcdev);
> +		return;
> +	}
> +
> +	if (result == VIDEOBUF_ERROR)
> +		suspend_capture(pcdev);
> +
> +	vb = &buf->vb;
> +	if (waitqueue_active(&vb->done)) {
> +		if (!pcdev->ready && result != VIDEOBUF_ERROR) {
> +			/*
> +			 * No next buffer has been entered into the DMA
> +			 * programming register set on time (could be done only
> +			 * while the previous DMA interurpt was processed, not
> +			 * later), so the last DMA block, be it a whole buffer
> +			 * if in CONTIG or its last sgbuf if in SG mode, is
> +			 * about to be reused by the just autoreinitialized DMA
> +			 * engine, and overwritten with next frame data. Best we
> +			 * can do is stopping the capture as soon as possible,
> +			 * hopefully before the next frame start.
> +			 */
> +			suspend_capture(pcdev);
> +		}

superfluous braces

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
