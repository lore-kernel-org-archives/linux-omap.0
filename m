From: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: OMAP: Update OMAP keypad driver
Date: Mon, 13 Feb 2006 10:56:51 +0200
Message-ID: <1139821011.5208.11.camel@two.research.nokia.com>
References: <20060213074100.42397.qmail@web32910.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060213074100.42397.qmail@web32910.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Komal,

On Sun, 2006-02-12 at 23:41 -0800, ext Komal Shah wrote:

> - if (cpu_is_omap24xx() && omap_has_menelaus()) {
> - row_gpios[5] = 0;
> - col_gpios[2] = 15;
> - col_gpios[6] = 18;
> - }
> -
> 
> May I know, where you have moved this? As discussed earlier here, it
> should be in the board specific file, but I don't find it there. _or_
> are you planning this in the next patch.?

I was the one who removed that, since it breaks keypad support on all
OMAP24xx boards (except H4, I presume) that have Menelaus on them.  And
there are quite a few of those.

Please submit a patch that moves the stuff above into board-h4.c.

Cheers,
Juha
