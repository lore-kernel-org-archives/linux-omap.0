From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Audio suspend/resume status on OMAP3 based
 platforms
Date: Wed, 13 Jan 2010 14:22:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7A8D@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
	<201001130910.04292.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201001130910.04292.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> Sent: Wednesday, January 13, 2010 12:40 PM
> To: alsa-devel@alsa-project.org
> Cc: Aggarwal, Anuj; linux-omap@vger.kernel.org
> Subject: Re: [alsa-devel] Audio suspend/resume status on OMAP3 based
> platforms
> 
> On Tuesday 12 January 2010 18:05:15 ext Aggarwal, Anuj wrote:
> > Hi,
> >
> > I want to check the status of suspend/resume functionality when audio
> > subsystem is being used. Specifically, has some one tried the following
> > tests on their omap3 based platforms:
> >
> > a) echo mem > /sys/power/state, when audio playback is running in
> > background
> > b) same command, when audio capture is running in
> > background
> > b) same command, when audio loopback is running in
> > background
> >
> > I am facing some issues with (b) & (c) so wanted to confirm whether
> > someone else has faced similar problem or not.
> 
> As Jarkko pointed out in a separate mail, we should not expect the
> suspend/resume to be working correctly until the context save/restore, and
> the
> clock management is sorted out.
> 
> On the other hand it seams that the problem is in the capture path (b and
> c
> having issues).
> 
> How is the McBSP configured in your setup (master or slave)?
[Aggarwal, Anuj] TWL4030 is master and McBSP is slave.

> I think we might have different issues with suspend/resume when OMAP McBSP
> is
> slave or if it is master.
