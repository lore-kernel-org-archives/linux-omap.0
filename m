From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 27 May 2010 10:04:53 +0200
Message-ID: <20100527100453.1d55c87e@schatten.dmk.lab>
References: <CEE6BB42CAD6E947908279175AF8470A025A7D7DC4@EXDCVYMBSTM006.EQ1STM.local>
	<Pine.LNX.4.44L0.1005261156130.1328-100000@iolanthe.rowland.org>
	<CEE6BB42CAD6E947908279175AF8470A025A8206ED@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025A8206ED@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010 09:46:51 +0200
Linus WALLEIJ <linus.walleij@stericsson.com> wrote:


> If yes then OK, it's not totally elegant but if that is
> where we have to go, I can live with it. There will likely
> be people who implement for only one or the other semantic
> behaviour, but we have worse things to cope with already.

Alan Cox suggested, that this kind of explicit requirement definition
might be necessary for all drivers anyway in the long run.

That way, the semantic differences between those two cases would
vanish. 

Cheers,
Flo
