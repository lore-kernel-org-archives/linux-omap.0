From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] [PATCH 3/3 v2] ASoC: add support for Amstrad
 E3 (Delta) machine
Date: Fri, 31 Jul 2009 22:38:12 +0100
Message-ID: <20090731213812.GB6335@sirena.org.uk>
References: <200907291318.54897.jkrzyszt@tis.icnet.pl>
	<200907301112.53525.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200907301112.53525.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 30, 2009 at 11:12:52AM +0200, Janusz Krzysztofik wrote:

> I am aware that I have forgot to correct one checkpatch indicated issue. Sorry
> for this.  If there are no other changes to the locking bits suggested, the
> issue will be corrected this way:

I've applied this (squashed into the original patch), together with your
other two ASoC patches and the TTY patch.  If you want to change the
name of the line discipline please send a followup patch before the next
merge window.

Thanks for your work on this, and on getting the OMAP1 support working.
