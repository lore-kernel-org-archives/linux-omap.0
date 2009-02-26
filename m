From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Add support for OMAP3 EVM
Date: Thu, 26 Feb 2009 09:18:19 +0200
Message-ID: <20090226091819.bd509ade.jarkko.nikula@nokia.com>
References: <1227591577-23414-1-git-send-email-anuj.aggarwal@ti.com>
	<20081125132120.1d740c04.jarkko.nikula@nokia.com>
	<20081125145257.GD12414@sirena.org.uk>
	<20090225202559.GO4368@mvista.com>
	<20090225202744.GG31637@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090225202744.GG31637@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "George G. Davis" <gdavis@mvista.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, stanley.miao@windriver.com, ext Anuj Aggarwal <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Misael Lopez Cruz <mesak82@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 25 Feb 2009 21:27:44 +0100
ext Mark Brown <broonie@sirena.org.uk> wrote:

> On Wed, Feb 25, 2009 at 03:25:59PM -0500, George G. Davis wrote:
> 
> > Is someone working on updating ASoC drivers for OMAP TWL4030 based
> > boards as recommended above?  Just curious since I already made the
> > mistake of creating my own OMAP3 EVM ASoC driver w/o checking the
> > list first.  : /
> 
> Not to my knowledge.

Stanley Miao started to do some early development on this:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-November/012946.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-November/012995.html

IRCC this work was let to aside to develop since there were some slight
differencies between the boards and also TWL4030 didn't contain all the
features. Stanley, do you remember better?

Probably now there is a better change after tons of generic TWL4030
patches and TWL4030 codec updates from Peter Ujfalusi.


Jarkko
