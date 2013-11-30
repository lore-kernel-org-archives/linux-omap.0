From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [RFC/PATCH] NAND bus-width detection extreme makeover
Date: Sat, 30 Nov 2013 14:19:40 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA50432@DBDE04.ent.ti.com>
References: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>,
 <20131130083537.GB29397@norris.computersforpeace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131130083537.GB29397@norris.computersforpeace.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "shc_work@mail.ru" <shc_work@mail.ru>, Artem Bityutskiy <dedekind1@gmail.com>, Tony Lindgren <tony@atomide.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Brian, Ezequiel,

Sorry Im bit confused on below, so few queries ..

>From: Brian Norris [computersforpeace@gmail.com]
>So I think the problem may need to be divided into 2 parts:
>
>1) How do we best handle ONFI transactions, so that they are always
>  performed on the lower 8 bits of the bus **regardless of actual
>   buswidth**? (I think Uwe's patch + my response in [1] might solve
>   this.)
>
> 2) Can/should we relax the old restrictions where drivers have to
>    configure the buswidth correctly before running nand_scan_ident(),
>    in the spirit of NAND_BUSWIDTH_AUTO? And why do we need this
>    flexibility?
>
>I think problem (1) is solvable independently of (2). So we don't
>inherently *need* BUSWIDTH_AUTO just to support ONFI correctly; we can
>just enforce that we ignore the upper 8 bits.
>
>Now, what do we have NAND_BUSWIDTH_AUTO for, anyway? It seems like its
>best use case is for a driver that (a) knows it might encounter either
>x8 or x16 flash chips and (b) is equipped to handle this change at
>runtime (e.g., it only needs to re-assign some call-backs after
>nand_scan_ident()). This means, for one, that it should have at least
>all 16 data lines connected.
>
>However, not all hardware/drivers fit (a) and (b). For such systems, we
>probably want to just indicate the expected buswidth and error out
>automatically if we detect this is incorrect.
>
Sorry I'm bit confused here.. Where do you want to error out ?
(a) In nand_base.c (generic driver) OR
(b) you want the controller driver (callee of nand_scan_ident) to handle
the bus-width mismatch on its own.

I prefer (b), which is the basis of my first proposal patch.
In my opinion following sequence should be followed by each controller driver
during probe.
Step-1: assign basic callbacks and parameters which are required for
     basic NAND device I/O (like chip->ctrl, chip->delay, etc)
Step-2: call nand_scan_ident()
      nand_scan_ident() would populate detect NAND device parameter by
     - reading ONFI parameters in x8 bit mode (ignoring pre-configurations)
     - look-up from nand_flash_id[]
      And populate chip->options, mtd->writesize, etc...
Step-3: On return from nand_scan_ident, each controller driver should
     check whether (chip_options & NAND_BUSWIDTH_16) as set by 
     nand_scan_ident() matches its controller & board configurations or
     not. Based on which it can take corrective action or error out.

If we follow above sequence then 
(1) NAND_BUSWIDTH_AUTO becomes implicit. And controller driver
   does not need to set any such flags before calling nand_scan_ident().
(2) Currently, we are error-out inside nand_base.c when 
   (busw != chip->options & BUS_WIDTH_16).
   Now this would be handled by individual controller drivers, as they
   know their hardware best.
  (If you remember, this was the reason of omap2,c calling
   nand_scan_ident() twice. If instead of failing the first call to 
   nand_scan_ident  would have just returned with *corrected* bus-width,
   then omap2,c could have handled that situation by re-configuring
   its controller).



>So I think we still want to support the following three configurations:
>
>  !NAND_BUSWIDTH_16 && !NAND_BUSWIDTH_AUTO: device must use 8-bit
>  buswidth
>
>  NAND_BUSWIDTH_16 && !NAND_BUSWIDTH_AUTO: device must use 16-bit
>  buswidth
>
>  NAND_BUSWIDTH_AUTO: can support either buswidth (auto-detectable)
>
>But I think these selections should only be restricted by hardware
>limitations (lack of I/O pin connections, inflexible controller) and not
>enforced because of software limitations in handling ONFI. This brings
>be back to problem (1), where I think we need resolve it along the lines
>of Uwe's + my patch (see [1]), not by forcing NAND_BUSWIDTH_AUTO on all
>drivers.
>
> That's exactly what this patch is doing.

Sorry, I'll re-review Uwe's + ur patch.
But do you agree on following:
(1) somehow we need to do away with NAND_BUSWIDTH_AUTO *macro*.
And instead make its functionality, built-in the nand_base.c driver ?

(2) And nand-bus-width DT binding will still be required for defining controller
and board level description ... 
Is my understanding correct ?


with regards, pekon
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
