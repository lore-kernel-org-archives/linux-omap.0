From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Make dyntick work again
Date: Fri, 12 Oct 2007 13:07:32 -0700
Message-ID: <20071012200732.GF7979@atomide.com>
References: <20071011203240.GL503@atomide.com>
	<002c01c80c74$9f0f5160$e1ac580a@swcenter.sec.samsung.co.kr>
	<470F8913.8070308@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <470F8913.8070308@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com, kmpark@infradead.org
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [071012 07:48]:
> Kyungmin Park wrote:
>> Umm, there's a problem, I can't boot with timer32k.
>> It halts at here.
>
> On OMAP 5912 OSK I get:
>
>> <7>Calibrating delay loop... 1.05 BogoMIPS (lpj=4096)
>> Mount-cache hash table entries: 512
>> <6>CPU: Testing write buffer coherency:
>
> ...
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> NET: Registered protocol family 16
> MUX: initialized M19_1610_CAM_RSTZ
> ...
> MUX: initialized PWL
> OMAP DMA hardware version 1
> DMA capabilities: 000c0000:00000000:01ff:003f:007f
> Initializing OMAP McBSP system
> omap_dsp_init() done
> USB: hmc 16, usb2 alt 0 wires
> i2c_omap i2c_omap.1: bus 1 rev2.2 at 100 kHz
> tps65010: version 2 May 2005
> Time: 32k_counter clocksource has been installed.
> Switched to high resolution mode on CPU 0
> NET: Registered protocol family 2

Sounds like it's working on omap1 then :)

Tony
