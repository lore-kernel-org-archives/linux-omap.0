From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: OMAP4: Add support for McPDM
Date: Fri, 18 Dec 2009 11:33:38 +0200
Message-ID: <20091218093338.GA31755@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D2@dlee01.ent.ti.com>
	<20091217202821.GA30379@nokia.com>
	<2256F256009DAA4CBE661E9F41EAC84B8BA0AA88@dlee01.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8BA0AA88@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Dec 18, 2009 at 03:23:14AM +0100, ext Candelaria Villareal, Jorge wrote:
>Is this because if two interrupts were set, my approach would
>not recognize it as one of the cases and exit without processing
>the interrupt?

you don't have a break in your switch. your approach would go through 
all irq cases no matter what :-p

>> what ? so even if you don't have a platform_device you register the
>> driver ??
>
>So, it would be better if I had declared a platform_device structure
>in .../arch/arm/plat-omap/devices.c, and register its resources (irq
>and memory base) in there?

IMO yeah. It would look cleaner. But McBSP is the same mess so I don't 
know what the ALSA people will say. Jarkko Nikula probably has some 
ideas as he did most of the OMAP ASoC implementation.

-- 
balbi
