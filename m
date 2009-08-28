From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Audio capture not working with AIC23/McBSP1 on
	OMAP3517
Date: Fri, 28 Aug 2009 09:55:01 +0300
Message-ID: <200908280955.01382.peter.ujfalusi@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0309E9DB24@dbde02.ent.ti.com>
	<20090827141253.9f772f31.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090827141253.9f772f31.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 27 August 2009 14:12:53 ext Jarkko Nikula wrote:
> On Thu, 27 Aug 2009 15:07:32 +0530
>
> "Aggarwal, Anuj" <anuj.aggarwal@ti.com> wrote:
> > Thanks Jarkko, the patch works for me.
>
> This is nice to hear.
>
> Can you, Peter or who has access to 2420 and 2430 TRMs to verify is the
> DEVCONF0 bits 3 and 4 selecting there also the McBSP1 CLKR and FSR
> sources like my patch is now assuming for all OMAP2-3.

On OMAP2:
DEVCONF:3 MCBSP1_CLKR
DEVCONF:4 MCBSP1_FSR

So it is correct for  both OMAP2 and OMAP3.

-- =

P=E9ter
