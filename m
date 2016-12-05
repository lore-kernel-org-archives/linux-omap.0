From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Mon, 5 Dec 2016 07:30:29 -0800
Message-ID: <20161205153028.GK4705@atomide.com>
References: <1480555145-8300-1-git-send-email-matt@ranostay.consulting>
 <e8e9a552-14d9-15eb-bf9a-48fdc79965e2@ti.com>
 <CAJ_EiSToYsRyxKF47WEZjcr5Jb4LC-3x310=JNdA7vSrYNoAdw@mail.gmail.com>
 <730ed491-ebe7-86c1-b131-5d9441ae2b7c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <730ed491-ebe7-86c1-b131-5d9441ae2b7c@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Linux OMAP List <linux-omap@vger.kernel.org>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [161205 01:35]:
> On 12/04/2016 03:33 AM, Matt Ranostay wrote:
> >>> + *
> >>> + * Also setting of the QoS latency for the FIFO which varies upon the buffer
> >>> + * size. Approximately 2.3 milliseconds per FIFO location.
> >>>   */
> >>>  void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
> >>>  {
> >>>       int enable_srg = 0;
> >>> +     int latency = mcbsp->pdata->buffer_size * 23;
> >>
> >> I think this is not correct.
> >> The McBSP FIFO time depends on the sample rate and on the number of
> >> channels the audio is using. With 8KHz mono you have 12 times more time
> >> per FIFO element compared to 48KHz stereo.
> >>
> >> As it has been discussed with Tony we should calculate the QoS latency
> >> in hw_params:
> >>
> > 
> > Ok yeah missed that part of the thread but it makes sense. Just one
> > question should the latency value be only based on the TX FIFO
> > threshold? I assume capture and transmit have two different settings.
> 
> Yes, I believe we should apply the lowest QoS when both direction is
> active. If the second stream needs lower QoS, we should switch to use
> that, if it would need longer, we should keep the QoS placed for the
> first stream.

Sounds good to me.

Regards,

Tony
