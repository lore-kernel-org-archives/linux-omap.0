From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
Date: Wed, 29 Sep 2010 17:42:31 +0530
Message-ID: <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
	<4CA1AD2B.8000905@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
	<4CA1BC16.3020702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
	<4CA25841.4090702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arun MURTHY <arun.murthy@stericsson.com>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Lars-Peter Clausen <lars@metafoo.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Bill Gatliff <bgat@billgatliff.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, Marek Vasut <marek.vasut@gmail.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>, Mattias WALLIN <mattias.wallin@stericsson.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, robert.jarzmik@f
List-Id: linux-omap@vger.kernel.org

Hi Arun,

Adding Bill Gatliff (anyway, CC list already crowded)

On Wed, Sep 29, 2010 at 10:19 AM, Arun MURTHY
<arun.murthy@stericsson.com> wrote:
>> Arun MURTHY wrote:
>> >>>> Shouldn't PWM_DEVICES select HAVE_PWM?
>> >>>
>> >>> No not required, the entire concept is to remove HAVE_PWM and use
>> >> PWM_CORE.

There is already nice and clean framework written by Bill for PWM, if
you grep the LKML and linux-embedded mailing list archive then you
will get his patches, and it seems that he had promised to send the
updated version few week back, but not heard from him (may be because
he was travelling as per FB status).

Please evaluate that framework too.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
