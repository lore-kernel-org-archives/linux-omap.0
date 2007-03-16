From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: TSC2101/2102
Date: Fri, 16 Mar 2007 09:28:24 +0900
Message-ID: <004901c76762$06d66bc0$c7a3580a@swcenter.sec.samsung.co.kr>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com> <20070314170952.GB10230@bitbox.mine.nu>
	<002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070315102325.GA4555@bitbox.mine.nu>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20070315102325.GA4555@bitbox.mine.nu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Imre Deak' <imre.deak@solidboot.com>
Cc: 'Linux OMAP ML' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi, 

> 
> I needed only the basic register read / write interface to access the
> TSC2101 GPIO lines. The TS part you wrote is still needed, 
> it's init function being called from the tsc2101.c probe, as 
> it's done in tsc2301-core.c.
> 
> > The current code only supports 16-bit tsc2101 for OMAP1.
> > We have to consider OMAP2 tsc2101 for H4 and apollon.
> 
> Is the 32-bit interface some alternate interface 
> configuration for the chip?

No. it's only needed in SPI protocol.

I don't know it's possible to use 16-bit mode in OMAP2. but most driver
which uses tsc2101 on OMAP2 uses 32-bit access.

Thank you,
Kyungmin Park
