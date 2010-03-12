From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/5] FIFO caused playback delay	(latency)
	handling in soc/omap
Date: Fri, 12 Mar 2010 11:12:36 +0000
Message-ID: <20100312111235.GA23739@sirena.org.uk>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100311222655.GP2900@atomide.com>
	<186E584F-F553-44F0-A49D-361BB76E0EE4@opensource.wolfsonmicro.com>
	<201003120818.30290.peter.ujfalusi@nokia.com>
	<20100312103050.b83db5c4.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20100312103050.b83db5c4.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 12, 2010 at 10:30:50AM +0200, Jarkko Nikula wrote:
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > All in all, I think the usage of the BUFFSTAT register is a good compromise for 
> > all cases, and it is needed for the cases, where the codec also have buffer of 
> > it's own.

> And one point is that the BUFFSTAT use doesn't make things worse than
> currently.  Now the application doesn't have any information about the
> HW buffer caused audio latencies so reporting them makes the things
> better than currently.

OK, that's what I thought - just wanted to confirm.  I've applied both
patches now.
