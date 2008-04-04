From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC/PATCH 0/1] ALSA SoC support for OMAP
Date: Fri, 4 Apr 2008 16:31:00 +0300
Message-ID: <20080404163100.6d3090dc.jarkko.nikula@nokia.com>
References: <1207300948-11598-1-git-send-email-jarkko.nikula@nokia.com>
	<20080404124233.GB23571@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080404124233.GB23571@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 4 Apr 2008 13:42:33 +0100
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Apr 04, 2008 at 12:22:27PM +0300, Jarkko Nikula wrote:
> 
> > Here is the second version of ASoC support for OMAP. Now based to
> > dev branch of git://opensource.wolfsonmicro.com/linux-2.6-asoc but
> > applies to linux-omap by modifying Kconfig and Makefile in
> > sound/soc/.
> 
> Looks good from an ASoC point of view, thanks - I've applied the patch
> to the dev branch but won't push it anywhere for the time being.
>
Ok, I'll keep you informed when the include/asm-arm/arch-omap/control.h
is in and my omap-mcbsp.c compiles cleanly.

Currently the missing file it's in Russell's patch queue:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4920/1


Jarkko
