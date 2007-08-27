From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: RE: [RFC] onenand detect logic
Date: Mon, 27 Aug 2007 16:30:43 +0900
Message-ID: <00f201c7e87c$3245c350$e1ac580a@swcenter.sec.samsung.co.kr>
References: <46CF3FC2.3010203@gmail.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <46CF3FC2.3010203@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Nishanth Menon' <menon.nishanth@gmail.com>, 'Linux OMAP List' <linux-omap-open-source@linux.omap.com>, rohitkc@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

> 
> Hi Folks,
> as a disclaimer, the following discussion is entirely a thought
> experiment ;)
> 
> While discussing with Rohit C on supporting a different onenand on git
> kernel, he enlightened me that the GPMC tracking and detecting onenand
> CS based address is flaky.
> Current Logic (with a highly deserving HACK alert comment) does this:
> for each CS(){
>    if (CONFIG_7 reg  ==0x20000000)
> 	then assume it is onenand.
> }
> 
> Here is a alternative proposal (majority from Rohit):
> 
> for each CS(){
> 	if (configured as a NOR type memory){
> 		write 0x90 to CONFIG_7 0x0 offset /* 0x90 0r 0x98 CFI command will
> ensure that the memory is in non-read state, but in onenand it is a
> readonly location */
> 		read  manu id and device id from onenand regs offsets from CONFIG_7

You should also check the maf id and device id in onenand regs additionally.
Please refer to the onenand_probe() in drivers/mtd/onenand/onenand_base.c
Is it also safe to write 0xF0 (OneNAND Reset) CFI command to NOR?

> 		if matched as that for onenand, select same
> 	}
> }
> Caveat: does not detect 2 onenands..

Why don't you add the more sdp_onenand_data if required for second onenand chip.
I mean if you find the OneNAND at matched CS, continue to find another CS for second onenand chip.

Even though, you assign the wrong CS value, onenand_scan and onenanc_probe will be failed, so don't worry about assigning the wrong
CS.

> 
> Question: Any better way of doing this dynamically and a bit more elegantly?
> 
