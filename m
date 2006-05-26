From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix GPIO IRQ mask handling [was Re: [RFC]
	ARM: OMAP: handle lazy IRQ disable properly]
Date: Fri, 26 May 2006 15:59:07 -0700
Message-ID: <20060526225907.GL4132@atomide.com>
References: <1144008267.8058.58.camel@bitbox.mine.nu>
	<1147882410.22799.5.camel@orphique>
	<446B67EA.7030107@nokia.com> <446B6C65.7010504@nokia.com>
	<1148471720.28420.32.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1148471720.28420.32.camel@mammoth.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: michl@2n.cz, linux-omap <linux-omap-open-source@linux.omap.com>, "Yrjola Juha (Nokia-M/Helsinki)" <Juha.Yrjola@nokia.com>
List-Id: linux-omap@vger.kernel.org

* Imre Deak <imre.deak@nokia.com> [060524 04:55]:
> [ Ignore the two previous ones they were both bogus:( I tested this on
> OMAP1510 innovator ]
> 
> ARM: OMAP: fix GPIO IRQ mask handling
> 
> The GPIO IRQ mask was retrieved incorrectly in cases where we have a mask
> register instead of an enable register. Also we should only return the
> valid bits depending on the bank size.
> 
> This fixes a bug on 1510/1610 based OMAPs where GPIO IRQs are not
> delivered.

Great, hopefully this will finally fix the last GPIO irq issues!
Pushing today.

Tony
