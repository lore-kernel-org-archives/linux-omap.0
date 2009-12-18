From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: Re: [PATCH 2/3] ASoC: OMAP4: Add support for McPDM
Date: Fri, 18 Dec 2009 11:01:19 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8BB2A669@dlee01.ent.ti.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D2@dlee01.ent.ti.com>
	<20091217202821.GA30379@nokia.com>
	<2256F256009DAA4CBE661E9F41EAC84B8BA0AA88@dlee01.ent.ti.com>
	<20091218093338.GA31755@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091218093338.GA31755@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> Hi,
> 
> On Fri, Dec 18, 2009 at 03:23:14AM +0100, ext Candelaria 
> Villareal, Jorge wrote:
> >Is this because if two interrupts were set, my approach would
> >not recognize it as one of the cases and exit without processing
> >the interrupt?
> 
> you don't have a break in your switch. your approach would go through 
> all irq cases no matter what :-p

Mmm... But it _does_ have some breaks. Besides, I am still unsure that
if structure should be used here. Code would be duplicated, for example,
DN_IRQ_FULL and DN_IRQ_EMPTY share the same procedure to acknowledge
the request.
