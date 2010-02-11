From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv3 3/4] Add ASoC support for DevKit8000
Date: Thu, 11 Feb 2010 10:49:48 +0000
Message-ID: <1265885388.3179.8.camel@odin>
References: <1265829784-19224-1-git-send-email-swirl@gmx.li>
	<1265882112.3179.1.camel@odin>
	<20100211124022.ec6573dc.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100211124022.ec6573dc.jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, weber@corscience.de, Thomas Weber <swirl@gmx.li>, Tomi.Valkeinen@nokia.com, tony@atomride.com, felipe.balbi@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-02-11 at 12:40 +0200, Jarkko Nikula wrote:
> On Thu, 11 Feb 2010 09:55:12 +0000
> Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> 
> > Since this shares the same mach driver as beagle you should share the
> > Kconfig option too (like the Overo).
> > 
> Heh, I had just an opposite view :-)
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025124.html
> 
> 

Heh, didn't see that. ;)

I do agree this makes good sense for boards that are very similar and
have different audio options/config, but in this case the ASoC mach
drivers are identical (atm). Imo it just makes more sense to keep the
one Kconfig.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
