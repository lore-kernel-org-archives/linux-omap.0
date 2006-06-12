From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] ARM: OMAP: Add minimal OMAP2430 support V2
Date: Mon, 12 Jun 2006 21:16:06 +0300
Message-ID: <448DAF66.5040702@solidboot.com>
References: <1150129503.24758.263622621@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1150129503.24758.263622621@webmail.messagingengine.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Komal,

Komal Shah wrote:

> Attached patch is re-worked with PRCM and SDRC changes
> to prcm/sdrc_read/write_reg fashion. I have tested it on OMAP2420
> H4 EVM. I still need to test it on SDP2430.

Could you separate the cleanup of the PRCM and SDRC from the OMAP2430 
support into two (or more) different patches?

Cheers,
Juha
