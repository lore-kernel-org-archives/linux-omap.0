From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ams-delta: fix card initalization
 failure
Date: Fri, 31 Aug 2012 14:31:04 -0700
Message-ID: <20120831213103.GC5495@opensource.wolfsonmicro.com>
References: <1346102910-8610-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <3048168.EXxi4fR4e7@acer>
 <20120828181338.GB8796@opensource.wolfsonmicro.com>
 <1809544.cvZPIRmRr5@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1809544.cvZPIRmRr5@acer>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 29, 2012 at 07:04:48AM +0200, Janusz Krzysztofik wrote:
> On Tue, 28 Aug 2012 11:13:39 Mark Brown wrote:

> > The above looks like you already have a platform driver?  All I'm
> > suggesting is changing the above to use platform rather than driver
> > data.

> The ams-delta asoc driver doesn't use snd_soc_register_card() so far, 
> but relays solely on soc_probe() doing this for it, which in turn 
> expects to find a snc_soc_card structure in drvdata. How is it supposed 
> to find that structure if I pass it over platform data instead? Am I 
> missing something?

s/drvdata/platdata/ in the code.  If you can't do this then just
referencing the data directly in the code would be better than this
bodge, it'd be much less fragile.
