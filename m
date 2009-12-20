From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: OMAP4: Add support for McPDM
Date: Sun, 20 Dec 2009 20:58:18 +0200
Message-ID: <20091220185818.GA6631@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D2@dlee01.ent.ti.com>
	<20091217202821.GA30379@nokia.com>
	<2256F256009DAA4CBE661E9F41EAC84B8BA0AA88@dlee01.ent.ti.com>
	<20091218093338.GA31755@nokia.com>
	<2256F256009DAA4CBE661E9F41EAC84B8BB2A669@dlee01.ent.ti.com>
	<20091220141941.GA6089@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091220141941.GA6089@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ext Candelaria Villareal, Jorge" <x0107209@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Dec 20, 2009 at 03:19:41PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>Hi,
>
>On Fri, Dec 18, 2009 at 06:01:19PM +0100, ext Candelaria Villareal, Jorge wrote:
>>Mmm... But it _does_ have some breaks. Besides, I am still unsure that
>>if structure should be used here. Code would be duplicated, for example,
>>DN_IRQ_FULL and DN_IRQ_EMPTY share the same procedure to acknowledge
>>the request.
>
>quoting your switch for irq here:
>
>> +       switch (irq_status) {
>> +       case DN_IRQ_FULL:
>> +       case DN_IRQ_EMTPY:
>> +               dev_err(mcpdm_irq->dev, "DN FIFO error %x\n", irq_status);
>> +               omap_mcpdm_reset(MCPDM_DOWNLINK, 1);
>> +               omap_mcpdm_set_downlink(mcpdm_irq->downlink);
>> +               omap_mcpdm_reset(MCPDM_DOWNLINK, 0);
>> +               break;
>> +       case DN_IRQ:
>> +               dev_dbg(mcpdm_irq->dev, "DN write request\n");
>> +               break;
>> +       case UP_IRQ_FULL:
>> +       case UP_IRQ_EMPTY:
>> +               dev_err(mcpdm_irq->dev, "UP FIFO error %x\n", irq_status);
>> +               omap_mcpdm_reset(MCPDM_UPLINK, 1);
>> +               omap_mcpdm_set_uplink(mcpdm_irq->uplink);
>> +               omap_mcpdm_reset(MCPDM_UPLINK, 0);
>> +               break;
>> +       case UP_IRQ:
>> +               dev_dbg(mcpdm_irq->dev, "UP write request\n");
>> +               break;
>> +       }
>
>what happens if you have both DN_IRQ_FULL and DN_IRQ_EMPTY at the same
>time ?


probably DN_IRQ_FULL and DN_IRQ_EMPTY won't happen at the same time, but 
maybe DN_IRQ_FULL and DN_IRQ. The point is that if two bits are enabled 
in the irq status register, the switch won't work.

-- 
balbi
