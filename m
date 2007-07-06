From: Kevin Hilman <khilman@mvista.com>
Subject: Re: 2430 FB driver issues
Date: Fri, 06 Jul 2007 12:21:22 -0700
Message-ID: <468E9632.1080205@mvista.com>
References: <782515bb0707031706l32231cbbv34a67572068b835f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <782515bb0707031706l32231cbbv34a67572068b835f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

nishanth menon wrote:
> Hi All,
> 
> On compiling the kernel for 2430sdp with defconfig, I see the
> following error messages on shell:
> Power Management for OMAP2 initializing
> PRCM revision 1.0
> omapfb omapfb: irq error status 40e2
> omapfb omapfb: irq error status 0040
> omapfb omapfb: irq error status 4022
> omapfb omapfb: irq error status 4000
> <snip>
> omapfb omapfb: irq error status 4000
> <snip>
> I believe this is from drivers/video/omap/dispc.c:876. I have tried
> two versions of uboot: one with PRCM 5a and the other with PRCM2.
> neither worked. The kernel version is the latest pull from omap-git
> from source.mvista.com.
> 
> On disabling framebuffer, it boots up fine.

FWIW, I have the same errors, but have not debugged it further.

Kevin
