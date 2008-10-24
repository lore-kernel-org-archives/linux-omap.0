From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Audio on omap3+twl4030 codec
Date: Fri, 24 Oct 2008 09:12:32 +0300
Message-ID: <20081024091232.4f825c74.jarkko.nikula@nokia.com>
References: <ef0d8a250810220547u1b795313y47f964144591e97d@mail.gmail.com>
	<20081022131036.GG7640@sirena.org.uk>
	<ef0d8a250810220624u7396b496q7b86efa0703e7e15@mail.gmail.com>
	<20081023120451.23b1971e.jarkko.nikula@nokia.com>
	<ef0d8a250810230220p6e766806qfc7cbd33dafcab43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <ef0d8a250810230220p6e766806qfc7cbd33dafcab43@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Arun KS <arunks@mistralsolutions.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 23 Oct 2008 14:50:33 +0530
"ext naveen krishna ch" <naveenkrishna.ch@gmail.com> wrote:

> > So to summarize:
> >
> > - 2.6.26 + backported drivers on OMAP3 EVM -> audio works
> > - 2.6.26 + backported drivers on custom board with NAND boot -> no audio
> > - 2.6.26 + backported drivers on custom board with MMC boot -> audio
> >  works
> > - 2.6.24 (TI SDP release?) on custom board -> audio works
> >
> > And I understood also that bootloader images were the same in all of
> > these cases. Did I get these correctly?
> >
> Yeah till here u got every thing correctly.
> 
Then it looks that different pin muxing is not the reason if the same
bootloader images behave differently when they are booted from NAND vs.
MMC.

I'm bit out of idea what might then cause that audio doesn't play.
Timing issue? Sys.boot pin states affect McBSP muxing or TWL4030, etc?

> > Is the rootfile system the same between these cases? I.e. that same
> > mixer settings like audio volumes etc. are used?
> 
> i Have used the same root file system also that too over nfs all the cases.
> 
Ok. Is it possible you to try with up-to-date linux-omap [1] kernel?
There have been lot of changes regarding OMAP3 and TWL4030 since 2.6.26
so problem might have gone and then it's easier for others trying to
verify problem on other similar boards.


Jarkko

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
or
http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
