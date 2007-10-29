From: Kevin Hilman <khilman@mvista.com>
Subject: Re: oprofile on OMAP2: ARM11 PMU interrupts?
Date: Mon, 29 Oct 2007 09:45:20 -0700
Message-ID: <47260E20.3040107@mvista.com>
References: <472225F6.9070502@mvista.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742902530AF3@dlee13.ent.ti.com>
	<003701c819c5$765e6a90$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <003701c819c5$765e6a90$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kyungmin.park@samsung.com
Cc: 'Linux OMAP' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Kyungmin Park wrote:
> FYI: Refer to the following article
> 
> http://blog.gustavobarbieri.com.br/2007/05/22/oprofile-and-maemo-n800/
> 
> I saw this article a month ago, but I also don't test it.
> It needs the Oprofile modification.
> 

Yeah, I've seen various patches to the oprofile tools floating around
for ARMv6 support, but from what I can see so far, these are incoporated
into oprofile 0.9.3, which I still haven't got working on my 2430.

Kevin
