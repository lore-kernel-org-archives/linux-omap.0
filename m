From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Mon, 04 Dec 2006 15:34:27 -0800
Message-ID: <1165275267.2064.13.camel@vence.hilman.org>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>
	<456F1B1E.1050305@gmail.com> <1164909003.17665.1.camel@imap.mvista.com>
	<45705464.3070105@gmail.com> <1165029705.2964.9.camel@imap.mvista.com>
	<4571192D.8040807@gmail.com>
	<1165042487.15319.11.camel@imap.mvista.com>
	<457125F5.5090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <457125F5.5090102@gmail.com>
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
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


> Okay. Many thanks for clarifying these tricky dependencies!
> 
> Looks like then nothing is lost, only "waiting". Would be 
> nice if you can keep us updated regarding this.

Just a quick update... sorry to jump into this thread so late, I've been
travelling.

There's been some discussion between myself and RMK about some
clocksource init details.  As soon as that's resolved, he will be ready
to accept clocksource patches for other platforms.

I will review/merge the stuff from Dirk and Dave and resubmit a patch to
RMK based on those updates.

Kevin
