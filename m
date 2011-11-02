From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/10] cpufreq: OMAP: move into drivers, cleanups/fixes for v3.2
Date: Wed, 02 Nov 2011 16:37:10 -0700
Message-ID: <8762j2jduh.fsf@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
	<4EB1BDFD.2060403@ti.com> <20111102220813.GA931@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20111102220813.GA931@redhat.com> (Dave Jones's message of "Wed,
	2 Nov 2011 18:08:14 -0400")
Sender: cpufreq-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: cpufreq@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, tytso@mit.edu
List-Id: linux-omap@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

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

Can I take that as an Ack from you for this series?

With your ack, we can maybe merge this via the OMAP tree, or the arm-soc
tree (although it's probably too late now for v3.2.)

Kevin
