From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/10] cpufreq: OMAP: move into drivers, cleanups/fixes
 for v3.2
Date: Tue, 08 Nov 2011 11:48:44 -0800
Message-ID: <4EB9879C.9030904@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com> <4EB1BDFD.2060403@ti.com> <20111102220813.GA931@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20111102220813.GA931@redhat.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Kevin Hilman <khilman@ti.com>, cpufreq@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, tytso@mit.edu
List-Id: linux-omap@vger.kernel.org

On 11/02/2011 03:08 PM, Dave Jones wrote:
> On Wed, Nov 02, 2011 at 03:02:37PM -0700, Kevin Hilman wrote:
>  > Hi Dave,
>  > 
>  > On 09/22/2011 02:07 PM, Kevin Hilman wrote:
>  > > This series moves the OMAP CPUfreq driver into drivers/cpufreq, add
>  > > support for SMP devices (OMAP4+) and includes several cleanups and
>  > > fixes from Nishanth Menon.
>  > > 
>  > > This series applies to v3.1-rc6, and is available here:
>  > > 
>  > >    git://github.com/khilman/linux-omap-pm.git for_3.2/omap-cpufreq
>  > > 
>  > > Kevin
>  > 
>  > Any chance of this making it in for v3.2?
> 
> My kernel.org account being created is blocking on Ted uploading my
> signed gpg key.  If you want to ask Linus to pull directly until I get
> that sorted, feel free.  (Though I understand he has a dislike for github trees)

OK, due to some other changes in v3.2 (including the module.h stuff) I
need to refresh this against v3.2-rc1.

I see the cpufreq tree is now back on kernel.org, so I'll send you and
updated pull request for this series targeted for inclusion in v3.3.

Thanks,

Kevin

