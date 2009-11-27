From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume hang
Date: Fri, 27 Nov 2009 13:37:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC33B6@dbde02.ent.ti.com>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
	<4B0D9212.1060805@boundarydevices.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F86@dbde02.ent.ti.com>
	<20091126102230.GB27562@rakim.wolfsonmicro.main>
	<5A47E75E594F054BAF48C5E4FC4B92AB030AAC3291@dbde02.ent.ti.com>
	<20091126151121.GC9351@rakim.wolfsonmicro.main>
	<5A47E75E594F054BAF48C5E4FC4B92AB030AAC329C@dbde02.ent.ti.com>
	<20091126152933.GD9351@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091126152933.GD9351@rakim.wolfsonmicro.main>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>, 'Troy Kisky' <troy.kisky@boundarydevices.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Thursday, November 26, 2009 9:00 PM
> To: Aggarwal, Anuj
> Cc: 'Troy Kisky'; alsa-devel@alsa-project.org; linux-omap@vger.kernel.org;
> Arun KS
> Subject: Re: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume
> hang
> 
> On Thu, Nov 26, 2009 at 08:52:08PM +0530, Aggarwal, Anuj wrote:
> 
> > [Aggarwal, Anuj] I am still surprised how this could be a NFS writeout
> issue
> > as we are seeing a consistent read/write rate of 2Mbps over tftp. When
> dd
> > command is used for read/write to further check NFS performance, 2Mbps
> for write and 4Mbps for read is observed.
> > Does that still mean nfs is the culprit? What could be tweaked in
> audio/network driver to avoid this problem, any suggestions?
> 
> There can also be issues with the way the data gets pushed into NFS
> interacting poorly - it's not just the raw data rate that's in play
> here, it's also things like how often the writes are done and how big
> they are.  Possibly also overhead from interacting with the ethernet
> chip but that's not normally an issue for anything modern.
> 
> The fact that this only happens when NFS is in use seems a fairly clear
> pointer to an interacton there.
[Aggarwal, Anuj] We were able to fine tune NFS and use arecord to capture
large files. But some more problems cropped up when tried to suspend /
resume. Basic playback is working fine wrt suspend/resume. But capture,
either tried independently or with playback, is creating a system wide
hang. I fixed that infinite-loop in resume path but I believe something
else needs cleanup too.
Any pointers? 
> 
> > [Aggarwal, Anuj] Any other utility to try capture which does error
> > recovering too?
> 
> Not for the console off the top of my head, and TBH I don't really know
> how good the error handling is in the various apps.  You could also try
> playing with the buffer size options in arecord.
