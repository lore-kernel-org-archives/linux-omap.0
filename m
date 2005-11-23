From: Tony Lindgren <tony@atomide.com>
Subject: Re: Problem with ALSA in 2.6.14-omap2 on OSK
Date: Wed, 23 Nov 2005 08:45:23 -0800
Message-ID: <20051123164523.GC7547@atomide.com>
References: <520AB2AD990DC04082102F77CA17263801D40597@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <520AB2AD990DC04082102F77CA17263801D40597@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Menon, Nishanth" <x0nishan@ti.com>
Cc: Yves Godin <Yves.Godin@lyrtech.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Menon, Nishanth <x0nishan@ti.com> [051123 08:37]:
> 
> There is further the fix to L/R sync issue as reported by Ajaya Babu in
> a previous mail in this list for the OSS - it might hit the ALSA too if
> the condition is not met properly. 

To me it sounds like Ajaya Babu's fix to stop mcbsp before dma is
enabled probably fixes the remaining problems.

Does anybody have a tested patch for OSS and Alsa for that?

Regards,

Tony
