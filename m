From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] ARM: OMAP: omap_uwire: wait for tx complete
 before	starting the next one
Date: Mon, 12 Jun 2006 20:12:02 +0300
Message-ID: <448DA062.60104@solidboot.com>
References: <1149866270.3240.11.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1149866270.3240.11.camel@mammoth.research.nokia.com>
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
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Imre Deak wrote:

> The TDR register shouldn't be written when the CSRB flag is set. The fix
> solves the problem where one SPI transfer includes multiple 8 or 16 bit
> tx elements and the current transfer can be corrupted by accessing the
> TDR too early.

Applied.

Cheers,
Juha
