From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 0/3] Few patches to recent OMAP McBSP and
	ASoC changes
Date: Mon, 24 Aug 2009 16:17:45 +0300
Message-ID: <20090824131745.GB32701@esdhcp037198.research.nokia.com>
References: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Sun, Aug 23, 2009 at 11:24:24AM +0200, Jarkko Nikula wrote:
> Hi
> 
> I would like to add these tree patches to recent set:
> 
> [PATCHv5 00/20] OMAP ASoC changes in DMA utilization
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020619.html
> 
> These are actually independent patches but probably easier to handle as with
> the set above since some of the patches are touching both ASoC and OMAP
> subsystems. First patch is the most important since it changes the user space
> API for McBSP DMA operating mode selection. It would be more difficult to
> change it later if software starts to use current numeric value based
> operating mode selection in sysfs files.


For the other two changes (patches 02 and 03) I'm giving my ack here.
Tested them and after running several playback/capture tasks, looks like the
streaming was ok.

And for the channel swapping issue, I think the thing remains the same.
If I increase the max threshold to something closer to its maximum (0x500)
than, channels swap quite easily. Just:

# aplay -c2 -fdat -I /dev/urandom /dev/zero

But that wouldn't block your two patch Jarkko. I liked this merge.
Code looks cleaner now.

> 
> 
> -- 
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo Valentin
