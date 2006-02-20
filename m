From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 0/7
Date: Mon, 20 Feb 2006 12:58:07 -0800 (PST)
Message-ID: <20060220205807.86025.qmail@web32906.mail.mud.yahoo.com>
References: <9268368b0602201235l185c47e7x5ee72dca146dbadb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9268368b0602201235l185c47e7x5ee72dca146dbadb@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- Daniel Petrini <d.pensator@gmail.com> wrote:

> 
> And BTW, are these codecs connected to McBSP or other serial
> peripheral?

Yes it is connected to McBSP. McBSP1 in Tsunami board and McBSP2 in
case of H4. (So more #ifders to select AUDIO_MCBSP :) ).

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
