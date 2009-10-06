From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv3 1/7] OMAP4: PMIC: Add support for twl6030
 codec
Date: Tue, 6 Oct 2009 17:35:46 +0100
Message-ID: <20091006163546.GA11062@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90C2F648@dlee04.ent.ti.com>
	<200910061146.05080.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200910061146.05080.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "ext Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 06, 2009 at 11:46:05AM +0300, Peter Ujfalusi wrote:

> How does the twl4030 series would fit with this modification?
> I have also added the twl4030 codec as a child for the twl MFD, but I have not 
> finished the cleanup of the codec fully.

The TWL6030 specific bits all look good but this change ought to go via
the MFD tree (probably as part of the big patch series adding twl6030
support that doesn't look to have been applied yet).  Are people happy
that the interface to the twl6030 won't change as a result of the
twl4030 audio support?  If so then I'll apply the ASoC side now, the
Kconfig dependencies will stop it being built too soon.
