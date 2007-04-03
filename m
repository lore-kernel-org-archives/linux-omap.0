From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] SD working on OMAP platforms
Date: Tue, 03 Apr 2007 15:12:09 +0200
Message-ID: <461252A9.1030402@drzeus.cx>
References: <460D72E0.7050206@indt.org.br> <460DFCB9.4070102@drzeus.cx>
	<460EDBAC.9050301@indt.org.br> <4611DA08.7020102@drzeus.cx>
	<20070403135804.GA10528@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070403135804.GA10528@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: omap-linux <linux-omap-open-source@linux.omap.com>, ext Philip Langdale <philipl@overt.org>
List-Id: linux-omap@vger.kernel.org

tony@atomide.com wrote:
> Always ignoring CERR seems totally unsafe to me. Also, it would be
> best to use the existing #define OMAP_MMC_STAT_CARD_ERR.
>
> To recap, CERR needs to be ignored only with SD cards, and only
> with CMD3.
>   

No, CERR needs to be ignored whenever we do not want the controller to
parse response bits for us (i.e. always). It parses them incorrectly
when the reponse type isn't a standard/classic R1 and we might even
_want_ to see some bits indicating error there. As such, respecting CERR
is broken and the should be ignored at every turn.

> Pierre, what do you have as an alternative for working around hardware
> bugs without using opcodes? AFAIK opcodes are needed to work around
> some hardware issues, such as this.
>
>   

Looking at protocol stuff is always the last resort. In this case it
isn't necessary, but it might be in some cases. Really, the only time we
need to look at the opcode is when the controller does too and we know
it does something stupid when it sees some values. The wbsd driver has a
fix based on this principle. It isn't pretty and it means that
controller cannot use some cards, but it was the only way to solve the
issue (and believe me, I tried long and hard to come up with another way).

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
