From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Audio capture not working with AIC23/McBSP1 on
 OMAP3517
Date: Thu, 27 Aug 2009 14:12:53 +0300
Message-ID: <20090827141253.9f772f31.jhnikula@gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com>
	<20090826130356.GB29299@sirena.org.uk>
	<20090826164239.a574d4ab.jhnikula@gmail.com>
	<20090826180141.37dca666.jhnikula@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0309E9DB24@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9DB24@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 Aug 2009 15:07:32 +0530
"Aggarwal, Anuj" <anuj.aggarwal@ti.com> wrote:

> Thanks Jarkko, the patch works for me.
> 
This is nice to hear.

Can you, Peter or who has access to 2420 and 2430 TRMs to verify is the
DEVCONF0 bits 3 and 4 selecting there also the McBSP1 CLKR and FSR
sources like my patch is now assuming for all OMAP2-3.


-- 
Jarkko
