From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 0/7
Date: Tue, 21 Feb 2006 00:35:14 +0200
Message-ID: <43FA4422.2010305@cc.jyu.fi>
References: <20060220205807.86025.qmail@web32906.mail.mud.yahoo.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060220205807.86025.qmail@web32906.mail.mud.yahoo.com>
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
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


>Yes it is connected to McBSP. McBSP1 in Tsunami board and McBSP2 in
>case of H4. (So more #ifders to select AUDIO_MCBSP :) ).
>  
>
Nice to hear! Can you get some smoke out from the tsc2101 codec and
mixer after adding these extra ifdefs? :-)

Mika
