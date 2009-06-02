From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 2 Jun 2009 10:37:28 +0100
Message-ID: <20090602093728.GB19390@rakim.wolfsonmicro.main>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090527104711.GA1970@sirena.org.uk>
	<200906020925.58675.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200906020925.58675.jkrzyszt@tis.icnet.pl>
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
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 02, 2009 at 09:24:39AM +0200, Janusz Krzysztofik wrote:

> I have choosen to register the codec device with 
> platform_device_register_simple("cx20442-codec", ...) invoked form asoc 
> machine driver, is this ok?

Normally the platform device would be registered by the machine file
under arch/arm but either works.
