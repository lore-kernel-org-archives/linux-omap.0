From: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] Convert drivers to new irq trigger modes
Date: Mon, 13 Feb 2006 11:17:36 +0200
Message-ID: <1139822256.5208.20.camel@two.research.nokia.com>
References: <43E8D9CA.8000204@gmail.com>
	<20060208051451.GA22845@two.research.nokia.com>
	<43EA4234.4070807@gmail.com>
	<20060209062536.GC11799@two.research.nokia.com>
	<43EF5790.3020509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43EF5790.3020509@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sun, 2006-02-12 at 16:43 +0100, ext Dirk Behme wrote:

> > SA_SAMPLE_RANDOM doesn't have anything to do with triggering.  It's used to
> > indicate whether an IRQ source can be used to feed the kernel entropy pools. 
> > If the IRQ in question cannot be considered to happen at random intervals,
> > the flag must not be set.
> 
> Okay. What's about this?
> 
> Add ORing the  SA_TRIGGER_FALLING and don't use
> SA_SAMPLE_RANDOM as default value in ts_inn1510.c.

Exactly the other way around. =) The touchscreen IRQ practically occurs
randomly, so there the flag should be set.  For the power chips, the IRQ
arrival can sort of be predicted, so the default value should be zero.

Cheers,
Juha
