From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Convert tlv320aic3x to a new-style
	i2c driver
Date: Mon, 1 Sep 2008 14:27:26 +0200
Message-ID: <20080901142726.2f7ebf2d@hyperion.delvare>
References: <20080901112131.08cdbb59@hyperion.delvare>
	<20080901143114.e98543a1.jarkko.nikula@nokia.com>
	<20080901113508.GC2722@sirena.org.uk>
	<20080901152038.5987df8d.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080901152038.5987df8d.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, Vladimir Barinov <vbarinov@ru.mvista.com>, ext Mark Brown <broonie@sirena.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 1 Sep 2008 15:20:38 +0300, Jarkko Nikula wrote:
> On Mon, 1 Sep 2008 12:35:09 +0100
> "ext Mark Brown" <broonie@sirena.org.uk> wrote:
> 
> > On Mon, Sep 01, 2008 at 02:31:14PM +0300, Jarkko Nikula wrote:
> > > "ext Jean Delvare" <khali@linux-fr.org> wrote:
> > 
> > > Thanks. In N810 it's connected into second i2c bus so this makes it
> > > working
> > 
> > >  +	.i2c_bus = 2,
> > 
> > Should that be 1?  Normally the buses are numbered from zero...
> >
> Good question. By some historical reason we are registering busses
> starting from number one in OMAP and short hack below (in linux-omap
> tree) trying to register them starting from zero didn't work out.
> 
> But yeah, that's another issue in linux-omap and Jean's patch is
> working on N810 if changing this i2c_bus to 2.

OK, thanks Jarkko for testing and reporting. I'll make it 2 for the
time being so that things keep working, and it can be changed later if
needed.

-- 
Jean Delvare
